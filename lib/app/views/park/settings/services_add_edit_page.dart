import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park_service_additional_dao.dart';
import 'package:app2park/module/config/park_service_additional_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/module/park_service_additional.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park_service_additional_off_model.dart';
import 'package:app2park/moduleoff/park_service_inner_join_service_additional_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class ServiceAddEdit extends StatefulWidget {
  @override
  _ServiceAddEditState createState() => _ServiceAddEditState();
}

class _ServiceAddEditState extends State<ServiceAddEdit> {
  SharedPref sharedPref = SharedPref();
  final _price = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', precision: 2);
  final _ordem = new TextEditingController();
  final _tolerance = new TextEditingController();
  String _time = '00:00:00';
  int id_park;
  Park park = Park();
  bool hab = false;
  bool desa = true;
  ParkServiceInnerJoinServiceAdditionalModel parkJoin;
  var data = new DateTime.now();
  ParkServiceAdditionalDao parkServiceDao = ParkServiceAdditionalDao();

  String nome = '';
  String type = '';

  bool buttonenable = true;
  bool pricenebale = true;
  bool ordemenable = true;

  bool isLoading = false;

  @override
  void initState() {
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
  }

  loadSharedPrefs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      Park p = Park.fromJson(await sharedPref.read("park"));
      ParkServiceInnerJoinServiceAdditionalModel psi =
          ParkServiceInnerJoinServiceAdditionalModel.fromJson(
              await sharedPref.read("servico_selecionado"));
      setState(() {
        parkJoin = psi;
        id_park = int.parse(p.id);

        if (psi.status == null || psi.status == 0) {
          desa = true;
          hab = false;
        } else {
          desa = false;
          hab = true;
        }

        if (parkJoin.price != null) {
          _price.updateValue(parkJoin.price);
        } else {
          _price.text = '0.0';
        }

        if (parkJoin.tolerance.length <= 11) {
          _time = '2020-10-09 ' + parkJoin.tolerance.toString();
        } else {
          _time = parkJoin.tolerance.toString();
        }

        if (parkJoin.sort_order != null) {
          _ordem.text = parkJoin.sort_order.toString();
        }
        nome = parkJoin.name;
        type = parkJoin.type;
      });

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        setState(() {
          ordemenable = true;
          pricenebale = true;
          buttonenable = true;
        });
      } else {
        setState(() {
          ordemenable = false;
          pricenebale = false;
          buttonenable = false;
        });
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION',
          now.toString(), 'ERRO SERVICES ADD EDIT PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Serviços Adicionais Preço'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: isLoading ? isLoadingPage() : _body(context),
    );
  }

  Future<Null> _refreshLocalGallery() async {}

  _body(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refreshLocalGallery,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Serviço : ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      nome,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Veículo : ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      type,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Preço : ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextField(
                  controller: _price,
                  enabled: pricenebale,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.attach_money),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Tolerância (tempo de estacionamento grátis) : ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 4.0,
                  onPressed: () {
                    DatePicker.showTimePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true, onConfirm: (time) {
                      var dateFormat = new DateFormat('yyyy-MM-dd HH:mm:ss');
                      setState(() {
                        _time = dateFormat.format(time);
                      });
                    },
                        currentTime: DateTime.parse(_time),
                        locale: LocaleType.en);
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    size: 18.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    _time.substring(11, 19),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Escolher",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Ordem na tela: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: TextField(
                        autofocus: false,
                        enabled: ordemenable,
                        controller: _ordem,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Status : ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    new Checkbox(
                      value: hab,
                      onChanged: (bool value) {
                        setState(() {
                          hab = value;
                          desa = false;
                        });
                      },
                    ),
                    Text('Habilitado'),
                    new Checkbox(
                      value: desa,
                      onChanged: (bool value) {
                        setState(() {
                          desa = value;
                          hab = false;
                        });
                      },
                    ),
                    Text('Desabilitado'),
                  ],
                ),
                buttonenable == true
                    ? ButtonApp2Park(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });

                          var connectivityResult =
                              await (Connectivity().checkConnectivity());

                          double price = _price.numberValue;
                          int sort_order = int.parse(_ordem.text);
                          int status;
                          if (hab == true) {
                            status = 1;
                          } else {
                            status = 2;
                          }
                          parkServiceDao.updateParkServiceAdditional(
                              parkJoin.id,
                              price,
                              _time.substring(11, 19),
                              status,
                              sort_order);

                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {
                            ParkServiceAdditional parkservice =
                                ParkServiceAdditional();
                            parkservice.id_park = id_park.toString();
                            parkservice.status = status.toString();
                            parkservice.price = price.toString();
                            parkservice.tolerance = _time.substring(11, 19);
                            parkservice.sort_order = sort_order.toString();
                            ParkServiceAdditionalResponse parkres =
                                await ParkService.updateParkServiceAdditional(
                                    parkJoin.id.toString(), parkservice);
                          }
                          setState(() {
                            isLoading = false;
                          });

                          alertModals(
                              context, "Sucesso", "Adicionado com sucesso!");
                        },
                        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
                        text: 'Continuar',
                      )
                    : Container(
                        child: Text(
                            'Você precisa estar conectado a internet para alterar!'),
                      ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tolerância :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text('Tempo livre sem cobrar o estacionamento. '),
                    Text(
                        'Ex.: veículo vai lavar, e pode ficar até 2 horas sem pagar estacionamento.'),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Preço -',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                        'Não é obrigatório, porque alguns serviços precisam de orçamento. Ex,: funilaria'),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ));
  }
}

alertModals(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(ServiceAddViewRoute, (route) => false);
    },
  );

  AlertDialog alerta = AlertDialog(
    title: Text(textTitle),
    content: Text(textCenter),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

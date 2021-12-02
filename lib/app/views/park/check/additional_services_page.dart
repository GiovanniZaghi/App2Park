import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park_service_additional_dao.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/db/dao/ticket_service_additional_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/module/config/ticket_historic_response.dart';
import 'package:app2park/module/config/ticket_service_additional_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/park/ticket/ticket_service_additional_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park_service_inner_join_service_additional_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_off_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_service_additional_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app2park/module/user/User.dart';

class ServiceAdditional extends StatefulWidget {
  @override
  _ServiceAdditionalState createState() => _ServiceAdditionalState();
}

class _ServiceAdditionalState extends State<ServiceAdditional> {
  int id = 0;
  int id_vehicle = 0;
  Park park = Park();
  User user = User();
  SharedPref sharedPref = SharedPref();
  String cupom_checkin_datetime =
      DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();
  TicketsDao ticketsDao = TicketsDao();
  TicketHistoricDao ticketHistoricDao = TicketHistoricDao();
  int id_user;
  int id_park;
  int id_ticket_app;
  int id_ticket = 0;
  int id_cash_app = 0;
  bool isLoading = false;
  String saida = '';
  final _formKey = GlobalKey<FormState>();
  String _time = "0000-00-00 00:00:00";
  String _horaT = "00:00:00";
  var con = Icon(Icons.attach_money);
  String nome = "";
  List<ParkServiceInnerJoinServiceAdditionalModel>
      parkServiceInnerJoinServiceAdditionalList =
      new List<ParkServiceInnerJoinServiceAdditionalModel>();
  ParkServiceAdditionalDao parkServiceAdditionalDao =
      ParkServiceAdditionalDao();
  final _price = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', precision: 2);
  final _tolerance = new TextEditingController();
  final _hora = new TextEditingController();
  final _observation = new TextEditingController();
  TicketServiceAdditionalDao ticketServiceDao = TicketServiceAdditionalDao();
  final _price_justification = new TextEditingController();
  double precoantigo;
  final _precoantigo = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', precision: 2);
  bool tickado = false;
  bool ok;
  String titulo;
  bool visivel;
  bool visi = false;
  int id_ticke = 0;
  PersistentBottomSheetController _Persitentecontroller;

  bool datatable = false;

  loadSharedPrefs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      Park p = Park.fromJson(await sharedPref.read("park"));
      User u = User.fromJson(await sharedPref.read("user"));

      int ids = await sharedPref.read("id_ticket_app");
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        id_ticke = await sharedPref.read("id_ticket");
      }
      setState(() {
        id = int.parse(p.id);
        id_ticket_app = ids;
        id_user = int.parse(u.id);

        print('ID USER ${u.id}');
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          id_ticket = id_ticke;
        }
      });
      parkServiceInnerJoinServiceAdditionalList =
          await parkServiceAdditionalDao.getParkServicesJoin(id);

      setState(() {
        datatable = true;
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO ADDITIONAL SERVICES PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void initState() {
    loadSharedPrefs();
    ok = false;
    // TODO: implement initState
    super.initState();
    _refreshLocalGallery();
  }

  Future<Null> _refreshLocalGallery() async {
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Serviços Adicionais'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshLocalGallery,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Selecione os Serviços Adicionais :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  datatable == true
                      ? DataTable(
                          showCheckboxColumn: true,
                          columns: [
                            DataColumn(
                                label: Text(
                              'Nome:',
                              style: TextStyle(fontSize: 11),
                            )),
                            DataColumn(
                                label: Text(
                              'Preço:',
                              style: TextStyle(fontSize: 11),
                            )),
                            DataColumn(
                                label: Text(
                              'Checked:',
                              style: TextStyle(fontSize: 11),
                            )),
                          ],
                          rows:
                              parkServiceInnerJoinServiceAdditionalList // Loops through dataColumnText, each iteration assigning the value to element
                                  .map(
                                    ((element) => DataRow(
                                          selected:
                                              parkServiceInnerJoinServiceAdditionalList
                                                  .contains(element),
                                          cells: <DataCell>[
                                            DataCell(
                                                Text(
                                                  element.name,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ), onTap: () async {
                                              _price_justification.text = '';
                                              titulo = element.name;
                                              precoantigo = element.price_p;
                                              _precoantigo
                                                  .updateValue(element.price_p);
                                              _price.updateValue(element.price);
                                              _tolerance.text =
                                                  element.tolerance;
                                              visivel = false;
                                              await _dialog(
                                                  context,
                                                  element,
                                                  parkServiceInnerJoinServiceAdditionalList
                                                      .indexWhere((a) =>
                                                          a.id == element.id));
                                              setState(() {
                                                element.price =
                                                    double.parse(_price.text);
                                                element.tolerance =
                                                    _tolerance.text;
                                              });
                                            }),
                                            //Extracting from Map element the value
                                            DataCell(
                                                Text(
                                                    '${NumberFormat.currency(name: '').format(element.price)}'),
                                                onTap: () async {
                                              _price_justification.text = '';
                                              titulo = element.name;
                                              precoantigo = element.price_p;
                                              _precoantigo
                                                  .updateValue(element.price_p);
                                              _price.updateValue(element.price);
                                              _tolerance.text =
                                                  element.tolerance;
                                              visivel = false;
                                              await _dialog(
                                                  context,
                                                  element,
                                                  parkServiceInnerJoinServiceAdditionalList
                                                      .indexWhere((a) =>
                                                          a.id == element.id));
                                              setState(() {
                                                element.price =
                                                    double.parse(_price.text);
                                                element.tolerance =
                                                    _tolerance.text;
                                              });
                                            }),

                                            DataCell(Checkbox(
                                                value: tickado =
                                                    element.tickado == 1
                                                        ? true
                                                        : false,
                                                onChanged: (value) {
                                                  setState(() {
                                                    tickado = value;
                                                    if (tickado == true) {
                                                      element.tickado = 1;
                                                    } else {
                                                      element.tickado = 2;
                                                    }
                                                  });
                                                })),
                                          ],
                                        )),
                                  )
                                  .toList(),
                        )
                      : Container(),
                  SizedBox(
                    height: 15,
                  ),
                  //Text('“Estimativa de Término dos Serviços Adicionais OU Horário que cliente pretende retirar o veículo',style: TextStyle(fontSize: 16,),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /*Text(
                        'Estimativa de saída',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 4.0,
                        onPressed: () {
                          DatePicker.showTimePicker(context,

                              showTitleActions: true,
                              theme: DatePickerTheme(

                                containerHeight: 210.0,
                              ),
                               onConfirm: (time) {

                            _hora.text = '${time.toString().substring(11, 19)}';
                            _horaT = _hora.text;
                            setState(() {});
                          },
                              currentTime: DateTime(0),
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
                                          color: Colors.teal,
                                        ),
                                        Text(
                                          " $_horaT",
                                          style: TextStyle(
                                              color: Colors.teal,
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
                        height: 20,
                      ),*/
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ButtonApp2Park(
                              text: 'Continuar',
                              backgroundColor: Color.fromRGBO(41, 202, 168, 3),
                              onPressed: () async {
                                for (int i = 0;
                                    i <
                                        parkServiceInnerJoinServiceAdditionalList
                                            .length;
                                    i++) {
                                  ParkServiceInnerJoinServiceAdditionalModel
                                      parkService =
                                      parkServiceInnerJoinServiceAdditionalList[
                                          i];

                                  if (parkService.tickado == 1) {
                                    TicketServiceAdditionalOffModel
                                        ticketServiceAdditional =
                                        TicketServiceAdditionalOffModel(
                                            0,
                                            id_ticket,
                                            id_ticket_app,
                                            parkService.id,
                                            parkService.name,
                                            parkService.price,
                                            parkService.tolerance,
                                            _hora.text,
                                            _price_justification.text,
                                            _observation.text,
                                            1);
                                    int id_ticket_service_additional_app =
                                        await ticketServiceDao
                                            .saveTicketServiceAdditional(
                                                ticketServiceAdditional);

                                    var connectivityResult =
                                        await (Connectivity()
                                            .checkConnectivity());

                                    if (connectivityResult ==
                                            ConnectivityResult.mobile ||
                                        connectivityResult ==
                                            ConnectivityResult.wifi) {
                                      TicketServiceAdditionalModel
                                          ticketServiceAdditionalModel =
                                          TicketServiceAdditionalModel();
                                      ticketServiceAdditionalModel
                                              .id_ticket_service_additional_app =
                                          id_ticket_service_additional_app
                                              .toString();
                                      ticketServiceAdditionalModel.id_ticket =
                                          id_ticket.toString();
                                      ticketServiceAdditionalModel
                                              .id_ticket_app =
                                          id_ticket_app.toString();
                                      ticketServiceAdditionalModel
                                              .id_park_service_additional =
                                          parkService.id.toString();
                                      ticketServiceAdditionalModel.name =
                                          parkService.name;
                                      ticketServiceAdditionalModel.price =
                                          parkService.price.toString();
                                      ticketServiceAdditionalModel.tolerance =
                                          parkService.tolerance;
                                      if (_hora.text != '') {
                                        ticketServiceAdditionalModel
                                            .finish_estimate = _hora.text;
                                      }
                                      if (_price_justification.text != '') {
                                        ticketServiceAdditionalModel
                                                .price_justification =
                                            _price_justification.text;
                                      }
                                      if (_observation.text != '') {
                                        ticketServiceAdditionalModel
                                            .observation = _observation.text;
                                      }
                                      ticketServiceAdditionalModel.id_status =
                                          '1';

                                      TicketServiceAdditionalResponse
                                          ticketServiceAdditionalRes =
                                          await TicketService
                                              .createTicketServiceAdditional(
                                                  ticketServiceAdditionalModel);

                                      TicketServiceAdditionalModel
                                          ticketServiceAdditionalModelR =
                                          ticketServiceAdditionalRes.data;


                                      bool ok = await ticketServiceDao
                                          .updateTicketServiceAdditional(
                                              int.parse(
                                                  ticketServiceAdditionalModelR
                                                      .id),
                                              id_ticket_service_additional_app);

                                    }
                                  }
                                }
                                Navigator.of(context)
                                    .pushNamed(CheckTicketOffViewRoute);
                              },
                            ),
                          ),
                          Expanded(
                            child: ButtonApp2Park(
                              onPressed: () async {
                                alertConfirma(context, 'Cancelar entrada', 'Deseja cancelar entrada ?');

                              },
                              text: 'Cancelar Entrada',
                              textStyleApp2Park:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _dialog(context, ParkServiceInnerJoinServiceAdditionalModel element,
      int index) async {
    showMaterialModalBottomSheet(
      expand: false,
      context: context,
      builder: (context, scrollController) => Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Titulo : ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('$titulo')
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Valor pradrão : ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                          ),
                          enabled: false,
                          controller: _precoantigo,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    },
                          child: TextField(
                            controller: _price,
                            autofocus: true,
                            onChanged: (value) {
                              if (_price.numberValue >= precoantigo) {
                                setState(() {
                                  visi = false;
                                });
                              } else {
                                setState(() {
                                  visi = true;
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.attach_money)),
                          ),
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
                        'Tempo de Estacionamento Grátis :',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                          locale: LocaleType.pt);
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
                                      color: Colors.teal,
                                    ),
                                    Text(
                                      " ${_time.substring(11, 19)}",
                                      style: TextStyle(
                                          color: Colors.teal,
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
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Observação',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _observation,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.textsms),
                        hintText: 'Digite a Observação'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: visi,
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Por que baixou o preço?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: visi,
                    child: TextFormField(
                      controller: _price_justification,
                      validator: (value) {
                        if (visi == true) {
                          if (value.length < 5) {
                            return "Esse campo é Obrigatório";
                          }
                          return null;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.textsms),
                          hintText: 'Digite a justificação'),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Visibility(
                    child: Text(
                        "Preencha uma justificação para o valor ser abaixo do valor padrão."),
                    visible: visivel,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ButtonApp2Park(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          ParkServiceInnerJoinServiceAdditionalModel item;
                          item = element;
                          item.price = _price.numberValue;
                          item.tolerance = _tolerance.text;
                          item.tickado = 1;
                          parkServiceInnerJoinServiceAdditionalList
                              .removeAt(index);
                          parkServiceInnerJoinServiceAdditionalList.insert(
                              index, item);
                        });

                        Navigator.pop(context);
                      }
                    },
                    text: 'Salvar',
                    textStyleApp2Park:
                        TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  alertConfirma(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text('Cancelar Entrada'),
      onPressed: () async{
        var connectivityResult = await (Connectivity()
            .checkConnectivity());

        TicketHistoricOffModel
        ticketHistoricOffModel =
        TicketHistoricOffModel(
            0,
            0,
            id_ticket_app,
            11,
            id_user,
            0,
            0,
            saida);

        int id_ticket_historic =
        await ticketHistoricDao
            .saveTicketHistoric(
            ticketHistoricOffModel);

        if (connectivityResult ==
            ConnectivityResult.mobile ||
            connectivityResult ==
                ConnectivityResult.wifi) {
          TicketHistoricModel ticketHistoric =
          TicketHistoricModel();
          ticketHistoric.id_ticket_historic_status =
          '11';
          ticketHistoric.id_ticket_historic_app =
              id_ticket_historic.toString();
          ticketHistoric.id_ticket =
              id_ticket.toString();
          ticketHistoric.id_ticket_app =
              id_ticket_app.toString();
          ticketHistoric.id_user = id_user.toString();
          ticketHistoric.date_time =
              cupom_checkin_datetime;

          TicketHistoricResponse ticketHRes =
          await TicketService
              .createTicketHistoric(
              ticketHistoric);

          if (ticketHRes.status == 'COMPLETED') {
            TicketHistoricModel ticketHis =
                ticketHRes.data;

            bool ok = await ticketHistoricDao
                .updateTicketHistoricIdOn(
                int.parse(ticketHis.id),
                id_ticket,
                id_ticket_historic);

          }
        }
        Navigator.of(context)
            .pushNamed(HomeParkViewRoute);


      },
    );
    Widget exitButton = FlatButton(
      child: Text('Voltar'),
      onPressed: () async{
          Navigator.of(context).pop();


      },
    );

    AlertDialog alerta = AlertDialog(
      title: Text(textTitle),
      content: Text(textCenter),
      actions: [
        okButton,
        exitButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}

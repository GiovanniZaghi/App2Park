import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park_service_additional_dao.dart';
import 'package:app2park/db/dao/payment/payment_method_park_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_inner_join_payment_method_park_model.dart';
import 'package:app2park/moduleoff/park_service_inner_join_service_additional_model.dart';
import 'package:app2park/moduleoff/service_additional_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:dart_extensions/dart_extensions.dart';

class ServiceAdd extends StatefulWidget {
  @override
  _ServiceAddState createState() => _ServiceAddState();
}

class _ServiceAddState extends State<ServiceAdd> {
  String _time = "Not set";
  final _hora = new MaskedTextController(mask: '00:00');
  var con = Icon(Icons.attach_money);
  int id = 0;
  Park park = Park();
  SharedPref sharedPref = SharedPref();
  String nome = "";
  List<ParkServiceInnerJoinServiceAdditionalModel>
      parkServiceInnerJoinServiceAdditionalList =
      new List<ParkServiceInnerJoinServiceAdditionalModel>();
  ParkServiceAdditionalDao parkServiceAdditionalDao = ParkServiceAdditionalDao();

  bool datatable = false;

  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        id = int.parse(p.id);
      });
      parkServiceInnerJoinServiceAdditionalList =
          await parkServiceAdditionalDao.getParkServiceAdditionalInnerJoin(id);
      parkServiceInnerJoinServiceAdditionalList = parkServiceInnerJoinServiceAdditionalList.distinctBy((selector) => selector.id);

      setState(() {
        datatable = true;
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO SERVICES ADD  PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void initState() {
    _refreshLocalGallery();
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
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
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeParkViewRoute, (route) => false);
        }),
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
                    'Selecione um item abaixo para editá-lo:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          '- O campo preço deve ser editável, caso haja alguma negociação com o cliente )'),
                    ],
                  ),
                  datatable == true ? DataTable(
                    showCheckboxColumn: true,
                    sortAscending: true,
                    onSelectAll: (b) {
                      Navigator.of(context).pushNamed(HomeParkViewRoute);
                    },
                    columns: [
                      DataColumn(
                          label: Text(
                            'Serviço',
                            style: TextStyle(),
                          )),
                      DataColumn(label: Text('Veículo')),
                      DataColumn(
                          label: Text(
                            'Status',
                            style: TextStyle(),
                          )),
                      DataColumn(label: Text('Preço')),
                    ],
                    rows:
                    parkServiceInnerJoinServiceAdditionalList // Loops through dataColumnText, each iteration assigning the value to element
                        .map(
                      ((element) => DataRow(

                        cells: <DataCell>[
                          DataCell(
                            Text(element.name,style: TextStyle(fontSize: 11),),
                            onTap: (){
                              sharedPref.remove("servico_selecionado");
                              sharedPref.save("servico_selecionado", element);
                              Navigator.of(context).pushNamed(ServiceAddEditViewRoute);
                            },
                          ),
                          //Extracting from Map element the value
                          DataCell(Text(element.type), onTap: (){
                            sharedPref.remove("servico_selecionado");
                            sharedPref.save("servico_selecionado", element);
                            Navigator.of(context).pushNamed(ServiceAddEditViewRoute);
                          },),
                          DataCell(Text(element.status == null || element.status == 0 ? 'Inativo' : 'Ativo'), onTap: (){
                            sharedPref.remove("servico_selecionado");
                            sharedPref.save("servico_selecionado", element);
                            Navigator.of(context).pushNamed(ServiceAddEditViewRoute);
                          },),
                          DataCell(Text(NumberFormat.currency(name: '').format(element.price) == null ? '0.0' : NumberFormat.currency(name: '').format(element.price)), onTap: (){
                            sharedPref.remove("servico_selecionado");
                            sharedPref.save("servico_selecionado", element);
                            Navigator.of(context).pushNamed(ServiceAddEditViewRoute);
                          },),
                        ],
                      )),
                    )
                        .toList(),
                  ) : Container(),
                  SizedBox(
                    height: 15,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  alertModals(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pushNamed(HomeParkViewRoute);
      },
    );

    AlertDialog alerta = AlertDialog(
      title: Text(textTitle),
      contentPadding: EdgeInsets.all(8.0),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Preço'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        onTimerDurationChanged: (data) {},
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Observações:'),
                  Expanded(
                    child: TextField(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
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
}

import 'dart:async';

import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/agreement/agreement_dao.dart';
import 'package:app2park/db/dao/customers_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/vehicle_customer_dao.dart';
import 'package:app2park/db/dao/vehicles_dao.dart';
import 'package:app2park/module/config/VehicleResponse.dart';
import 'package:app2park/module/config/vehicle_cust_response.dart';
import 'package:app2park/module/customers_model.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/vehicle/Vehicle.dart';
import 'package:app2park/module/park/vehicle/service/VehicleService.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/module/vehicles/vehicle_customer_model.dart';
import 'package:app2park/moduleoff/agreements/agreements_off_model.dart';
import 'package:app2park/moduleoff/customer/customers_off_model.dart';
import 'package:app2park/moduleoff/customer_app_ss.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/parked_vehicles.dart';
import 'package:app2park/moduleoff/ticket/ticket_off_leftjoin_model.dart';
import 'package:app2park/moduleoff/vehicle_app_ss.dart';
import 'package:app2park/moduleoff/vehicle_customer_off_model.dart';
import 'package:app2park/moduleoff/vehicles/vehicles_off_model.dart';
import 'package:app2park/moduleoff/verifiy_plate_exists_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditOptions extends StatefulWidget {
  @override
  _EditOptions createState() => _EditOptions();
}

class _EditOptions extends State<EditOptions> {
  Timer _timer;
  SharedPref sharedPref = SharedPref();
  String placa = '';
  String modelo = '';
  String cor = '';
  String fabricante = '';
  String cupom_checkin_datetime =
      DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();
  Park park = Park();
  User userLoad = User();
  int vehicle_id_app;
  var data = new DateTime.now();
  AgreementsDao agreementDao = AgreementsDao();
  TicketHistoricDao ticketHistoricDao = TicketHistoricDao();
  VehiclesDao vehicleDao = VehiclesDao();
  List<AgreementsOff> agreementsList;
  List<VerifyPlateExitsModel> verifyExitList;
  String tipo = "Avulso";
  bool mensalista = false;
  bool avulso = true;
  List<String> errorList = List<String>();
  int id_contrato = 0;
  bool entrou = false;
  bool estacionado = false;
  int id_contrato_serv = 0;
  int id_vehicle_app = 0;
  int id_vehicle_create = 0;
  int id_vehicle = 0;
  int id_ticket = 0;
  bool carregando = false;
  bool mostrarMsg = false;
  TicketsDao _ticketsDao = TicketsDao();
  List<TicketsOffLeftJoinModel> TicketLeftJoin;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    _timer = Timer(Duration(milliseconds: 4000), () {
      setState(() {
        carregando = true;
      });
    });
  }

  loadSharedPrefs() async {
    try {
      Park ps = Park.fromJson(await sharedPref.read("park"));
      User user = User.fromJson(await sharedPref.read("user"));
      int id_ticket_app = await sharedPref.read("id_ticket_app");
      print('ID TI $id_ticket_app');
      int id_cupom = await sharedPref.read("id_cupom");
      print('ID CU $id_cupom');
      TicketLeftJoin = await _ticketsDao.getTicketByIdTicketIdCupom(id_ticket_app, id_cupom);
      print("LISTA ${TicketLeftJoin.first.id_cupom}");
      setState(() {
        vehicle_id_app = vehicle_id_app;
        park = ps;
        userLoad = user;


      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Editar Ticket",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(EntryOptionsServiceViewRoute);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Serviços adicionais',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(EntryOptionsObjectViewRoute);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Objetos deixados no veículo',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(EntryOptionsCamViewRoute);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Fotos do veículo',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(EntryOptionsCustomerViewRoute);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Motorista',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ButtonApp2Park(
                  text: 'Finalizar ',
                  onPressed: () async {
                    Navigator.of(context).pushNamed(CheckTicketOffViewRoute);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

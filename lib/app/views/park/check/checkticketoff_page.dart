import 'dart:async';

import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park/ParkDao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/vehicles_dao.dart';
import 'package:app2park/module/config/ticket_online_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/ticket/send_ticket_model.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_online_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/ParkOff.dart';
import 'package:app2park/moduleoff/ticket/TicketOff.dart';
import 'package:app2park/moduleoff/ticket/tickets_off_model.dart';
import 'package:app2park/moduleoff/vehicles/vehicles_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CheckTicketOffPage extends StatefulWidget {
  @override
  _CheckTicketOffPageState createState() => _CheckTicketOffPageState();
}

class _CheckTicketOffPageState extends State<CheckTicketOffPage> {
  Timer _timer;
  SharedPref sharedPref = SharedPref();
  int id_ticket_app = 0;
  int id_ticket = 0;
  TicketsOffModel ticketOffModel;
  TicketsDao ticketsDao = TicketsDao();
  ParkDao parkDao = ParkDao();
  VehiclesDao vehicleDao = VehiclesDao();
  VehiclesOffModel vehiclesOffModel;
  ParkOff parkOff;
  int id_cupom;
  String data_entrada;
  String nome_estacionamento;
  String placa;
  String data;
  bool carregando = false;
  int id_ticke = 1;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    _timer = Timer(Duration(milliseconds: 500), () {
      setState(() {
        carregando = true;
      });
    });
  }

  loadSharedPrefs() async {
    try {

      var connectivityResult =
      await (Connectivity().checkConnectivity());

      int id = await sharedPref.read("id_ticket_app");
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
         id_ticke =  await sharedPref.read("id_ticket") ?? 1;
      }
      TicketsOffModel ticketsModel = await ticketsDao.getTicketByIdTicketApp(id);
      ParkOff parkof = await parkDao.getParksByIdPark(ticketsModel.id_park);
      VehiclesOffModel vehicle = await vehicleDao.getVehicleById(ticketsModel.id_vehicle_app ?? 1);

      setState(() {
        id_ticket_app = id;
        ticketOffModel = ticketsModel;
        vehiclesOffModel = vehicle;
        parkOff = parkof;
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          id_ticket = id_ticke;
        }
        id_cupom = ticketsModel.id_cupom;
        data_entrada = ticketsModel.cupom_entrance_datetime;
        nome_estacionamento = parkof.name_park;
        placa = vehicle.plate;
        data = "app2park.com.br/ticket.php";
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          data = "app2park.com.br/ticket.php?id=${id_ticke}&cupom=${ticketsModel.id_cupom}";
        }else{
          data = "app2park.com.br/ticket.php?id_app=${id}&cupom=${ticketsModel.id_cupom}&park=${ticketsModel.id_park}";
        }
      });

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        if(vehicle.id != 0){
          SendTicketModelModel ticketsend = SendTicketModelModel();
          ticketsend.id_ticket = id_ticke.toString();

          TicketOnlineResponse ticketOnlineRes = await TicketService.SendTicket(ticketsend);

          TicketOnlineModel ticketOnlineModel = ticketOnlineRes.data;


        }
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO TICKET OFF PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeParkViewRoute, (Route<dynamic> route) => false);
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text(
            "CUPOM ",
          ),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
        ),
        body: carregando ? _body(context) : isLoadingPage(),
      ),
    );
  }

  _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height /1,
      width: MediaQuery.of(context).size.width /1,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
            children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Image.asset(
                    "assets/img/logo-app2park.png",
                    width: 150,
                    height: 100,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Cupom: ${id_cupom}",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Placa: ${placa}",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Entrada: ${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(data_entrada))}",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Estac: ${nome_estacionamento}",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Text(
                      '$data',
                      style: TextStyle(fontSize: 10),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 200,
                    child: QrImage(
                      data: '$data',
                      version: 8,
                      gapless: true,
                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonApp2Park(
                    text: 'Imprimir Cupom \n(Impressora Interna) \n ',
                    onPressed: (){
                      Navigator.of(context).pushNamed(CupomPrintPageViewRoute);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonApp2Park(
                    text: 'Voltar',
                    onPressed: (){
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeParkViewRoute, (Route<dynamic> route) => false);
                    },
                  )
                ],
              ),


            ],
          ),
        ]),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        HomeParkViewRoute, (Route<dynamic> route) => false);
  }
}

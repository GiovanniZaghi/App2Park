import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_dao.dart';
import 'package:app2park/module/config/TicketResponse.dart';
import 'package:app2park/module/config/ticket_historic_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/ticket/Ticket.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/park/vehicle/vehicle_type_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/exit_join_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_inner_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntrySelectPrice extends StatefulWidget {
  @override
  _EntrySelectPriceState createState() => _EntrySelectPriceState();
}

class _EntrySelectPriceState extends State<EntrySelectPrice> {
  var con = Icon(Icons.attach_money);
  int id = 0;
  int id_vehicle = 0;
  Park park = Park();
  SharedPref sharedPref = SharedPref();
  String nome = "";
  List<PriceDetachedInnerJoinOff>
  priceDetachedInnerJoinOffList =
  new List<PriceDetachedInnerJoinOff>();
  List<ExitJoinModel> exitJoinList;
  TicketsDao ticketsDao = TicketsDao();
  PriceDetachedDao dao = new PriceDetachedDao();
  User userLoad = User();
  String plate = '';
  String modelo = '';
  String type = '';
  String entrada = '';
  int id_ticke = 0;
  int id_ticket = 0;
  int id_ticket_app = 0;
  var tempoEntrada;
  String cupom_checkin_datetime = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();

  bool datatable = false;

  String permanence;



  loadSharedPrefs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      Park p = Park.fromJson(await sharedPref.read("park"));
      User user = User.fromJson(await sharedPref.read("user"));
      int v = await sharedPref.read("id_vehicle");
      String ent = await sharedPref.read("entrada");
      String mod = await sharedPref.read("model");
      String ty = await sharedPref.read("type");
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        id_ticke = await sharedPref.read("id_ticket");
      }
      int id_t = await sharedPref.read("id_ticket_app");
      setState(() {
        id = int.parse(p.id);
        userLoad = user;
        id_vehicle = v;
        modelo = mod;
        type = ty;

        id_ticket_app = id_t;
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          id_ticket = id_ticke;
        }

      });
      int id_cupom = int.parse(await sharedPref.read("exitcar"));
      priceDetachedInnerJoinOffList =
      await dao.getOrderPriceInnerJoin(id_vehicle, id);
      for (int i = 0;
      i < priceDetachedInnerJoinOffList.length;
      i++) {
        PriceDetachedInnerJoinOff
        priceDetachedInnerJoinOff =
        priceDetachedInnerJoinOffList[i];

      }
      setState(() {
        datatable = true;
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO EXIT SELECT PRICE PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void initState() {
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabela de preço'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Selecione uma tabela de preço ', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ),),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              datatable == true ? DataTable(

                showCheckboxColumn: true,
                columns: [
                  DataColumn(label: Text('Tipo', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),)),
                  DataColumn(label: Text('Nome', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),)),
                ],
                rows:
                priceDetachedInnerJoinOffList // Loops through dataColumnText, each iteration assigning the value to element
                    .map(
                  ((element) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(element.type), onTap: () async {
                        sharedPref.remove("id_price_detached_app");
                        sharedPref.save("id_price_detached_app", element.id_price_detached_app);
                        sharedPref.remove("nametable");
                        sharedPref.save("nametable", element.name);
                        sharedPref.remove("diaria");
                        sharedPref.save("diaria", element.daily_start);
                        var connectivityResult =
                        await (Connectivity().checkConnectivity());

                        TicketsDao ticketsDao = TicketsDao();
                        ticketsDao.updateTicketsPrice(element.id_price_detached_app, id_ticket_app);

                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {

                          Ticket ticket = Ticket();
                          ticket.id_price_detached = element.id.toString();
                          ticket.id_price_detached_app = element.id_price_detached_app.toString();

                          TicketResponse ticketRes = await TicketService.updateTicketOn(ticket, id_ticket);

                          Ticket ticker = ticketRes.data;

                          bool ok = await ticketsDao.updateTicketsIdOn(
                              int.parse(ticker.id), id_ticket_app);


                        }

                        TicketHistoricDao ticketHistoricDao = TicketHistoricDao();
                        int id_user = int.tryParse(userLoad.id ?? '1');
                        TicketHistoricOffModel ticketsHistoricModel = TicketHistoricOffModel(0, 0, id_ticket_app, 2, id_user, 0, 0, cupom_checkin_datetime);
                        int id_historic_status = await ticketHistoricDao.saveTicketHistoric(ticketsHistoricModel);
                        sharedPref.save("id_historic_app", id_historic_status);

                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {

                          TicketHistoricModel ticketHistoric = TicketHistoricModel();
                          ticketHistoric.id_ticket_historic_app = id_historic_status.toString();
                          ticketHistoric.id_ticket = id_ticket.toString();
                          ticketHistoric.id_ticket_app = id_ticket_app.toString();
                          ticketHistoric.id_user = id_user.toString();
                          ticketHistoric.id_ticket_historic_status = '2';
                          ticketHistoric.date_time = cupom_checkin_datetime;

                          TicketHistoricResponse ticketHRes = await TicketService.createTicketHistoric(ticketHistoric);

                          TicketHistoricModel ticketHis = ticketHRes.data;

                          bool ok = await ticketHistoricDao.updateTicketHistoricIdOn(int.parse(ticketHis.id), id_ticket, id_historic_status);


                          sharedPref.save("id_historic", int.parse(ticketHis.id));
                        }
                        Navigator.of(context)
                            .pushNamed(EntryOptionsViewRoute);
                      }),
                      //Extracting from Map element the value
                      DataCell(Text(element.name), onTap: () async{
                        sharedPref.remove("id_price_detached_app");
                        sharedPref.save("id_price_detached_app", element.id_price_detached_app);
                        sharedPref.remove("nametable");
                        sharedPref.save("nametable", element.name);
                        sharedPref.remove("diaria");
                        sharedPref.save("diaria", element.daily_start);
                        var connectivityResult =
                        await (Connectivity().checkConnectivity());

                        TicketsDao ticketsDao = TicketsDao();
                        ticketsDao.updateTicketsPrice(element.id_price_detached_app, id_ticket_app);

                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {

                          Ticket ticket = Ticket();
                          ticket.id = id_ticket.toString();
                          ticket.id_price_detached = element.id.toString();
                          ticket.id_price_detached_app = element.id_price_detached_app.toString();




                          TicketResponse ticketRes = await TicketService.updateTicketOn(ticket, id_ticket);

                          Ticket ticker = ticketRes.data;

                          bool ok = await ticketsDao.updateTicketsIdOn(
                              int.parse(ticker.id), id_ticket_app);


                        }

                        TicketHistoricDao ticketHistoricDao = TicketHistoricDao();
                        int id_user = int.tryParse(userLoad.id ?? '1');
                        TicketHistoricOffModel ticketsHistoricModel = TicketHistoricOffModel(0, 0, id_ticket_app, 2, id_user, 0, 0, cupom_checkin_datetime);
                        int id_historic_status = await ticketHistoricDao.saveTicketHistoric(ticketsHistoricModel);
                        sharedPref.save("id_historic_app", id_historic_status);

                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {

                          TicketHistoricModel ticketHistoric = TicketHistoricModel();
                          ticketHistoric.id_ticket_historic_app = id_historic_status.toString();
                          ticketHistoric.id_ticket = id_ticket.toString();
                          ticketHistoric.id_ticket_app = id_ticket_app.toString();
                          ticketHistoric.id_user = id_user.toString();
                          ticketHistoric.id_ticket_historic_status = '2';
                          ticketHistoric.date_time = cupom_checkin_datetime;

                          TicketHistoricResponse ticketHRes = await TicketService.createTicketHistoric(ticketHistoric);

                          TicketHistoricModel ticketHis = ticketHRes.data;

                          bool ok = await ticketHistoricDao.updateTicketHistoricIdOn(int.parse(ticketHis.id), id_ticket, id_historic_status);


                          sharedPref.save("id_historic", int.parse(ticketHis.id));
                        }
                        Navigator.of(context)
                            .pushNamed(EntryOptionsViewRoute);
                      }),

                    ],
                  )),
                )
                    .toList(),
              ) : Container(),
            ],
          ),
        )
    );
  }
}
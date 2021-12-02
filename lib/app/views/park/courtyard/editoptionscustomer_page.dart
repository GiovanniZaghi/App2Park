import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/vehicle_customer_dao.dart';
import 'package:app2park/module/config/TicketResponse.dart';
import 'package:app2park/module/config/ticket_historic_response.dart';
import 'package:app2park/module/park/ticket/Ticket.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_off_model.dart';
import 'package:app2park/moduleoff/vehicle_inner_join_customer_model.dart';
import 'package:app2park/moduleoff/vehicles/vehicles_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class EditOptionsCustomer extends StatefulWidget {
  @override
  _EditOptionsCustomerState createState() => _EditOptionsCustomerState();
}
class _EditOptionsCustomerState extends State<EditOptionsCustomer> {
  SharedPref sharedPref = SharedPref();
  VehiclesOffModel vehicleOff;
  User userLoad = User();
  int id_vehicle_app = 0;
  int id_ticket_app = 0;
  int id_ticket = 0;
  int id_ticke = 0;
  String cupom_checkin_datetime = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {

      var connectivityResult = await (Connectivity().checkConnectivity());

      VehiclesOffModel vehicle = VehiclesOffModel.fromJson(await sharedPref.read("vehicle"));
      User user = User.fromJson(await sharedPref.read("user"));
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        id_ticke = await sharedPref.read("id_ticket");
      }
      int id = await sharedPref.read("id_ticket_app");
      setState(() {
        userLoad = user;
        id_ticket_app = id;
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          id_ticket = id_ticke;
        }
        vehicleOff = vehicle;
        id_vehicle_app = vehicle.id_vehicle_app;
      });
    } catch (e) {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cliente'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }
  _body(context) {
    VehicleCustomerDao vehicleCustomerDao = VehicleCustomerDao();
    Future<List<VehicleInnerJoinCustomer>> data = vehicleCustomerDao.getCustomersJoinVehicles(id_vehicle_app);
    return Container(
      child: FutureBuilder<List<VehicleInnerJoinCustomer>>(
        future: data,
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return Text("Clique em adicionar um novo para criar um novo cliente.");
              break;
            case ConnectionState.waiting:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Loading..."),
                ],
              );
              break;
            case ConnectionState.active:
              return Text("Zero encontrados");
              break;
            case ConnectionState.done:
              List<VehicleInnerJoinCustomer> list = snapshot.data;
              if(snapshot.data == null){
                return Text("Zero encontrados");
              }else{
                return Container(

                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Text(r"Selecione um cliente abaixo ou clique no botão criar um novo",style: TextStyle(fontSize: 22,),),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              VehicleInnerJoinCustomer Type = list[index];
                              print(Type.toJson());
                              if(Type != null){
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: InkWell(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Row(
                                          children: <Widget>[
                                            Text("Email : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                            Text('${Type.email}',style: TextStyle(fontSize: 18),),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text("Celular : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                            Text('${Type.cell}',style: TextStyle(fontSize: 18),)
                                          ],
                                        ),
                                      ],
                                    ),
                                    onTap: ()async {
                                      var connectivityResult =
                                      await (Connectivity().checkConnectivity());

                                      TicketsDao ticketsDao = TicketsDao();
                                      ticketsDao.updateTicketsCustomers(Type.id_customer_app, id_ticket_app);

                                      if (connectivityResult == ConnectivityResult.mobile ||
                                          connectivityResult == ConnectivityResult.wifi) {

                                        print("ID_TICKE $id_ticket");
                                        Ticket ticket = Ticket();
                                        ticket.id = id_ticket.toString();
                                        ticket.id_customer = Type.id.toString();
                                        ticket.id_customer_app = Type.id_customer_app.toString();

                                        TicketResponse ticketRes = await TicketService.updateTicketOn(ticket, id_ticket);

                                        Ticket ticker = ticketRes.data;

                                        bool ok = await ticketsDao.updateTicketsIdOn(
                                            int.parse(ticker.id), id_ticket_app);

                                        print(ok);

                                      }

                                      TicketHistoricDao ticketHistoricDao = TicketHistoricDao();
                                      int id_user = int.tryParse(userLoad.id ?? '1');
                                      TicketHistoricOffModel ticketsHistoricModel = TicketHistoricOffModel(0, 0, id_ticket_app, 2, id_user, 0, 0, cupom_checkin_datetime);
                                      int id_historic_status = await ticketHistoricDao.saveTicketHistoric(ticketsHistoricModel);
                                      print(id_historic_status);
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

                                        print(ok);

                                        sharedPref.save("id_historic", int.parse(ticketHis.id));
                                      }

                                      Navigator.of(context).pushNamed(EntryOptionsViewRoute);
                                    },
                                  ),
                                );
                              }
                              return Text("Adiciona um novo motorista clicando no botão +");
                            },
                            itemCount: list.length,
                          ),
                        ),
                        SizedBox(height: 20,),
                        ButtonApp2Park(
                          text: 'Não informado',
                          onPressed: () async{
                            var connectivityResult =
                            await (Connectivity().checkConnectivity());

                            TicketsDao ticketsDao = TicketsDao();
                            ticketsDao.updateTicketsCustomers(1, id_ticket_app);

                            if (connectivityResult == ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {

                              print(id_ticket);
                              Ticket ticket = Ticket();
                              ticket.id = id_ticket.toString();
                              ticket.id_customer = '1';
                              ticket.id_customer_app = '1';

                              TicketResponse ticketRes = await TicketService.updateTicketOn(ticket, id_ticket);

                              Ticket ticker = ticketRes.data;

                              bool ok = await ticketsDao.updateTicketsIdOn(
                                  int.parse(ticker.id), id_ticket_app);

                              print(ok);

                            }

                            TicketHistoricDao ticketHistoricDao = TicketHistoricDao();
                            int id_user = int.tryParse(userLoad.id ?? '1');
                            TicketHistoricOffModel ticketsHistoricModel = TicketHistoricOffModel(0, 0, id_ticket_app, 2, id_user, 0, 0, cupom_checkin_datetime);
                            int id_historic_status = await ticketHistoricDao.saveTicketHistoric(ticketsHistoricModel);
                            print(id_historic_status);
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

                              print(ok);

                              sharedPref.save("id_historic", int.parse(ticketHis.id));
                            }

                            Navigator.of(context).pushNamed(EntryOptionsViewRoute);
                          },
                        ),
                        SizedBox(height: 20,),
                        ButtonApp2Park(
                          text: 'Criar um novo',
                          onPressed: (){
                            Navigator.of(context).pushNamed(EntryOptionsCreateCustomerViewRoute);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              break;
          }
          // By default, show a loading spinner.
          return Text("Zero encontrados");
        },
      ),
    );
  }
}
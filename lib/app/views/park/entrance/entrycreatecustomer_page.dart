import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/customers_dao.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/vehicle_customer_dao.dart';
import 'package:app2park/module/config/CustomerResponse.dart';
import 'package:app2park/module/config/TicketResponse.dart';
import 'package:app2park/module/config/ticket_historic_response.dart';
import 'package:app2park/module/config/vehicle_customer_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/customer/Customer.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/module/park/ticket/Ticket.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/module/vehicles/vehicle_customer_model.dart';
import 'package:app2park/moduleoff/customer/customers_off_model.dart';
import 'package:app2park/moduleoff/ticket/TicketOff.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_off_model.dart';
import 'package:app2park/moduleoff/ticket/tickets_off_model.dart';
import 'package:app2park/moduleoff/vehicle_customer_off_model.dart';
import 'package:app2park/moduleoff/vehicles/vehicles_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class EntryCreateCustomer extends StatefulWidget {
  @override
  _EntryCreateCustomerState createState() => _EntryCreateCustomerState();
}

class _EntryCreateCustomerState extends State<EntryCreateCustomer> {
  final _cell = new MaskedTextController(mask: '(00)00000-0000');
  final _email = new TextEditingController();
  var data = new DateTime.now();
  SharedPref sharedPref = SharedPref();
  VehiclesOffModel vehicleOff;
  int id_vehicle = 0;
  int id_vehicle_app = 0;
  int id_ticket_app = 0;
  int id_ticket = 0;
  User userLoad = User();
  int id_customer = 0;
  int id_customer_app = 0;
  int id_ticke =0;
  int id_vs = 0;
  bool isLoading = false;
  String cupom_checkin_datetime =
  DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();

  @override
  void initState() {
    loadSharedPrefs();
    super.initState();
  }

  loadSharedPrefs() async {
    try {

      var connectivityResult = await (Connectivity().checkConnectivity());

      VehiclesOffModel vehicle =
      VehiclesOffModel.fromJson(await sharedPref.read("vehicle"));
      User user = User.fromJson(await sharedPref.read("user"));
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        id_ticke =  await sharedPref.read("id_ticket");
        id_vs = await sharedPref.read("id_vehicle_ons");
      }
      int id = await sharedPref.read("id_ticket_app");
      setState(() {
        vehicleOff = vehicle;
        id_vehicle_app = vehicle.id_vehicle_app;
        userLoad = user;
        id_ticket_app = id;
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          id_ticket = id_ticke;
          id_vehicle = id_vs;
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Cliente'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(

          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Como deseja enviar o cupom ?",
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text('Telefone : ', style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
            TextField(
              controller: _cell,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                  hintText: 'Digite o telefone',
                  suffixIcon: Icon(Icons.phone)
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Ou',style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(
              height: 15,

            ),
            Text("Email : ", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Digite o email',
                  suffixIcon: Icon(Icons.mail)),
            ),
            SizedBox(
              height: 25,
            ),
            isLoading ? Row(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text('Carregando..')
              ],
            ) : ButtonApp2Park(
              text: 'Continuar',
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                CustomersDao customersDao = CustomersDao();
                CustomersOffModel customersOffModel;

                customersOffModel =
                    CustomersOffModel(0, _cell.text, _email.text, "", "", 1);


                id_customer_app =
                await customersDao.saveCustomers(customersOffModel);


                var connectivityResult =
                await (Connectivity().checkConnectivity());

                if (connectivityResult == ConnectivityResult.mobile ||
                    connectivityResult == ConnectivityResult.wifi) {
                  Customer customer = Customer();
                  customer.id_customer_app = id_customer_app.toString();
                  customer.cell = _cell.text;
                  customer.email = _email.text;
                  CustomerResponse customerRes =
                  await ParkService.insertCustomer(customer);


                  Customer customerResposta = await customerRes.data.first;

                  customersDao.updateCustomers(
                      int.parse(customerResposta.id), id_customer_app);

                  id_customer = await int.parse(customerResposta.id);
                }

                VehicleCustomerDao vehicleCustomerDao = VehicleCustomerDao();
                VehicleCustomerOffModel vehicleCustomerOffModel =
                VehicleCustomerOffModel(
                    0, 0, id_customer_app, 0, id_vehicle_app);

                int id_vehicle_customer = await vehicleCustomerDao
                    .saveVehicleCustomer(vehicleCustomerOffModel);


                if (connectivityResult == ConnectivityResult.mobile ||
                    connectivityResult == ConnectivityResult.wifi) {
                  if (id_vehicle != 0 && id_customer != 0) {

                    VehicleCustomerModel vehicleCustomerModel =
                    VehicleCustomerModel();
                    vehicleCustomerModel.id_vehicle_customer_app =
                        id_vehicle_customer.toString();
                    vehicleCustomerModel.id_customer = id_customer.toString();
                    vehicleCustomerModel.id_customer_app =
                        id_customer_app.toString();
                    vehicleCustomerModel.id_vehicle = id_vehicle.toString();
                    vehicleCustomerModel.id_vehicle_app =
                        id_vehicle_app.toString();

                    VehicleCustomerResponse vehicleCustomerRes =
                    await ParkService.insertVehicleCustomer(
                        vehicleCustomerModel);

                    VehicleCustomerModel vehicleCmodel =
                        vehicleCustomerRes.data.first;

                    bool ok = await vehicleCustomerDao.updateVehicleCustomer(
                        int.parse(vehicleCmodel.id), id_vehicle_customer);

                  }
                }


                TicketsDao ticketsDao = TicketsDao();
                bool ok = await ticketsDao.updateTicketsCustomers(
                    id_customer_app, id_ticket_app);


                if (connectivityResult == ConnectivityResult.mobile ||
                    connectivityResult == ConnectivityResult.wifi) {

                  Ticket ticket = Ticket();
                  ticket.id = id_ticket.toString();
                  ticket.id_customer = id_customer.toString();
                  ticket.id_customer_app = id_customer_app.toString();

                  TicketResponse ticketRes = await TicketService.updateTicketOn(ticket, id_ticket);

                  Ticket ticker = ticketRes.data;

                  bool ok = await ticketsDao.updateTicketsIdOn(
                      int.parse(ticker.id), id_ticket_app);


                }

                TicketHistoricDao ticketHistoricDao = TicketHistoricDao();

                int id_user = int.tryParse(userLoad.id?? '1');

                TicketHistoricOffModel ticketsHistoricModel =
                TicketHistoricOffModel(0, 0, id_ticket_app, 2, id_user, 0,
                    0, cupom_checkin_datetime);

                int id_historic_status = await ticketHistoricDao
                    .saveTicketHistoric(ticketsHistoricModel);


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

                Navigator.of(context).pushNamedAndRemoveUntil(CheckObjectViewRoute, (route) => false);
              },
              color: Color.fromRGBO(41, 202, 168, 3),
            ),
          ],
        ),
      ),
    );
  }
}

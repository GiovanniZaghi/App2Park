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
import 'package:app2park/module/config/TicketResponse.dart';
import 'package:app2park/module/config/VehicleResponse.dart';
import 'package:app2park/module/config/ticket_historic_response.dart';
import 'package:app2park/module/config/vehicle_cust_response.dart';
import 'package:app2park/module/customers_model.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/module/park/ticket/Ticket.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/park/vehicle/Vehicle.dart';
import 'package:app2park/module/park/vehicle/service/VehicleService.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/module/vehicles/vehicle_customer_model.dart';
import 'package:app2park/moduleoff/agreements/agreements_off_model.dart';
import 'package:app2park/moduleoff/customer/customers_off_model.dart';
import 'package:app2park/moduleoff/customer_app_ss.dart';
import 'package:app2park/moduleoff/exit_join_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/parked_vehicles.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_off_model.dart';
import 'package:app2park/moduleoff/ticket/tickets_off_model.dart';
import 'package:app2park/moduleoff/vehicle_app_ss.dart';
import 'package:app2park/moduleoff/vehicle_customer_off_model.dart';
import 'package:app2park/moduleoff/vehicles/vehicles_off_model.dart';
import 'package:app2park/moduleoff/verifiy_plate_exists_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class CheckDataOffPage extends StatefulWidget {
  @override
  _CheckDataOffPageState createState() => _CheckDataOffPageState();
}

class _CheckDataOffPageState extends State<CheckDataOffPage> {
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
      String plate = await sharedPref.read("placa");
      vehicle_id_app = await sharedPref.read("id_vehicle");
      Park ps = Park.fromJson(await sharedPref.read("park"));
      User user = User.fromJson(await sharedPref.read("user"));
      setState(() {
        vehicle_id_app = vehicle_id_app;
        park = ps;
        userLoad = user;
        placa = plate;
      });
      if (ValidaPlaca(plate)) {
        var connectivityResult = await (Connectivity().checkConnectivity());
        VehiclesOffModel vehicleModel =
            await vehicleDao.getVehicleByPlate(plate);
        if (vehicleModel == null) {
          VehiclesOffModel vehicleoff =
          VehiclesOffModel(0, vehicle_id_app, "", "", "", plate, "");
          id_vehicle_create = await vehicleDao.saveVehicles(vehicleoff);
          VehiclesOffModel vehiclecriado =
          await vehicleDao.getVehicleById(id_vehicle_create);
          sharedPref.remove("vehicle");
          sharedPref.save("vehicle", vehiclecriado);
          setState(() {
            placa = vehiclecriado.plate;
          });
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            VehicleResponse vehicleRes = await VehicleService.getVehicle(plate);

            if(vehicleRes.status == 'COMPLETED'){
              Vehicle vehicle = vehicleRes.data;
              if(vehicle != null){
                bool ok = await vehicleDao.updateVehicles(int.parse(vehicle.id), "${vehicle.maker}", "${vehicle.model}", "${vehicle.color}", "${vehicle.year}", id_vehicle_create);
                if(ok){
                  VehiclesOffModel vehiclecriado =
                  await vehicleDao.getVehicleById(id_vehicle_create);
                  sharedPref.remove("vehicle");
                  sharedPref.save("vehicle", vehiclecriado);
                  setState(() {
                    placa = vehicle.plate;
                    modelo = vehicle.model;
                    fabricante = vehicle.maker;
                    cor = vehicle.color;
                    id_vehicle = int.parse(vehicle.id);
                  });
                }
              }
            }

            VehicleCustResponse vehicleCustResponse = await VehicleService.getVehicleCust(plate);

            if(vehicleCustResponse.customers != null){
              List<CustomersModel> customersList = vehicleCustResponse.customers;
              CustomersDao customersDao = CustomersDao();

              for(int i = 0; i<customersList.length; i++){
                CustomersModel customerModel = customersList[i];

                int id = int.parse(customerModel.id);

                bool ok = await customersDao.verifyCustomer(id);
                if(!ok){
                  CustomersOffModel customersOffModel = new CustomersOffModel(id, customerModel.cell, customerModel.email, customerModel.name, customerModel.doc, int.parse(customerModel.id_status));

                  int id_customer_criado = await customersDao.saveCustomers(customersOffModel);

                }
              }

            }

            if(vehicleCustResponse.vehiclecustomer != null){
              List<VehicleCustomerModel> vehicleCustomerList = vehicleCustResponse.vehiclecustomer;

              VehicleCustomerDao vehicleCustomerDao = VehicleCustomerDao();

              for(int i = 0; i<vehicleCustomerList.length; i++) {
                VehicleCustomerModel vehicleCustomerModel = vehicleCustomerList[i];

                int id = int.parse(vehicleCustomerModel.id);
                int id_customer = int.parse(vehicleCustomerModel.id_customer);
                int id_vehicle = int.parse(vehicleCustomerModel.id_vehicle);

                bool ok = await vehicleCustomerDao.verifyVehicleCustomer(id_customer, id_vehicle);

                if(!ok){

                  List<VehicleAppSS> vehiclesslist = await vehicleCustomerDao.getvehicleapp(id_vehicle);

                  int id_vehicle_app = vehiclesslist.first.id_vehicle_app;

                  List<CustomerAppSS> customersslist = await vehicleCustomerDao.getcustomerapp(id_customer);

                  int id_customer_app = customersslist.first.id_customer_app;

                  VehicleCustomerOffModel vehicleCustomerOffModel = VehicleCustomerOffModel(id, id_customer, id_customer_app, id_vehicle, id_vehicle_app);

                  int id_vehicle_customer_criado = await vehicleCustomerDao.saveVehicleCustomer(vehicleCustomerOffModel);

                }
              }
            }
          }
        } else {
          sharedPref.remove("vehicle");
          sharedPref.save("vehicle", vehicleModel);
          id_vehicle_create = vehicleModel.id_vehicle_app;
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            VehicleCustResponse vehicleCustResponse = await VehicleService.getVehicleCust(plate);
            if(vehicleCustResponse.customers != null) {
              List<CustomersModel> customersList = vehicleCustResponse.customers;
              CustomersDao customersDao = CustomersDao();

              for(int i = 0; i<customersList.length; i++){
                CustomersModel customerModel = customersList[i];

                int id = int.parse(customerModel.id);

                bool ok = await customersDao.verifyCustomer(id);
                if(!ok){
                  CustomersOffModel customersOffModel = new CustomersOffModel(id, customerModel.cell, customerModel.email, customerModel.name, customerModel.doc, int.parse(customerModel.id_status));

                  int id_customer_criado = await customersDao.saveCustomers(customersOffModel);

                }
              }
            }

            if(vehicleCustResponse.vehiclecustomer != null){
              List<VehicleCustomerModel> vehicleCustomerList = vehicleCustResponse.vehiclecustomer;

              VehicleCustomerDao vehicleCustomerDao = VehicleCustomerDao();

              for(int i = 0; i<vehicleCustomerList.length; i++) {
                VehicleCustomerModel vehicleCustomerModel = vehicleCustomerList[i];

                int id = int.parse(vehicleCustomerModel.id);
                int id_customer = int.parse(vehicleCustomerModel.id_customer);
                int id_vehicle = int.parse(vehicleCustomerModel.id_vehicle);

                bool ok = await vehicleCustomerDao.verifyVehicleCustomer(id_customer, id_vehicle);

                if(!ok){

                  List<VehicleAppSS> vehiclesslist = await vehicleCustomerDao.getvehicleapp(id_vehicle);

                  int id_vehicle_app = vehiclesslist.first.id_vehicle_app;

                  List<CustomerAppSS> customersslist = await vehicleCustomerDao.getcustomerapp(id_customer);

                  int id_customer_app = customersslist.first.id_customer_app;

                  VehicleCustomerOffModel vehicleCustomerOffModel = VehicleCustomerOffModel(id, id_customer, id_customer_app, id_vehicle, id_vehicle_app);

                  int id_vehicle_customer_criado = await vehicleCustomerDao.saveVehicleCustomer(vehicleCustomerOffModel);

                }
              }
            }
          }
          setState(() {
            tipo = "Avulso";
            placa = vehicleModel.plate;
            modelo = vehicleModel.model;
            fabricante = vehicleModel.maker;
            cor = vehicleModel.color;
            id_vehicle = vehicleModel.id;
            id_vehicle_create = vehicleModel.id_vehicle_app;
          });
        }

        verifyExitList = await ticketHistoricDao.verifyPlatesExitsOut(
            plate, int.parse(ps.id));

        for (int i = 0; i < verifyExitList.length; i++) {
          VerifyPlateExitsModel verifyPlateExitsModel = verifyExitList[i];

          if (verifyPlateExitsModel.id_ticket_historic_status == 2) {
            entrou = true;
          } else {
            entrou = false;
          }

          if (entrou) {
            if (verifyPlateExitsModel.id_ticket_historic_status == 11) {
              setState(() {
                estacionado = false;
              });
            } else {
              setState(() {
                estacionado = true;
              });
            }
          } else {
            setState(() {
              entrou = false;
              estacionado = false;
            });
          }
        }
        agreementsList =
            await agreementDao.getAgreementByPlate(int.parse(ps.id), plate);
        if (agreementsList.length > 0) {
          setState(() {
            tipo = "Mensalista";
            mensalista = true;
            avulso = false;
          });
          for (int i = 0; i < agreementsList.length; i++) {
            AgreementsOff agreementsModel = agreementsList[i];
            setState(() {
              id_contrato = agreementsModel.id_agreement_app;
              id_contrato_serv = agreementsModel.id;
            });
            DateTime dataAtual = DateTime.now();
            DateTime dataInicioContrato =
                DateTime.parse(agreementsModel.agreement_begin);
            DateTime dataFinalContrato =
                DateTime.parse(agreementsModel.agreement_end);



            if (dataAtual.toUtc().isAfter(dataInicioContrato.toUtc())) {
            } else {
              errorList.add("Contrato ainda não iniciado.\n");
            }

            if (dataFinalContrato != null) {
              if (dataAtual.toUtc().isBefore(dataFinalContrato.toUtc())) {
              } else {
                errorList.add("Contrato já terminado.\n");
              }
            }

            DateTime now = DateTime.now();
            String hoje = DateFormat('yyyy-MM-dd').format(now).toString();

            DateTime timeOn = DateFormat('yyyy-MM-dd hh:mm:ss').parse('${now.year}-${now.month}-${now.day} ${agreementsModel.time_on}');
            DateTime timeOff = DateFormat('yyyy-MM-dd hh:mm:ss').parse('${now.year}-${now.month}-${now.day} ${agreementsModel.time_off}');


            if (now.toUtc().isAfter(timeOn.toUtc()) && now.toUtc().isBefore(timeOff.toUtc())) {
            } else {
              errorList.add("Fora do horário contrado.\n");
            }

            if(agreementsModel.agreement_type != 0){
              if (agreementsModel.status_payment != 1) {
                errorList.add("Pagamento não está em dia\n");
              }
            }else{
              if(agreementsModel.until_payment == null){
                if (agreementsModel.status_payment != 1) {
                  errorList.add("Pagamento não está em dia\n");
                }
              }else{

                DateTime dataSubs = DateTime.parse('${agreementsModel.until_payment} 00:00:00');
                DateTime now = DateTime.now();

                if(dataSubs.isBefore(now)){
                  errorList.add("Pagamento não está em dia \n");
                }
              }
            }

            DateTime date = DateTime.now();
            int dia = date.weekday;

            switch (dia) {
              case 1:
                if (agreementsModel.mon != 1) {
                  errorList.add(
                      "Não permitido nesse dia da semana. ${DateFormat('EEEE').format(date)} \n");
                }
                break;
              case 2:
                if (agreementsModel.tue != 1) {
                  errorList.add(
                      "Não permitido nesse dia da semana. ${DateFormat('EEEE').format(date)} \n");
                }
                break;
              case 3:
                if (agreementsModel.wed != 1) {
                  errorList.add(
                      "Não permitido nesse dia da semana. ${DateFormat('EEEE').format(date)} \n");
                }
                break;
              case 4:
                if (agreementsModel.thur != 1) {
                  errorList.add(
                      "Não permitido nesse dia da semana. ${DateFormat('EEEE').format(date)} \n");
                }
                break;
              case 5:
                if (agreementsModel.fri != 1) {
                  errorList.add(
                      "Não permitido nesse dia da semana. ${DateFormat('EEEE').format(date)} \n");
                }
                break;
              case 6:
                if (agreementsModel.sat != 1) {
                  errorList.add(
                      "Não permitido nesse dia da semana. ${DateFormat('EEEE').format(date)} \n");
                }
                break;
              case 7:
                if (agreementsModel.sun != 1) {
                  errorList.add(
                      "Não permitido nesse dia da semana. ${DateFormat('EEEE').format(date)} \n");
                }
                break;
            }

            AgreementsDao agreementsDao = AgreementsDao();

            List<ParkedVehicles> parkedList =
                await agreementsDao.getParkedVehicles(
                    agreementsModel.id_agreement_app, int.parse(ps.id));


            if (parkedList.length >= agreementsModel.parking_spaces) {
              errorList.add('Numero maximo de veiculos permitidos. \n');
              for (int i = 0; i < parkedList.length; i++) {
                ParkedVehicles parkedVehicleModel = parkedList[i];
                errorList.add(
                    'Cliente: ${parkedVehicleModel.name}, ${parkedVehicleModel.cell} ${parkedVehicleModel.email}\n');
                errorList.add(
                    '${parkedVehicleModel.type}: ${parkedVehicleModel.plate}, ${parkedVehicleModel.model} ${parkedVehicleModel.maker} ${parkedVehicleModel.color} ${parkedVehicleModel.year}\n');
              }
            }
          }
          if (errorList.length > 0) {
            alertModal(context, "Atenção!!", errorList.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', ''));

            setState(() {
              avulso = true;
              mostrarMsg = true;
            });
          }
        } else {
          setState(() {
            tipo = "Avulso";
            mensalista = false;
            avulso = true;
          });
        }
      } else {
        setState(() {
          avulso = false;
          mensalista = false;
        });
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO DATA OFF PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  bool ValidaPlaca(String plate) {
    RegExp placaAntiga = new RegExp(
      r"[a-zA-Z]{3}[0-9]{4}",
      caseSensitive: true,
      multiLine: false,
    );
    RegExp placaNova = new RegExp(
      r"[a-zA-Z]{3}[0-9]{1}[a-zA-Z]{1}[0-9]{2}",
      caseSensitive: true,
      multiLine: false,
    );

    if (placaAntiga.hasMatch(plate)) {
      return true;
    }
    if (placaNova.hasMatch(plate)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirmação de Dados",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: carregando ? _body(context) : isLoadingPage(),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Placa : ',
                      style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
                    ),
                    Text('${placa}',
                      style: TextStyle(fontSize: 32),),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Marca : ',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                    Text('${fabricante}',style: TextStyle(fontSize: 18),)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Modelo : ",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                    Text('${modelo}',style: TextStyle(
                      fontSize: 18
                    ),)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Cor : ",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                    ),
                    Text('${cor}',style: TextStyle(fontSize: 18),)
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                    color: Colors.black
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Tipo : ",
                      style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
                    ),
                    Text('${tipo}',style: TextStyle(fontSize: 32),)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                mostrarMsg ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Observação : ",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.red),
                    ),
                    Text('${errorList.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(',', '')}',style: TextStyle(
                        fontSize: 18
                    ),),
                  ],
                ) : Container(),
                estacionado
                    ? Text(
                        'Atenção\n Este veículo já deu entrada neste estacionamento, e não houve saida.',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                estacionado
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: verifyExitList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                          'Ação: ${verifyExitList[index].name} Horário: ${verifyExitList[index].date_time}'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Container(),
                mensalista
                    ? ButtonApp2Park(
                        text: 'Continuar Mensalista',
                        onPressed: () async {
                          var connectivityResult =
                              await (Connectivity().checkConnectivity());

                          TicketsDao ticketsDao = TicketsDao();
                          int cupom;
                          int i = 0;
                          while (i != 1) {
                            cupom = randomBetween(000001, 900000);
                            bool ok = await ticketsDao.verifyCupom(
                                cupom, int.parse(park.id));
                            if (!ok) {
                              i = 1;
                            }
                          }
                          int id_park = int.parse(park.id);
                          int id_user = int.parse(userLoad.id);

                          TicketsOffModel ticketsOffModel = TicketsOffModel(
                              0,
                              id_park,
                              id_user,
                              id_vehicle,
                              id_vehicle_create,
                              0,
                              0,
                              id_contrato_serv,
                              id_contrato,
                              cupom,
                              0,
                              0,
                              cupom_checkin_datetime,
                          '');
                          int id_ticket_app =
                              await ticketsDao.saveTickets(ticketsOffModel);

                          sharedPref.remove('id_ticket_app');
                          sharedPref.save("id_ticket_app", id_ticket_app);

                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {
                            Ticket ticket = Ticket();
                            ticket.id_ticket_app = id_ticket_app.toString();
                            ticket.id_park = id_park.toString();
                            ticket.id_user = id_user.toString();
                            if(id_vehicle != 0){
                              ticket.id_vehicle = id_vehicle.toString();
                            }
                            ticket.id_agreement = id_contrato_serv.toString();
                            ticket.id_agreement_app = id_contrato.toString();
                            ticket.id_vehicle_app =
                                id_vehicle_create.toString();
                            ticket.id_cupom = cupom.toString();
                            ticket.cupom_entrance_datetime =
                                cupom_checkin_datetime;

                            TicketResponse ticketRes =
                            await TicketService.createTicketOn(ticket);

                            if(ticketRes.status == 'COMPLETED') {
                              Ticket ticketr = ticketRes.data;

                              bool ok = await ticketsDao.updateTicketsIdOn(
                                  int.parse(ticketr.id), id_ticket_app);


                              sharedPref.save("id_ticket", int.parse(ticketr.id));

                              id_ticket = int.parse(ticketr.id);
                            }
                          }

                          TicketHistoricDao ticketHistoricDao =
                              TicketHistoricDao();

                          TicketHistoricOffModel ticketHistoricOffModel =
                          TicketHistoricOffModel(0, 0, id_ticket_app, 0,
                              id_user, 0, 0, cupom_checkin_datetime);

                          int id_ticket_historic = await ticketHistoricDao
                              .saveTicketHistoric(ticketHistoricOffModel);


                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {

                            TicketHistoricModel ticketHistoric = TicketHistoricModel();
                            ticketHistoric.id_ticket_historic_app = id_ticket_historic.toString();
                            ticketHistoric.id_ticket = id_ticket.toString();
                            ticketHistoric.id_ticket_app = id_ticket_app.toString();
                            ticketHistoric.id_user = id_user.toString();
                            ticketHistoric.id_ticket_historic_status = '0';
                            ticketHistoric.date_time = cupom_checkin_datetime;

                            TicketHistoricResponse ticketHRes = await TicketService.createTicketHistoric(ticketHistoric);

                            if(ticketHRes.status == 'COMPLETED'){

                              TicketHistoricModel ticketHis = ticketHRes.data;

                              bool ok = await ticketHistoricDao.updateTicketHistoricIdOn(int.parse(ticketHis.id), id_ticket, id_ticket_historic);

                            }
                          }

                          Navigator.of(context)
                              .pushNamed(CheckCustomerOffViewRoute);
                        },
                      )
                    : SizedBox(
                        height: 20,
                      ),
                SizedBox(
                  height: 20,
                ),
                avulso
                    ? ButtonApp2Park(
                        text: 'Continuar Avulso',
                        onPressed: () async {

                          setState(() {
                            carregando = false;
                          });

                          TicketsDao ticketsDao = TicketsDao();
                          int cupom;
                          int i = 0;
                          while (i != 1) {
                            cupom = randomBetween(000001, 900000);
                            bool ok = await ticketsDao.verifyCupom(
                                cupom, int.parse(park.id));
                            if (!ok) {
                              i = 1;
                            }
                          }
                          int id_park = int.parse(park.id);
                          int id_user = int.parse(userLoad.id);

                          TicketsOffModel ticketsOffModel = TicketsOffModel(
                              0,
                              id_park,
                              id_user,
                              id_vehicle,
                              id_vehicle_create,
                              0,
                              0,
                              0,
                              0,
                              cupom,
                              0,
                              0,
                              cupom_checkin_datetime,
                          '');

                          int id_ticket_app =
                              await ticketsDao.saveTickets(ticketsOffModel);

                          sharedPref.remove('id_ticket_app');
                          sharedPref.save("id_ticket_app", id_ticket_app);

                          var connectivityResult =
                              await (Connectivity().checkConnectivity());

                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {
                            Ticket ticket = Ticket();
                            ticket.id_ticket_app = id_ticket_app.toString();
                            ticket.id_park = id_park.toString();
                            ticket.id_user = id_user.toString();
                            if(id_vehicle != 0){
                              ticket.id_vehicle = id_vehicle.toString();
                            }
                            ticket.id_vehicle_app =
                                id_vehicle_create.toString();
                            ticket.id_cupom = cupom.toString();
                            ticket.cupom_entrance_datetime =
                                cupom_checkin_datetime;

                            TicketResponse ticketRes =
                                await TicketService.createTicketOn(ticket);

                            if(ticketRes.status == 'COMPLETED') {
                              Ticket ticketr = ticketRes.data;

                              bool ok = await ticketsDao.updateTicketsIdOn(
                                  int.parse(ticketr.id), id_ticket_app);


                              sharedPref.save("id_ticket", int.parse(ticketr.id));

                              id_ticket = int.parse(ticketr.id);
                            }
                          }

                          TicketHistoricDao ticketHistoricDao =
                              TicketHistoricDao();


                          TicketHistoricOffModel ticketHistoricOffModel =
                              TicketHistoricOffModel(0, 0, id_ticket_app, 0,
                                  id_user, 0, 0, cupom_checkin_datetime);

                          int id_ticket_historic = await ticketHistoricDao
                              .saveTicketHistoric(ticketHistoricOffModel);


                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {

                            TicketHistoricModel ticketHistoric = TicketHistoricModel();
                            ticketHistoric.id_ticket_historic_app = id_ticket_historic.toString();
                            ticketHistoric.id_ticket = id_ticket.toString();
                            ticketHistoric.id_ticket_app = id_ticket_app.toString();
                            ticketHistoric.id_user = id_user.toString();
                            ticketHistoric.id_ticket_historic_status = '0';
                            ticketHistoric.date_time = cupom_checkin_datetime;

                            TicketHistoricResponse ticketHRes = await TicketService.createTicketHistoric(ticketHistoric);

                            if(ticketHRes.status == 'COMPLETED'){

                              TicketHistoricModel ticketHis = ticketHRes.data;

                              bool ok = await ticketHistoricDao.updateTicketHistoricIdOn(int.parse(ticketHis.id), id_ticket, id_ticket_historic);

                            }
                          }

                          sharedPref.remove('id_vehicle_ons');
                          sharedPref.save("id_vehicle_ons", id_vehicle);

                          Navigator.of(context)
                              .pushNamed(CheckCustomerOffViewRoute);
                        },
                      )
                    : SizedBox(
                        height: 20,
                      ),
                SizedBox(
                  height: 20,
                ),
                ButtonApp2Park(
                  text: 'Tentar Novamente',
                  onPressed: () {
                    Navigator.of(context).pushNamed(EntryCarViewRoute);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

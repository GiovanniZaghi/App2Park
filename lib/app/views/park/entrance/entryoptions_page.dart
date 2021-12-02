import 'dart:async';

import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/views/park/entrance/entrypayment_page.dart';
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
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class EntryOptions extends StatefulWidget {
  @override
  _EntryOptions createState() => _EntryOptions();
}

class _EntryOptions extends State<EntryOptions> {
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
  String saida = "";
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
  int id_ticket_app = 0;
  bool carregando = false;
  bool mostrarMsg = false;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      String plate = await sharedPref.read("placa");
      vehicle_id_app = await sharedPref.read("id_vehicle");
      Park ps = Park.fromJson(await sharedPref.read("park"));
      User user = User.fromJson(await sharedPref.read("user"));
      int ids = await sharedPref.read("id_ticket_app");
      id_ticket = await sharedPref.read("id_ticket");
      setState(() {

        id_ticket_app = ids;
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
          print('começo : $id_vehicle_create');
          VehiclesOffModel vehiclecriado =
              await vehicleDao.getVehicleById(id_vehicle_create);
          print(vehiclecriado);
          sharedPref.remove("vehicle");
          sharedPref.save("vehicle", vehiclecriado);
          setState(() {
            placa = vehiclecriado.plate;
          });
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            VehicleResponse vehicleRes = await VehicleService.getVehicle(plate);

            if (vehicleRes.status == 'COMPLETED') {
              Vehicle vehicle = vehicleRes.data;
              print(vehicle);
              if (vehicle != null) {
                bool ok = await vehicleDao.updateVehicles(
                    int.parse(vehicle.id),
                    "${vehicle.maker}",
                    "${vehicle.model}",
                    "${vehicle.color}",
                    "${vehicle.year}",
                    id_vehicle_create);
                print(ok);
                if (ok) {
                  VehiclesOffModel vehiclecriado =
                      await vehicleDao.getVehicleById(id_vehicle_create);
                  print(vehiclecriado);
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

            VehicleCustResponse vehicleCustResponse =
                await VehicleService.getVehicleCust(plate);

            if (vehicleCustResponse.customers != null) {
              List<CustomersModel> customersList =
                  vehicleCustResponse.customers;
              CustomersDao customersDao = CustomersDao();

              for (int i = 0; i < customersList.length; i++) {
                CustomersModel customerModel = customersList[i];

                int id = int.parse(customerModel.id);

                bool ok = await customersDao.verifyCustomer(id);
                if (!ok) {
                  CustomersOffModel customersOffModel = new CustomersOffModel(
                      id,
                      customerModel.cell,
                      customerModel.email,
                      customerModel.name,
                      customerModel.doc,
                      int.parse(customerModel.id_status));

                  int id_customer_criado =
                      await customersDao.saveCustomers(customersOffModel);

                  print(id_customer_criado);
                }
              }
            }

            if (vehicleCustResponse.vehiclecustomer != null) {
              List<VehicleCustomerModel> vehicleCustomerList =
                  vehicleCustResponse.vehiclecustomer;

              VehicleCustomerDao vehicleCustomerDao = VehicleCustomerDao();

              for (int i = 0; i < vehicleCustomerList.length; i++) {
                VehicleCustomerModel vehicleCustomerModel =
                    vehicleCustomerList[i];

                int id = int.parse(vehicleCustomerModel.id);
                int id_customer = int.parse(vehicleCustomerModel.id_customer);
                int id_vehicle = int.parse(vehicleCustomerModel.id_vehicle);

                bool ok = await vehicleCustomerDao.verifyVehicleCustomer(
                    id_customer, id_vehicle);

                if (!ok) {
                  List<VehicleAppSS> vehiclesslist =
                      await vehicleCustomerDao.getvehicleapp(id_vehicle);

                  int id_vehicle_app = vehiclesslist.first.id_vehicle_app;

                  List<CustomerAppSS> customersslist =
                      await vehicleCustomerDao.getcustomerapp(id_customer);

                  int id_customer_app = customersslist.first.id_customer_app;

                  VehicleCustomerOffModel vehicleCustomerOffModel =
                      VehicleCustomerOffModel(id, id_customer, id_customer_app,
                          id_vehicle, id_vehicle_app);

                  int id_vehicle_customer_criado = await vehicleCustomerDao
                      .saveVehicleCustomer(vehicleCustomerOffModel);

                  print(id_vehicle_customer_criado);
                }
              }
            }
          }
        } else {
          print('Placa Existe.');
          sharedPref.remove("vehicle");
          sharedPref.save("vehicle", vehicleModel);
          print('vehicle model ${vehicleModel.id_vehicle_app}');
          id_vehicle_create = vehicleModel.id_vehicle_app;
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            VehicleCustResponse vehicleCustResponse =
                await VehicleService.getVehicleCust(plate);
            if (vehicleCustResponse.customers != null) {
              List<CustomersModel> customersList =
                  vehicleCustResponse.customers;
              CustomersDao customersDao = CustomersDao();

              for (int i = 0; i < customersList.length; i++) {
                CustomersModel customerModel = customersList[i];

                int id = int.parse(customerModel.id);

                bool ok = await customersDao.verifyCustomer(id);
                if (!ok) {
                  CustomersOffModel customersOffModel = new CustomersOffModel(
                      id,
                      customerModel.cell,
                      customerModel.email,
                      customerModel.name,
                      customerModel.doc,
                      int.parse(customerModel.id_status));

                  int id_customer_criado =
                      await customersDao.saveCustomers(customersOffModel);

                  print(id_customer_criado);
                }
              }
            }

            if (vehicleCustResponse.vehiclecustomer != null) {
              List<VehicleCustomerModel> vehicleCustomerList =
                  vehicleCustResponse.vehiclecustomer;

              VehicleCustomerDao vehicleCustomerDao = VehicleCustomerDao();

              for (int i = 0; i < vehicleCustomerList.length; i++) {
                VehicleCustomerModel vehicleCustomerModel =
                    vehicleCustomerList[i];

                int id = int.parse(vehicleCustomerModel.id);
                int id_customer = int.parse(vehicleCustomerModel.id_customer);
                int id_vehicle = int.parse(vehicleCustomerModel.id_vehicle);

                bool ok = await vehicleCustomerDao.verifyVehicleCustomer(
                    id_customer, id_vehicle);

                if (!ok) {
                  List<VehicleAppSS> vehiclesslist =
                      await vehicleCustomerDao.getvehicleapp(id_vehicle);

                  int id_vehicle_app = vehiclesslist.first.id_vehicle_app;

                  List<CustomerAppSS> customersslist =
                      await vehicleCustomerDao.getcustomerapp(id_customer);

                  int id_customer_app = customersslist.first.id_customer_app;

                  VehicleCustomerOffModel vehicleCustomerOffModel =
                      VehicleCustomerOffModel(id, id_customer, id_customer_app,
                          id_vehicle, id_vehicle_app);

                  int id_vehicle_customer_criado = await vehicleCustomerDao
                      .saveVehicleCustomer(vehicleCustomerOffModel);

                  print(id_vehicle_customer_criado);
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
        print(verifyExitList);

        for (int i = 0; i < verifyExitList.length; i++) {
          VerifyPlateExitsModel verifyPlateExitsModel = verifyExitList[i];

          if (verifyPlateExitsModel.id_ticket_historic_status == 2) {
            entrou = true;
            print('Ja entrou');
          } else {
            entrou = false;
            print('Não houve entrada');
          }

          if (entrou) {
            if (verifyPlateExitsModel.id_ticket_historic_status == 11) {
              print('Ja deu saida.');
              setState(() {
                estacionado = false;
              });
            } else {
              print('Não deu saída');
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
        print(agreementsList);
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

            print(dataAtual.toUtc());
            print(dataInicioContrato.toUtc());
            print(dataFinalContrato.toUtc());

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

            DateTime timeOn = DateFormat('yyyy-MM-dd hh:mm:ss').parse(
                '${now.year}-${now.month}-${now.day} ${agreementsModel.time_on}');
            DateTime timeOff = DateFormat('yyyy-MM-dd hh:mm:ss').parse(
                '${now.year}-${now.month}-${now.day} ${agreementsModel.time_off}');

            print(hoje);
            print(timeOn);
            print(timeOff);
            print('s');
            print(now);
            print(now.toUtc());
            print(timeOn);
            print(timeOn.toUtc());
            print(timeOff);
            print(timeOff.toUtc());

            if (now.toUtc().isAfter(timeOn.toUtc()) &&
                now.toUtc().isBefore(timeOff.toUtc())) {
            } else {
              errorList.add("Fora do horário contrado.\n");
            }

            if (agreementsModel.agreement_type != 0) {
              if (agreementsModel.status_payment != 1) {
                errorList.add("Pagamento não está em dia\n");
              }
            } else {
              if (agreementsModel.until_payment == null) {
                if (agreementsModel.status_payment != 1) {
                  errorList.add("Pagamento não está em dia\n");
                }
              } else {
                print(agreementsModel.until_payment);
                DateTime dataSubs =
                    DateTime.parse('${agreementsModel.until_payment} 00:00:00');
                DateTime now = DateTime.now();

                if (dataSubs.isBefore(now)) {
                  errorList.add("Pagamento não está em dia \n");
                }
              }
            }

            DateTime date = DateTime.now();
            int dia = date.weekday;
            print(dia);

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

            print("Lista de veiculos Estacionados ${parkedList} ");

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
            alertModal(
                context,
                "Atenção!!",
                errorList
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll(',', ''));

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
      print(e);
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION',
          now.toString(), 'ERRO DATA OFF PAGE', 'APP');
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
          "Entrada",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: carregando ? isLoadingPage() : _body(context),
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
                                        fontWeight:
                                            FontWeight.bold),
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
                /*Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(EntryOptionsSelectPriceViewRoute);
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
                                    'Selecionar tabela de preço',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),*/
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
                                        fontWeight:
                                        FontWeight.bold),
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
                          .pushNamed(EntryOptionsCamViewRoute);
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
                                        fontWeight:
                                        FontWeight.bold),
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
                                        fontWeight:
                                        FontWeight.bold),
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
                    Navigator.of(context).pushNamedAndRemoveUntil(EntryPaymentViewRoute, (route) => false);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ButtonApp2Park(
                    onPressed: () async {
                      alertConfirma(context, 'Cancelar entrada', 'Deseja cancelar entrada ?');
                    },
                    text: 'Cancelar Entrada',
                  ),
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
            int.parse(userLoad.id),
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
          ticketHistoric.id_user = userLoad.id.toString();
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
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}

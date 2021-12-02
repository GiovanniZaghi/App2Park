import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/sinc/sinc.dart';
import 'package:app2park/app/menu/estacionamento/DrawerPark.dart';
import 'package:app2park/app/views/park/entrance/entrycar_simple.dart';
import 'package:app2park/db/dao/cashier/movement/cash_movement_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_item_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_park_dao.dart';
import 'package:app2park/module/config/ticket_online_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/ticket/send_ticket_model.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_online_model.dart';
import 'package:app2park/module/payment/priceitem/price_detached_item_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/cashier/movement/cash_movement_off_model.dart';
import 'package:app2park/moduleoff/dashboard_money_graphics.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_innerjoin_typepark.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_model.dart';
import 'package:app2park/moduleoff/payment/priceitem/price_detached_item_off_model.dart';
import 'package:app2park/moduleoff/vehicle_patio.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import "package:flutter/material.dart";
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:app2park/config_dev.dart';

class HomeParkPage extends StatefulWidget {
  _HomeParkPageState createState() => _HomeParkPageState();
}

class _HomeParkPageState extends State<HomeParkPage> {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  Park park = Park();
  User userLoad = User();
  SharedPref sharedPref = SharedPref();
  int id_park;
  int id_office = 0;
  Sinc sinc = Sinc();
  CashMovementDao cashMoventDao = CashMovementDao();
  int res;
  int ress;
  int cashMove;
  bool isLoading = false;
  bool apiR = false;
  CashMovementOff cashMoveOff;
  TicketsDao ticketsDao = TicketsDao();
  List<VehiclePatio> vehiclePatioList = List<VehiclePatio>();
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];
  String text = 'Reenviar Cupom';
  bool datatable = false;

  double totalDiario = 0.0;

  bool ok = true;

  loadSharedPrefs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      Park ps = Park.fromJson(await sharedPref.read("park"));
      User user = User.fromJson(await sharedPref.read("user"));
      totalDiario = 0.0;

      int id_o = await sharedPref.read("id_office");
      setState(() {
        park = ps;
        userLoad = user;
        id_park = int.parse(park.id);
        id_office = id_o;
      });

      List<DashboardMoneyGraphics> listDashboardGraphics =
          await cashMoventDao.dashBoardMovementDay(int.tryParse(ps.id));

      if (listDashboardGraphics.length == 0) {
        dataMap.putIfAbsent('Dinheiro', () => 0.0);
      }

      if (listDashboardGraphics != null) {
        for (int i = 0; i < listDashboardGraphics.length; i++) {
          DashboardMoneyGraphics dash = listDashboardGraphics[i];

          dataMap.putIfAbsent(
              '${dash.pagamento} : ${NumberFormat.currency(name: '').format(dash.value)}', () => dash.value);
          totalDiario += dash.value;
        }
      }

      vehiclePatioList = await ticketsDao.getVehiclesPatio(int.tryParse(ps.id));

      setState(() {
        datatable = true;
      });

      res = await cashMoventDao.getCashByUser(
          int.tryParse(user.id), int.tryParse(park.id));
      if (res == null) {
        setState(() {
          ok = false;
        });
      } else {
        setState(() {
          ok = true;
        });
      }
    } catch (e) {
      exibirLog ? print(e) : null;
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO HomePARK PAGE', 'APP');
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: new Text(park.name_park ?? "Aguardando..."),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
          bottom: TabBar(
            onTap: (_) {
              _refreshLocalGallery();
            },
            tabs: <Widget>[
              Tab(
                text: "Início",
                icon: Icon(
                  Icons.home,
                ),
              ),
              Tab(
                text: "Dashboard",
                icon: Icon(
                  Icons.assessment,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _body(context),
            id_office <= 4 ? _dashboard(context) : _noDashboard(context),
          ],
        ),
        floatingActionButton: id_office <= 4 ? FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).pushNamed(HomePatioViewRoute);
          },
          child: Icon(Icons.directions_car),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
        ): Container(),
        drawer: DrawerPark(),
      ),
    );
  }

  _body(context) {
    VehicleTypeParkDao vehicleTypeParkDao = VehicleTypeParkDao();

    Future<List<VehicleTypeInnerjoinTypePark>> data =
        vehicleTypeParkDao.getAllVehicleTypeParkJoin(id_park);
    return Container(
      child: FutureBuilder<List<VehicleTypeInnerjoinTypePark>>(
        future: data,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text(
                  "Sem estacionamentos cadastrados! Por favor, clique no (+)");
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
              List<VehicleTypeInnerjoinTypePark> carList = snapshot.data;
              if (snapshot.data == null) {
                return Text("Zero encontrados");
              } else {
                return Container(
                  child: ListView(
                    children: <Widget>[
                      LimitedBox(
                        maxHeight: 400.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                         Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              VehicleTypeInnerjoinTypePark carType = carList[index];
                              return Center(
                                child: Container(
                                  height: 150,
                                  width: 250,
                                  child: Card(
                                          child: InkWell(
                                            onTap: () {
                                              DateTime dataSubs = DateTime.parse(park.subscription);
                                              DateTime now = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
                                              if(now.compareTo(dataSubs) >= 1){
                                                alertModal(context, 'Error!',
                                                    'Por favor regularize suas pendencias com estacionamento para continuar utilizando');
                                              }else{
                                                if(now.isBefore(dataSubs) || now.compareTo(dataSubs) == 0){
                                                  sharedPref.remove('id_vehicle');
                                                  sharedPref.save("id_vehicle",
                                                      carType.id_vehicle_type);
                                                 /*Navigator.of(context)
                                                      .pushNamed(EntryCarSimpleViewRoute); */
                                                  Navigator.of(context)
                                                      .pushNamed(EntryCarViewRoute);
                                                }else{
                                                  alertModal(context, 'Error!',
                                                      'Por favor regularize suas pendencias com estacionamento para continuar utilizando');
                                                }
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(7),
                                              child: Stack(children: <Widget>[
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  left: 10, top: 5),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .only(
                                                                            left:
                                                                                15.0),
                                                                    child: Align(
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Column(
                                                                            children: <
                                                                                Widget>[
                                                                              Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Icon(Icons.directions_car)),
                                                                              Text(
                                                                                  'Entrada',
                                                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                                                              Text(
                                                                                ' ${carType.type}',
                                                                                style:
                                                                                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        )
                                ),
                              );
                            },
                            itemCount: carList.length,
                          ),
                        ),
                         Expanded(
                          child: Container(
                            height: 300,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                VehicleTypeInnerjoinTypePark carType = carList[index];
                                return Center(
                                  child: Container(
                                    height: 150,
                                    width: 200,
                                    child: id_office <= 4
                                        ? Card(
                                            child: InkWell(
                                              onTap: () {
                                                sharedPref.remove('id_vehicle');
                                                sharedPref.save("id_vehicle",
                                                    carType.id_vehicle_type);
                                                Navigator.of(context)
                                                    .pushNamed(ExitViewRoute);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(7),
                                                child: Stack(children: <Widget>[
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                    left: 10, top: 5),
                                                            child: Column(
                                                              children: <Widget>[
                                                                Row(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                                  .only(
                                                                              left:
                                                                                  15.0),
                                                                      child: Align(
                                                                          alignment:
                                                                              Alignment
                                                                                  .center,
                                                                          child:
                                                                              Column(
                                                                            children: <
                                                                                Widget>[
                                                                              Align(
                                                                                  alignment:
                                                                                      Alignment.center,
                                                                                  child: Icon(Icons.exit_to_app)),
                                                                              Text(
                                                                                'Saída',
                                                                                style: TextStyle(
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.bold),
                                                                              ),
                                                                              Text(
                                                                                ' ${carType.type}',
                                                                                style: TextStyle(
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ),
                                );
                              },
                              itemCount: carList.length,
                            ),
                          ),
                        ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                    ],
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

  _noDashboard(context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sem permissão para faturamento.',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  _dashboard(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Faturamento do Dia : ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${NumberFormat.currency(decimalDigits: 2, name: '', locale: 'pt-br').format(totalDiario)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )
              ],
            ),
            Row(
              children: <Widget>[
                PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 5.0,
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  showChartValuesInPercentage: false,
                  showChartValues: true,
                  showChartValuesOutside: false,
                  chartValueBackgroundColor: Colors.grey[200],
                  colorList: colorList,
                  showLegends: true,
                  legendPosition: LegendPosition.right,
                  decimalPlaces: 2,
                  showChartValueLabel: true,
                  initialAngle: 0,
                  chartValueStyle: defaultChartValueStyle.copyWith(
                    color: Colors.blueGrey[900].withOpacity(0.9),
                  ),
                  chartType: ChartType.disc,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //mychart1Items("Entradas/Saídas","300","+12.9% de lucro"),
  Material mychart1Items(String title, String priceVal, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      priceVal,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: data,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _refreshLocalGallery() async {
    loadSharedPrefs();
  }

  modalBottomSheetMenu(context, VehiclePatio element) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
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
                          'Placa : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${element.plate}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Modelo : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${element.model}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Ano : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${element.year}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Cor : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${element.color}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Entrada : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${element.date_time}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Email : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${element.email}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Cell : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${element.cell}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Dar saída do Veículo sem o cupom ?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    id_office <= 5 ?  ButtonApp2Park(
                      onPressed: () {
                        if (!ok) {
                          Navigator.of(context)
                              .pushNamed(OpenCashierPageViewRoute);
                        } else {
                          sharedPref.save(
                              "exitcar", element.id_cupom.toString());
                          sharedPref.save("id_vehicle", 1);
                          Navigator.pushNamed(context, CheckExitViewRoute);
                        }
                      },
                      text: 'Saída sem Cupom',
                    ) : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'O gerente será informado desta saída! ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'A saída de veículos deve ser obrigatoriamente feita na tela de Saída utilizando o cupom.',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[],
                    ),
                    ButtonApp2Park(
                      text: 'Voltar',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      height: 20,
                    ),
                    ButtonApp2Park(
                        text: 'Reenviar Cupom',
                        onPressed: () async {
                          var connectivityResult =
                              await (Connectivity().checkConnectivity());
                          alertModal(context, 'Sucess!',
                              'Enviado com sucesso! em alguns instantes estara no email!!');
                          if (connectivityResult == ConnectivityResult.mobile ||
                              connectivityResult == ConnectivityResult.wifi) {
                            SendTicketModelModel ticketsend =
                                SendTicketModelModel();
                            ticketsend.id_ticket = element.id_ticket.toString();

                            TicketOnlineResponse ticketOnlineRes =
                                await TicketService.SendTicket(ticketsend);
                            if (ticketOnlineRes.status == 'COMPLETED') {
                              TicketOnlineModel ticketOnlineModel =
                                  ticketOnlineRes.data;

                              setState(() {
                                apiR = false;
                              });
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

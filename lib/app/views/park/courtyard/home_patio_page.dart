import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/sinc/sinc.dart';
import 'package:app2park/db/dao/cashier/movement/cash_movement_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/module/config/ticket_online_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/ticket/send_ticket_model.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_online_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/cashier/movement/cash_movement_off_model.dart';
import 'package:app2park/moduleoff/dashboard_money_graphics.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/vehicle_patio.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePatio extends StatefulWidget {
  _HomePatioState createState() => _HomePatioState();
}

class _HomePatioState extends State<HomePatio> {
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

  bool ok = true;


  loadSharedPrefs() async {
    try {
      var connectivityResult =
      await (Connectivity().checkConnectivity());
      Park ps = Park.fromJson(await sharedPref.read("park"));
      User user = User.fromJson(await sharedPref.read("user"));

      int id_o = await sharedPref.read("id_office");
      setState(() {
        park = ps;
        userLoad = user;
        id_park = int.parse(park.id);
        id_office = id_o;
      });

      List<DashboardMoneyGraphics> listDashboardGraphics = await cashMoventDao.dashBoardMovementDay(int.tryParse(ps.id));

      if(listDashboardGraphics.length == 0){
        dataMap.putIfAbsent('Dinheiro' , () => 0.0);
      }


      vehiclePatioList = await ticketsDao.getVehiclesPatio(int.tryParse(ps.id));


      setState(() {
        datatable = true;
      });


      res = await cashMoventDao.getCashByUser(int.tryParse(user.id), int.tryParse(park.id));
      if(res == null){
        setState(() {
          ok = false;

        });
      }else{
        setState(() {
          ok = true;
        });
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO HOME PATIO PAGE', 'APP');
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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: new Text("Veículos no Pátio"),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
        ),
        body: _patio(context),
      ),
    );
  }


  _patio(BuildContext context) {
    return  Container(
      child: ListView(
        children: <Widget>[
          Text(
              'Veículos no pátio : ${vehiclePatioList.length.toString()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

          datatable == true ? DataTable(
            showCheckboxColumn: true,
            columns: [
              DataColumn(
                  label: Text(
                    'Placa:',
                    style: TextStyle(fontSize: 11),
                  )),
              DataColumn(
                  label: Text(
                    'Veículo:',
                    style: TextStyle(fontSize: 11),
                  )),
              DataColumn(
                  label: Text(
                    'Entrada:',
                    style: TextStyle(fontSize: 11),
                  )),
            ],
            rows:
            vehiclePatioList // Loops through dataColumnText, each iteration assigning the value to element
                .map(
              ((element) => DataRow(
                selected: vehiclePatioList.contains(element),

                cells: <DataCell>[
                  DataCell(Text('${element.plate}',style: TextStyle(
                    fontSize: 10,
                  ),),
                      onTap: () async {
                    print('ID CU ${element.id_cupom}');
                    sharedPref.save("id_ticket_app", element.id_ticket_app);
                    sharedPref.save("id_cupom", element.id_cupom);

                        modalBottomSheetMenu(context, element);
                      }),
                  //Extracting from Map element the value
                  DataCell(
                      Text('${element.model} - ${element.year} - ${element.color}',style: TextStyle(
                        fontSize: 10,
                      ),),
                      onTap: () async {
                        sharedPref.save("id_ticketapp", element.id_ticket_app);
                        sharedPref.save("id_cupom", element.id_cupom);
                        modalBottomSheetMenu(context, element);
                      }
                  ),
                  DataCell(
                      Text('${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(element.date_time))}',style: TextStyle(
                        fontSize: 10,
                      ),),
                      onTap: () async {
                        sharedPref.save("id_ticketapp", element.id_ticket_app);
                        sharedPref.save("id_cupom", element.id_cupom);
                        modalBottomSheetMenu(context, element);
                      }
                  ),
                ],
              )),
            )
                .toList(),
          ) : Container(
            child: CircularProgressIndicator(),
          ),

        ],
      ),
    );
  }

  modalBottomSheetMenu(context, VehiclePatio element) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return  Container(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(
                          height: 70,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Dados do veículo', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                        SizedBox(height: 30,),
                        Row(
                          children: <Widget>[
                            Text('Placa : ',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                            Text('${element.plate}',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Modelo : ',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                            Text('${element.model}',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Ano : ',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                            Text('${element.year}',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Cor : ',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                            Text('${element.color}',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Entrada : ',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                            Text('${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(element.date_time))}',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Email : ',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                            Text('${element.email}',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Cell : ',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                            Text('${element.cell}',style: TextStyle(fontSize: 18),)
                          ],
                        ),
                        SizedBox(height: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 180,
                              width: 180,
                              child: QrImage(
                                data: 'https://www.app2park.com.br/ticket.php?id=${element.id_ticket}&cupom=${element.id_cupom}',
                                version: 8,
                                gapless: true,
                                errorCorrectionLevel: QrErrorCorrectLevel.H,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Dar saída do Veículo sem o cupom ?',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ButtonApp2Park(
                          onPressed: (){
                            if(!ok){
                              Navigator.of(context).pushNamed(OpenCashierPageViewRoute);
                            }else{
                              sharedPref.save("exitcar", element.id_cupom.toString());
                              sharedPref.save("id_vehicle", 1);
                              Navigator.pushNamed(context, CheckExitViewRoute);
                            }
                          },
                          text: 'Saída sem Cupom',
                        ),
                        /*Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Deseja complementar o Ticket ?',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ButtonApp2Park(
                          onPressed: (){

                            Navigator.of(context).pushNamed(EditOptionsViewRoute);
                          },
                          text: 'Editar Ticket',
                        ),*/
                        SizedBox(height: 10,),
                        Column(
                          children: <Widget>[
                            Text('O gerente será informado desta saída! ',style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),),
                            Text('A saída de veículos deve ser obrigatoriamente feita na tela de Saída utilizando o cupom.',style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                        SizedBox(height: 30,),

                        Row(
                          children: <Widget>[

                          ],
                        ),
                        ButtonApp2Park(
                          text: 'Voltar',
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          height: 20,
                        ),
                        ButtonApp2Park(
                            text: 'Reenviar Cupom',
                            onPressed: ()async{
                              var connectivityResult =
                              await (Connectivity().checkConnectivity());
                              alertModal(context, 'Sucess!', 'Enviado com sucesso! em alguns instantes estara no email!!');
                              if (connectivityResult == ConnectivityResult.mobile ||
                                  connectivityResult == ConnectivityResult.wifi) {
                                SendTicketModelModel ticketsend = SendTicketModelModel();
                                ticketsend.id_ticket = element.id_ticket.toString();

                                TicketOnlineResponse ticketOnlineRes = await TicketService.SendTicket(ticketsend);
                                if(ticketOnlineRes.status == 'COMPLETED'){
                                  TicketOnlineModel ticketOnlineModel = ticketOnlineRes.data;

                                  setState(() {
                                    apiR = false;
                                  });

                                }
                              }
                            }
                        ),
                        Container(
                          height: 20,
                        ),
                        ButtonApp2Park(
                          text: 'Reimprimir Cupom \n(Impressora Interna) \n ',
                          onPressed: (){
                            Navigator.of(context).pushNamed(CupomPrintPageViewRoute);
                          },
                        ),
                        SizedBox(height: 300,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

}
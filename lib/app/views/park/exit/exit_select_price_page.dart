import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/vehicle/vehicle_type_model.dart';
import 'package:app2park/moduleoff/exit_join_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_inner_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExitSelectPrice extends StatefulWidget {
  @override
  _ExitSelectPriceState createState() => _ExitSelectPriceState();
}

class _ExitSelectPriceState extends State<ExitSelectPrice> {
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
  String plate = '';
  String modelo = '';
  String type = '';
  String entrada = '';
  DateTime perma;
  String saida = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();
  var tempoEntrada;

  bool datatable = false;

  String permanence;



  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      int v = await sharedPref.read("id_vehicle");
      String ent = await sharedPref.read("entrada");
      String mod = await sharedPref.read("model");
      String ty = await sharedPref.read("type");
      setState(() {
        id = int.parse(p.id);
        id_vehicle = v;
        entrada = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.parse(ent)).toString();
        modelo = mod;
        type = ty;



      });
      int id_cupom = int.parse(await sharedPref.read("exitcar"));
      exitJoinList = await ticketsDao.getExitInformation(id_cupom);
      priceDetachedInnerJoinOffList =
      await dao.getOrderPriceInnerJoin(id_vehicle, id);
      for (int i = 0;
      i < priceDetachedInnerJoinOffList.length;
      i++) {
        PriceDetachedInnerJoinOff
        priceDetachedInnerJoinOff =
        priceDetachedInnerJoinOffList[i];

      }
      for (int i = 0; i < exitJoinList.length; i++) {
        ExitJoinModel exitJoinModel = exitJoinList[i];
        if (exitJoinModel.id_ticket_historic_status == 11) {
          setState(() {
            plate = exitJoinModel.plate;
            modelo = exitJoinModel.model;
          });
        } else {
          setState(() {
            plate = exitJoinModel.plate;
            modelo = exitJoinModel.model;
          });
        }
      }

      setState(() {
        datatable = true;

        permanence = DateTime.parse(saida).difference(DateTime.parse(entrada)).toString();


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
        title: Text('Selecionar tabela de preço'),
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
            Row(
              children: <Widget>[
                Text("Placa : ", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                Text(plate, style: TextStyle(
                  fontSize: 18
                ),)
              ],
            ),
            SizedBox(
              height: 05,
            ),
            Row(
              children: <Widget>[
                Text("Modelo : ", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                Text('$modelo', style: TextStyle(
                    fontSize: 18
                ),),
              ],
            ),
            Row(
              children: <Widget>[
                Text("Tipo : ", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                Text('$type', style: TextStyle(
                    fontSize: 18
                ),)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Text('Entrada : ', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                Container(
                  width: MediaQuery.of(context).size.width/1.45,
                  child: Text('${DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.parse(entrada))}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18
                  ),),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Saida : ', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                Container(
                  width: MediaQuery.of(context).size.width/1.36,
                  child: Text('${DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.parse(saida))}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 18
                    ),),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text('Permanência : ',
                style: TextStyle(

                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                Container(
                  width: MediaQuery.of(context).size.width/1.78,
                  child: Text('${permanence.substring(0,7)}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text('')
              ],
            ),
            SizedBox(height: 20,),
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
                    DataCell(Text(element.type), onTap: () {
                      sharedPref.remove("saida");
                      sharedPref.save("saida", saida);
                      sharedPref.remove("id_price_detached");
                      sharedPref.save("id_price_detached", element.id);
                      sharedPref.remove("id_price_detached_app");
                      sharedPref.save("id_price_detached_app", element.id_price_detached_app);
                      sharedPref.remove("nametable");
                      sharedPref.save("nametable", element.name);
                      sharedPref.remove("diaria");
                       sharedPref.save("diaria", element.daily_start);
                      Navigator.of(context).pushNamed(ExitServiceViewRoute);
                    }),
                    //Extracting from Map element the value
                    DataCell(Text(element.name), onTap: () {
                      sharedPref.remove("saida");
                      sharedPref.save("saida", saida);
                      sharedPref.remove("id_price_detached");
                      sharedPref.save("id_price_detached", element.id);
                      sharedPref.remove("id_price_detached_app");
                      sharedPref.save("id_price_detached_app", element.id_price_detached_app);
                      sharedPref.remove("nametable");
                      sharedPref.save("nametable", element.name);
                      sharedPref.remove("diaria");
                      sharedPref.save("diaria", element.daily_start);
                      Navigator.of(context).pushNamed(ExitServiceViewRoute);
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

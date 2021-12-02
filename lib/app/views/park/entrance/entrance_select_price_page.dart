import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_dao.dart';
import 'package:app2park/db/dao/vehicles_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/vehicle/Vehicle.dart';
import 'package:app2park/module/park/vehicle/vehicle_type_model.dart';
import 'package:app2park/moduleoff/exit_join_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_inner_model.dart';
import 'package:app2park/moduleoff/vehicles/vehicles_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EntranceSelectPrice extends StatefulWidget {
  @override
  _EntranceSelectPriceState createState() => _EntranceSelectPriceState();
}

class _EntranceSelectPriceState extends State<EntranceSelectPrice> {
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
  String placa = '';
  String modelo = '';
  String type = '';
  String entrada;
  DateTime perma;
  String horario_saida = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();
  var tempoEntrada;
  String entradaView;

  bool datatable = false;

  String permanence;
  VehiclesDao vehiclesDao = VehiclesDao();




  loadSharedPrefs() async {
    try {
      horario_saida = await sharedPref.read("horario_saida");
      Park p = Park.fromJson(await sharedPref.read("park"));
      int v = await sharedPref.read("id_vehicle");
      String plate = await sharedPref.read("placa");
      //Vehicle vh = Vehicle.fromJson(await sharedPref.read("vehicle"));
      String ent = await sharedPref.read("entrada");
      VehiclesOffModel vehiclecriado =
      await vehiclesDao.getVehicleByPlate(plate);

      setState(() {

        id = int.parse(p.id);
        id_vehicle = v;
        placa = plate;
        print("ENTRADA > ${ent}");
        entrada = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.parse(ent)).toString();
        modelo = vehiclecriado.model;
        type = vehiclecriado.id_vehicle_type.toString();

        if(type == "1"){
          type = 'Carro';
        } else if(type == "2"){
          type = 'Moto';
        } else if(type == "3"){
          type = 'Caminhão';
        } else {
          type = '';
        }
      });
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
                  Text(placa, style: TextStyle(
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
                    child: Text('${DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.parse(horario_saida))}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 18
                      ),),
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
                        sharedPref.remove('model');
                        sharedPref.save('model', modelo);
                        sharedPref.remove('type');
                        sharedPref.save("type", type);
                        sharedPref.remove("horario_saida");
                        sharedPref.save("horario_saida", horario_saida);
                        sharedPref.remove("id_price_detached");
                        sharedPref.save("id_price_detached", element.id);
                        sharedPref.remove("id_price_detached_app");
                        sharedPref.save("id_price_detached_app", element.id_price_detached_app);
                        sharedPref.remove("nametable");
                        sharedPref.save("nametable", element.name);
                        sharedPref.remove("diaria");
                        sharedPref.save("diaria", element.daily_start);
                        Navigator.of(context).pushNamed(EntranceServicesViewRoute);
                      }),
                      //Extracting from Map element the value
                      DataCell(Text(element.name), onTap: () {
                        sharedPref.remove('model');
                        sharedPref.save('model', modelo);
                        sharedPref.remove('type');
                        sharedPref.save("type", type);
                        sharedPref.remove("horario_saida");
                        sharedPref.save("horario_saida", horario_saida);
                        sharedPref.remove("id_price_detached");
                        sharedPref.save("id_price_detached", element.id);
                        sharedPref.remove("id_price_detached_app");
                        sharedPref.save("id_price_detached_app", element.id_price_detached_app);
                        sharedPref.remove("nametable");
                        sharedPref.save("nametable", element.name);
                        sharedPref.remove("diaria");
                        sharedPref.save("diaria", element.daily_start);
                        Navigator.of(context).pushNamed(EntranceServicesViewRoute);
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

import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_model.dart';
import 'package:app2park/moduleoff/payment/price_item_inner_join_vehicles.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:dart_extensions/dart_extensions.dart';


class PriceDetachedPage extends StatefulWidget {
  @override
  _PriceDetachedPageState createState() => _PriceDetachedPageState();
}

class _PriceDetachedPageState extends State<PriceDetachedPage> {
  SharedPref sharedPref = SharedPref();
  List<PriceItemInnerJoinVehicles> priceItemInnerJoinVehiclesList = List<PriceItemInnerJoinVehicles>();
  PriceDetachedDao dao = new PriceDetachedDao();
  int id = 0;
  Park park = Park();
  bool datatable = false;

  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        id = int.parse(p.id);
      });
      priceItemInnerJoinVehiclesList = await dao.getPriceInnerJoinVehicles(id);
      priceItemInnerJoinVehiclesList = priceItemInnerJoinVehiclesList.distinctBy((selector) => selector.id);

      setState(() {
        datatable = true;
      });

    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO PRICE DETACHED PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void initState() {
    loadSharedPrefs();
    _refreshLocalGallery();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushNamed(context, HomeParkViewRoute);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tabela de Preços'),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
        ),
        body: _body(context),
      ),
    );
  }

  Future<Null> _refreshLocalGallery() async {
    loadSharedPrefs();
  }

  _body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshLocalGallery,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonApp2Park(
                  onPressed: (){
                    sharedPref.remove("priceedit");
                    Navigator.of(context).pushNamed(TableCarViewRoute);
                  },
                  text: 'Criar Nova Tabela de Preços',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Ou'),
              SizedBox(
                height: 10,
              ),
              Text('Selecione uma tabela abaixo para editar : '),
              SizedBox(
                height: 10,
              ),
              datatable == true ? DataTable(
                showCheckboxColumn: false,
                columns: [
                  DataColumn(label: Text('Veiculo', style: TextStyle(),)),
                  DataColumn(label: Text('Status', style: TextStyle(),)),
                  DataColumn(label: Text('Name', style: TextStyle(),)),
                ],
                rows:
                priceItemInnerJoinVehiclesList
                    .map(
                  ((element) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text(element.type), onTap: () {
                        sharedPref.remove("priceedit");
                        sharedPref.save("priceedit", element);
                        Navigator.of(context).pushNamed(TableCarEditViewRoute);
                      }),
                      DataCell(Text(element.status), onTap: () {
                        sharedPref.remove("priceedit");
                        sharedPref.save("priceedit", element);
                        Navigator.of(context).pushNamed(TableCarEditViewRoute);
                      }),
                      DataCell(Text(element.name), onTap: () {
                        sharedPref.remove("priceedit");
                        sharedPref.save("priceedit", element);
                        Navigator.of(context).pushNamed(TableCarEditViewRoute);
                      }),
                      //Extracting from Map element the value
                    ],
                  )),
                )
                    .toList(),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

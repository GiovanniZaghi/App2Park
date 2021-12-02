import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/cashier/type/cash_type_movement_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/cashier/type/cash_type_movement_inner_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SelectCashierPage extends StatefulWidget {
  @override
  _SelectCashierPageState createState() => _SelectCashierPageState();
}

class _SelectCashierPageState extends State<SelectCashierPage> {
  SharedPref sharedPref = SharedPref();
  Park park = Park();
  User user = User();
  List<CashTypeMovementInnerOff> cashTypeMovementOffList =
      new List<CashTypeMovementInnerOff>();

  List<CashTypeMovementInnerOff> cashTypeMovementCaixaOffList =
  new List<CashTypeMovementInnerOff>();
  
  CashTypeMovementDao _daoCash = CashTypeMovementDao();
  
  int id_park;
  int id_user;
  int id_office = 0;
  String fechamento = 'Caixa ainda está aberto';

  bool caixa = true;
  bool fecha = false;

  bool datatable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshLocalGallery();
  }

  Future<Null> _refreshLocalGallery() async {
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      User u = User.fromJson(await sharedPref.read("user"));
      int id_o = await sharedPref.read("id_office");
      setState(() {
        id_park = int.tryParse(p.id);
        id_user = int.tryParse(u.id);
        id_office = id_o;
      });

      if(id_office == 4){

        cashTypeMovementOffList = await _daoCash.getCashierByIdParkIdUser(id_park, id_user);

        for (int i = 0;
        i < cashTypeMovementOffList.length;
        i++) {
          CashTypeMovementInnerOff
          cashTypeMovementInnerOff =
          cashTypeMovementOffList[i];
          if(cashTypeMovementInnerOff.fechamento == null){
            setState(() {
              datatable = true;
              fechamento = 'Caixa ainda está aberto';
            });
          }else{
            setState(() {
              datatable = true;
              fecha = true;
            });
          }
        }
      }else if(id_office <= 3){
        cashTypeMovementOffList = await _daoCash.getCashierByIdUser(id_park);
        for (int i = 0;
        i < cashTypeMovementOffList.length;
        i++) {
          CashTypeMovementInnerOff
          cashTypeMovementInnerOff =
          cashTypeMovementOffList[i];

          setState(() {
            datatable = true;
          });
        }
      }else{
      }
    } catch (e) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar um caixa'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshLocalGallery,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Selecione um Caixa',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              datatable == true ? DataTable(
                showCheckboxColumn: true,
                columns: [
                  DataColumn(
                      label: Text(
                    'Usuario',
                    style: TextStyle(),
                  )),
                  DataColumn(label: Text('Abertura')),
                  DataColumn(label: Text('Fechamento')),
                ],
                rows:
                cashTypeMovementOffList// Loops through dataColumnText, each iteration assigning the value to element
                        .map(
                          ((element) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('${element.first_name}' + ' ' + '${element.last_name}'), onTap: () {
                                    sharedPref.remove("cashtypemovement");
                                    sharedPref.save("cashtypemovement", element);
                                    Navigator.of(context).pushNamed(ResumoCashierPageViewRoute);
                                  }),
                                  //Extracting from Map element the value
                                  DataCell(Text('${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(element.abertura))}'), onTap: () {
                                    sharedPref.remove("cashtypemovement");
                                    sharedPref.save("cashtypemovement", element);
                                    Navigator.of(context).pushNamed(ResumoCashierPageViewRoute);
                                  }),
                                  DataCell(element.fechamento == null ? Text('Caixa Aberto') : Text('${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(element.fechamento))}'), onTap: () {
                                    sharedPref.remove("cashtypemovement");
                                    sharedPref.save("cashtypemovement", element);
                                    Navigator.of(context).pushNamed(ResumoCashierPageViewRoute);
                                  }),
                                ],
                              )),
                        )
                        .toList(),
              ) : Container(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

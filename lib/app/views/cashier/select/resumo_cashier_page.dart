
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/cashier/type/cash_type_movement_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/cashier/type/cash_type_movement_inner_off_model.dart';
import 'package:app2park/moduleoff/cashier/type/cash_type_resumo_off_model.dart';
import 'package:app2park/moduleoff/cashier/type/cash_type_relatorio_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResumoCashierPage extends StatefulWidget {
  @override
  _ResumoCashierPageState createState() => _ResumoCashierPageState();
}

class _ResumoCashierPageState extends State<ResumoCashierPage> {
  SharedPref sharedPref = SharedPref();
  int id_park;
  int id_user;

  CashTypeMovementInnerOff cashTypeMovementInnerOff = CashTypeMovementInnerOff(0,0,'','','','');

  CashTypeMovementDao _daoCash = CashTypeMovementDao();
  List<CashTypeResumoOff> cashTypeResumoOffList = new List<CashTypeResumoOff>();
  List<CashTypeRelatorioOff> cashTypeRelatorioList = new List<CashTypeRelatorioOff>();

  String nome;
  String abertura;
  String fechamento = 'Caixa ainda está Aberto';
  double Saldo = 0;
  double Vendas = 0;

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
      CashTypeMovementInnerOff c = CashTypeMovementInnerOff.fromJson(await sharedPref.read("cashtypemovement"));
      cashTypeResumoOffList = await _daoCash.getCashierResumo(c.id_cash_app);
      cashTypeRelatorioList = await _daoCash.getCashierRelatorio(c.id_cash_app);
      setState(() {
        id_park = int.tryParse(p.id);
        id_user = int.tryParse(u.id);
        nome = c.first_name;
        abertura = c.abertura.substring(0,19);
        fechamento = c.fechamento;
        if(fechamento == null){
          setState(() {
            fechamento = 'Caixa ainda está Aberto';
          });
        }

      });
      for (int i = 0;
      i < cashTypeResumoOffList.length;
      i++) {
        CashTypeResumoOff
        cashTypeResumoOff =
        cashTypeResumoOffList[i];


        if(cashTypeResumoOff.id_payment_method == 1){
          Saldo = Saldo + cashTypeResumoOff.value;
        }
        if(cashTypeResumoOff.id_cash_type_movement == 2){
          Vendas = Vendas + cashTypeResumoOff.value;
        }

      }
      for (int i = 0;
      i < cashTypeRelatorioList.length;
      i++) {
        CashTypeRelatorioOff
        cashTypeRelatorioOff =
        cashTypeRelatorioList[i];


        if(cashTypeRelatorioOff.date_added.isEmpty){
          cashTypeRelatorioOff.date_added = '00:00:00';
        }else{
          cashTypeRelatorioOff.date_added.substring(0,10);
        }
      }

      setState(() {
        datatable = true;
      });
    } catch (e) {

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Resumo ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Text('Usuario : '),
                      Text('${nome}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Text('Abertura : '),
                      Text('${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(abertura))}')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Text('Fechamento : '),
                      Text('${fechamento}')
                    ],
                  ),
                ),
                datatable == true ?  DataTable(
                  showCheckboxColumn: true,
                  columns: [
                    DataColumn(
                        label: Text(
                          'Movimento',
                          style: TextStyle(),
                        )),
                    DataColumn(label: Text('Pagamento')),
                    DataColumn(label: Text('Valor')),
                  ],
                  rows:
                  cashTypeResumoOffList// Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                    ((element) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text('${element.name}')),
                        //Extracting from Map element the value
                        DataCell(Text('${element.pagamento}')),
                        DataCell(Text('${NumberFormat.currency(name: '').format(element.value)}')),
                      ],
                    )),
                  )
                      .toList(),
                ) : Container(),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: <Widget>[
                    Text('Total das Vendas : '),
                    Text('${NumberFormat.currency(name: '').format(Vendas)}'),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Text('Saldo Dinheiro : '),
                    Text('${NumberFormat.currency(name: '').format(Saldo)}'),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                datatable == true ? DataTable(
                  showCheckboxColumn: true,
                  columns: [
                    DataColumn(label: Text('Data',
                      style: TextStyle(
                          fontSize: 10
                      ),)),
                    DataColumn(
                        label: Text(
                          'Movimento',
                          style: TextStyle(
                            fontSize: 10
                          ),
                        )),
                    DataColumn(label: Text('Valor',
                      style: TextStyle(
                          fontSize: 10
                      ),)),
                    DataColumn(label: Text('Ticket',
                      style: TextStyle(
                          fontSize: 10
                      ),)),
                  ],
                  rows:
                  cashTypeRelatorioList// Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                    ((element) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text('${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(element.date_added))}',style: TextStyle(fontSize: 11)),),
                        DataCell(Column(
                          children: <Widget>[
                            Text('${element.name}',style: TextStyle(fontSize: 10),),
                            Text('${element.comment}',style: TextStyle(fontSize: 9),),
                          ],
                        )),
                        DataCell(Text('${NumberFormat.currency(name: '').format(double.parse("${element.value}"))}',
                          style: TextStyle(
                              fontSize: 10
                          ),)),
                        //Extracting from Map element the value
                        DataCell(Column(
                          children: <Widget>[
                            Text('${element.pagamento}',
                              style: TextStyle(
                                  fontSize: 10
                              ),),
                            Text('${element.id_ticket}',
                              style: TextStyle(
                                  fontSize: 10
                              ),),
                          ],
                        )),
                      ],
                    )),
                  )
                      .toList(),
                ) : Container(),
                SizedBox(
                  height: 25,
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}

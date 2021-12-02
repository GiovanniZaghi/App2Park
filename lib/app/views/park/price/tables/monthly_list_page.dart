import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/agreement/agreement_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/moduleoff/agreements/agreements_off_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:dart_extensions/dart_extensions.dart';

class MonthlyList extends StatefulWidget {
  @override
  _MonthlyListState createState() => _MonthlyListState();
}

class _MonthlyListState extends State<MonthlyList> {
  SharedPref sharedPref = SharedPref();
  int id;
  List<AgreementsOff> agreementList = List<AgreementsOff>();
  AgreementsDao agreementDao = AgreementsDao();
  bool datatable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contrato Mensalistas'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomeParkViewRoute, (Route<dynamic> route) => false);
        }),
      ),
      body: _body(context),
    );
  }

  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        id = int.parse(p.id);
      });
      agreementList = await agreementDao.getContracts(int.parse(p.id), 0);
      agreementList = agreementList.distinctBy((selector) => selector.id);

      setState(() {
        datatable = true;
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO MONTH LIST PAGE', 'APP');
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
                  onPressed: () {
                    sharedPref.remove("monthly");

                    Navigator.of(context).pushNamed(MonthlyContractViewRoute);
                  },
                  text: 'Criar um novo Contrato',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Text('Selecione uma tabela abaixo para editar : '),
              SizedBox(
                height: 10,
              ),
              datatable == true ? DataTable(

                columns: [
                  DataColumn(
                      label: Text(
                    'Responsável (Empresa)',
                    style: TextStyle(),
                  )),
                ],
                rows: agreementList
                    .map(
                      ((element) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                  Container(
                                    child: ListTile(
                                      title: Text(element.accountable_name,),
                                    ),
                                  ), onTap: () {
                                sharedPref.remove("monthly");
                                sharedPref.save("monthly", element);
                                Navigator.of(context)
                                    .pushNamed(ContractMonthlyEditViewRoute);
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

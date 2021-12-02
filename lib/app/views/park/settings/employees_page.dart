import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/menu/estacionamento/DrawerPark.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park/park_user_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/puser/invite_object_select.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:dart_extensions/dart_extensions.dart';

class EmployeesPage extends StatefulWidget {
  @override
  _EmployeesPageState createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  Park park = Park();
  SharedPref sharedPref = SharedPref();
  ParkUserDao parkUserDao = ParkUserDao();
  int id_park;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        park = p;
        id_park = int.tryParse(park.id);
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO EMPLOYEE PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Colaboradores"),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Ativos",
                icon: Icon(
                  Icons.navigate_next,
                ),
              ),
              Tab(
                text: "Inativos",
                icon: Icon(
                  Icons.navigate_before,
                ),
              ),
              Tab(
                text: "Pendentes",
                icon: Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _ativo(context),
            _inativo(context),
            _pendente(context),
          ],
        ),
        drawer: DrawerPark(),
      ),
    );
  }

  body(context){}


  _ativo(BuildContext context) {

    Future<List<InviteObjectSelect>> data = parkUserDao.getAllsInvite(id_park, 1);
    return Center(
      child: FutureBuilder<List<InviteObjectSelect>>(
        future: data,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Nenhum Motorista Cadastrado");
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
              List<InviteObjectSelect> employeeList = snapshot.data.distinctBy((selector) => selector.id);
              if (snapshot.data == null) {
                return Text("Zero encontrados");
              } else {
                return Container(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      InviteObjectSelect inviteOff = employeeList[index];
                      return Container(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: InkWell(
                            child: ListTile(
                              onTap: ()async{
                                try{
                                  sharedPref.remove("inviteoff");
                                  sharedPref.save("inviteoff", inviteOff);
                                  Navigator.of(context).pushNamed(ChangeEmployeeViewRoute);
                                }catch(e){
                                  throw new Exception('erro aq');
                                }
                              },
                              title: Text(inviteOff.first_name ?? ' ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  )),
                              subtitle: Text(inviteOff.office),
                              leading: Icon(
                                Icons.person,
                                color: Colors.blue[500],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: employeeList.length,
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

  _inativo(BuildContext context) {
   Future<List<InviteObjectSelect>> data = parkUserDao.getAllsInvite(id_park, 0);
    return Center(
      child: FutureBuilder<List<InviteObjectSelect>>(
        future: data,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Nenhum Motorista Cadastrado");
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
              List<InviteObjectSelect> employeeList = snapshot.data.distinctBy((selector) => selector.id);
              if (snapshot.data == null) {
                return Text("Zero encontrados");
              } else {
                return Container(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      InviteObjectSelect inviteOff = employeeList[index];
                      return Container(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: InkWell(
                            child: ListTile(
                              onTap: ()async{
                                try{
                                  sharedPref.remove("inviteoff");
                                  sharedPref.save("inviteoff", inviteOff);
                                  Navigator.of(context).pushNamed(ChangeEmployeeViewRoute);
                                }catch(e){
                                  throw new Exception('erro aq');
                                }
                              },
                              title: Text(inviteOff.first_name ?? ' ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  )),
                              subtitle: Text(inviteOff.office),
                              leading: Icon(
                                Icons.person,
                                color: Colors.blue[500],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: employeeList.length,
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

  _pendente(BuildContext context) {
    Future<List<InviteObjectSelect>> data = parkUserDao.getAllsInvite(id_park, 4);
    return Center(
      child: FutureBuilder<List<InviteObjectSelect>>(
        future: data,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Nenhum Motorista Cadastrado");
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
              List<InviteObjectSelect> employeeList = snapshot.data.distinctBy((selector) => selector.id);
              if (snapshot.data == null) {
                return Text("Zero encontrados");
              } else {
                return Container(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      InviteObjectSelect inviteOff = employeeList[index];
                      return Container(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: InkWell(
                            child: ListTile(
                              onTap: ()async{
                                try{
                                  sharedPref.remove("inviteoff");
                                  sharedPref.save("inviteoff", inviteOff);
                                  Navigator.of(context).pushNamed(ChangeEmployeeViewRoute);
                                }catch(e){
                                  throw new Exception('erro aq');
                                }
                              },
                              title: Text(inviteOff.first_name ?? ' ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  )),
                              subtitle: Text(inviteOff.office),
                              leading: Icon(
                                Icons.person,
                                color: Colors.blue[500],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: employeeList.length,
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
}

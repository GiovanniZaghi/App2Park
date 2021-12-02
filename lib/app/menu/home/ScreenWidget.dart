import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/sinc/sinc.dart';
import 'package:app2park/app/views/home/CardParkOff.dart';
import 'package:app2park/app/views/home/Home.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park/ParkDao.dart';
import 'package:app2park/db/dao/ticket_historic_status_dao.dart';
import 'package:app2park/db/dao/version_dao.dart';
import 'package:app2park/module/config/ParkUserResponse.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/module/puser/park_user_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/ParkOff.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_status_off_model.dart';
import 'package:app2park/moduleoff/version_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info/package_info.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;


class ScreenWidget extends StatefulWidget {
  final Function onTap;

  const ScreenWidget({Key key, this.onTap}) : super(key: key);

  @override
  _ScreenWidgetState createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  User userLoad = User();
  SharedPref sharedPref = SharedPref();
  ParkDao dao = ParkDao();
  Sinc sinc = Sinc();
  int id_user;

  int id;
  String jwt = '';

  bool travado = true;

  VersionDao versionDao = VersionDao();

  var connectivityResult;

  String vers = '';

  @override
  void initState() {
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
  }

  loadSharedPrefs() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      vers = packageInfo.version;

      List<VersionOff> ListVersionOff = await versionDao.getVersionInfo();

      for(int i = 0; i < ListVersionOff.length; i++){

        VersionOff versionOff = ListVersionOff[i];

        if(versionOff.name == vers){
          setState(() {
            travado = false;
          });
        }
      }

      User user = User.fromJson(await sharedPref.read("user"));
      setState(() {
        userLoad = user;
        id_user = int.parse(userLoad.id);
      });

      String jwts = await sharedPref.read("jwt");
      setState(() async {
        jwt = jwts;
      });

    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO SCREEN WIDGET', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
        titleSpacing: 2,
        leading: GestureDetector(
            onTap: widget.onTap,
            child: Icon(
              Icons.menu,
              size: 40,
            )),
      ),
      body: travado == false ? _body(context) : _bodyTravado(context),
      floatingActionButton: travado == false ? FloatingActionButton(
        onPressed: () async {
          var connectivityResult = await (Connectivity().checkConnectivity());

          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            Navigator.of(context).pushNamed(AskViewRoute);
          }else{
            alertModal(context, 'Atenção', 'Para utilizar desse recurso, você precisa está conectado a internet!!');
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ): Container(),
    );
  }

  _body(context) {
    ParkDao park = ParkDao();
    Future<List<ParkOff>> data = park.findAllParksByUserId(id_user);
    return Center(
      child: FutureBuilder<List<ParkOff>>(
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
              List<ParkOff> parkList = snapshot.data.distinctBy((selector) => selector.id);
              if (snapshot.data == null) {
                return Text("Zero encontrados");
              } else {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          r"Selecione um estacionamento ou clique no '+' para cadastrar um novo!",
                          style: TextStyle(fontSize: 20),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              ParkOff parkUser = parkList[index];

                              DateTime dataSubs = DateTime.parse(parkUser.subscription);
                              DateTime now = DateTime.now();

                              var diff = dataSubs.difference(now).inDays;

                              return CardParkOff(parkUser, userLoad, diff);
                            },
                            itemCount: parkList.length,
                          ),
                        ),
                      ],
                    ),
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

  _bodyTravado(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.sd_card_alert_outlined,
                    color: Colors.red,
                  size: 50,
                ),
                Text(
                  "Atenção",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold

                  ),
                )
              ],
            ),
            ),
            Padding(
            padding: EdgeInsets.all(25),
              child: Text(
              "Seu aplicativo está muito desatualizado, por favor, pressione o botão para atualizá-lo gratuitamente.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
            ),
            ),
            Container(
              width: 125,

            child: FlatButton(
              color: Color.fromRGBO(41, 202, 168, 3),
              onPressed: (){
                if(Platform.isIOS){
                  launch("https://apps.apple.com/br/app/app2park/id1531771951");
                }else if(Platform.isAndroid){
                  launch("https://play.google.com/store/apps/details?id=br.com.app2park.park");
                }else{
                alertModal(context, "Atenção", "Dispositivo não reconhecido, atualize manualmente!");

                }


              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.update, color: Colors.white,),
                  Text(
                    "Atualizar",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
            )
          ],
        ),
    );
  }
}

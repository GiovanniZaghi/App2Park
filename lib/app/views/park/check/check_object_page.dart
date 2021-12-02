import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/objects_dao.dart';
import 'package:app2park/db/dao/ticket_object_dao.dart';
import 'package:app2park/module/config/ticket_object_response.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_object_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/objects_off_model.dart';
import 'package:app2park/moduleoff/ticket_object_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckObject extends StatefulWidget {
  @override
  _CheckObjectState createState() => _CheckObjectState();
}

class _CheckObjectState extends State<CheckObject> {
  ObjectsDao objectDao = ObjectsDao();
  List<ObjectsOffModel> objectsList;
  Future<List<ObjectsOffModel>> _future;
  TicketObjectDao ticketObjetoDao = TicketObjectDao();
  SharedPref sharedPref = SharedPref();
  int id_ticket_app = 0;
  int id_ticket = 0;
  int id_ticke = 0;
  bool tickado = false;

  bool isLoading = false;

  @override
  void initState() {
    loadSharedPrefs();
    _future = objectDao.findAllObjects();
    // TODO: implement initState
    super.initState();
  }

  loadSharedPrefs() async {
    try {

      var connectivityResult = await (Connectivity().checkConnectivity());

      int id = await sharedPref.read("id_ticket_app");
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        id_ticke = await sharedPref.read("id_ticket");
      }
      setState(() {
        isLoading = false;
        id_ticket_app = id;
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          id_ticket = id_ticke;
        }
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO CHECK OBJECT PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objetos deixado no veículo'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Objetos deixados no veículo'),
              Expanded(
                child: FutureBuilder<List<ObjectsOffModel>>(
                  future: _future,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text("");
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
                        List<ObjectsOffModel> objetoList = snapshot.data;
                        objectsList = objetoList;
                        if (snapshot.data == null) {
                          return Text("Zero encontrados");
                        } else {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Selecione os itens para sua tabela',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        ObjectsOffModel item =
                                            snapshot.data[index];
                                        if (item.tickado == 1) {
                                          tickado = true;
                                        } else {
                                          tickado = false;
                                        }
                                        return CheckboxListTile(
                                            title: Text(item.name),
                                            value: tickado,
                                            onChanged: (val) {
                                              setState(() {
                                                tickado = val;
                                                if (tickado == true) {
                                                  item.tickado = 1;
                                                } else {
                                                  item.tickado = 2;
                                                }
                                                objectsList = objetoList;
                                              });
                                            });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: isLoading ? Center(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[

                                          Center(child: CircularProgressIndicator()),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text('Carregando as informações!!'),
                                        ],
                                      ),
                                    ) : ButtonApp2Park(

                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        var connectivityResult =
                                            await (Connectivity()
                                                .checkConnectivity());

                                        for (int i = 0;
                                            i < objetoList.length;
                                            i++) {
                                          ObjectsOffModel objetoModel =
                                              objetoList[i];
                                          if (objetoModel.tickado == 1) {
                                            TicketObjectOffModel
                                                ticketObjetoModel =
                                                TicketObjectOffModel(
                                                    0,
                                                    id_ticket,
                                                    id_ticket_app,
                                                    objetoModel.id);
                                            int id_ticket_object_app =
                                                await ticketObjetoDao
                                                    .saveTicketObject(
                                                        ticketObjetoModel);

                                            if (connectivityResult ==
                                                    ConnectivityResult.mobile ||
                                                connectivityResult ==
                                                    ConnectivityResult.wifi) {

                                              TicketObjectModel ticketObject = TicketObjectModel();
                                              ticketObject.id_ticket_object_app = id_ticket_object_app.toString();
                                              ticketObject.id_ticket = id_ticket.toString();
                                              ticketObject.id_ticket_app = id_ticket_app.toString();
                                              ticketObject.id_object = objetoModel.id.toString();

                                              TicketObjectResponse ticketObjectRes = await TicketService.createTicketObject(ticketObject);

                                              TicketObjectModel ticketObjectR = ticketObjectRes.data.first;

                                              bool ok = await ticketObjetoDao.updateTicketObjectIdOn(int.parse(ticketObjectR.id), id_ticket_object_app);

                                              Navigator.of(context)
                                                  .pushNamed(CaptureCamPageViewRoute);
                                            }
                                          }
                                        }
                                        Navigator.of(context)
                                            .pushNamed(CaptureCamPageViewRoute);
                                      },
                                      backgroundColor:
                                          Color.fromRGBO(41, 202, 168, 3),
                                      text: 'Continuar',
                                    ),
                                  )
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

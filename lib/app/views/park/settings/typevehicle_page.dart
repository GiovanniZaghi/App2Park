import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_park_dao.dart';
import 'package:app2park/module/config/vehicle_type_park_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/module/park/vehicle/vehicle_type_model.dart';
import 'package:app2park/module/park/vehicle/vehicle_type_park_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_innerjoin_typepark.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_park_checkbox.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:dart_extensions/dart_extensions.dart';


class VehicleTypePage extends StatefulWidget {
  @override
  _VehicleTypePageState createState() => _VehicleTypePageState();
}

class _VehicleTypePageState extends State<VehicleTypePage> {
  Park park = Park();
  SharedPref sharedPref = SharedPref();
  VehicleTypeParkCheckBox v = new VehicleTypeParkCheckBox();
  Map<String, bool> values = Map<String, bool>();
  String nome = "";
  List<VehicleTypeInnerjoinTypePark> listVehicleTypeInnerjoinTypePark =
      new List<VehicleTypeInnerjoinTypePark>();
  int id = 0;
  bool buttonenable = true;
  bool isLoading = false;

  loadSharedPrefs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      Park p = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        id = int.parse(p.id);
      });
      VehicleTypeParkDao dao = new VehicleTypeParkDao();
      listVehicleTypeInnerjoinTypePark =
          await dao.getAllVehicleTypeInnerJoinTypePark(id);
      listVehicleTypeInnerjoinTypePark =  listVehicleTypeInnerjoinTypePark.distinctBy((selector) => selector.id);

      for (int i = 0; i < listVehicleTypeInnerjoinTypePark.length; i++) {
        VehicleTypeInnerjoinTypePark vehicleTypeInnerjoinTypeParkModel =
            listVehicleTypeInnerjoinTypePark[i];
        v.type = vehicleTypeInnerjoinTypeParkModel.type;
        if (vehicleTypeInnerjoinTypeParkModel.status == 1) {
          v.status = true;
        } else {
          v.status = false;
        }
        values.addAll({v.type: v.status});
      }

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        setState(() {
          buttonenable = true;
        });

      }else{
        setState(() {
          buttonenable = false;
        });
      }

    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO TYPE VEHICLE PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tipos de Veiculos'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body:  _body(context),
    );
  }

  _body(BuildContext context) {
    VehicleTypeParkDao dao = new VehicleTypeParkDao();
    Future<List<VehicleTypeInnerjoinTypePark>> data =
        dao.getAllVehicleTypeInnerJoinTypePark(id);
    return isLoading ? isLoadingPage() : Container(
      child: Center(
        child: FutureBuilder<List<VehicleTypeInnerjoinTypePark>>(
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
                List<VehicleTypeInnerjoinTypePark> carList = snapshot.data;
                if (snapshot.data == null) {
                  return Text("Zero encontrados");
                } else {
                  return Container(
                      child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          children: values.keys.map((String key) {
                            return new CheckboxListTile(
                              title: new Text(key),
                              value: values[key],
                              onChanged: (bool value) {
                                setState(() {
                                  values[key] = value;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buttonenable == true ? ButtonApp2Park(
                          onPressed: () async {
                    
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());

                            List<VehicleTypeInnerjoinTypePark>
                                listVehicleTypeInnerjoinTypePark = await dao
                                    .getAllVehicleTypeInnerJoinTypePark(id);
                            List<bool> list = new List<bool>();
                            values.forEach((key, value) {
                              list.add(value);
                            });

                            for (int i = 0;
                                i < listVehicleTypeInnerjoinTypePark.length;
                                i++) {
                              VehicleTypeInnerjoinTypePark
                                  vehicleTypeInnerjoinTypeParkModel =
                                  listVehicleTypeInnerjoinTypePark[i];
                              vehicleTypeInnerjoinTypeParkModel.status =
                                  list[i] == true ? 1 : 0;
                              bool ok = await dao.updateVehicleTypePark(
                                  vehicleTypeInnerjoinTypeParkModel.id,
                                  vehicleTypeInnerjoinTypeParkModel.status);

                              if (connectivityResult ==
                                  ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {

                                VehicleTypeParkModel vehicleModel = VehicleTypeParkModel();
                                vehicleModel.status = vehicleTypeInnerjoinTypeParkModel.status.toString();

                                VehicleTypeParkResponse vehicleResponse = await ParkService.updateVehicleTypePark(vehicleTypeInnerjoinTypeParkModel.id.toString(), vehicleModel);

                              }
                            }

                            setState(() {
                              isLoading = false;
                            });

                            Navigator.of(context).pushNamedAndRemoveUntil(HomeParkViewRoute, (route) => false);
                          },
                          text: 'Salvar',
                        ): Container(child: Text('Você precisa estar conectado a internet para alterar!'),),
                      )
                    ],
                  ));
                }
                break;
            }
            // By default, show a loading spinner.
            return Text("Zero encontrados");
          },
        ),
      ),
    );
  }
}

alertModals(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(context).pushNamed(HomeParkViewRoute);
    },
  );

  AlertDialog alerta = AlertDialog(
    title: Text(textTitle),
    content: Text(textCenter),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

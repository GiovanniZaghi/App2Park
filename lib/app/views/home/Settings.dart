import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPref sharedPref = SharedPref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
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
              padding: const EdgeInsets.all(10),
              child: Row(children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(DadosViewRoute);
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.wifi,
                            size: 100,
                          ),
                        ),
                        Text(
                          "Consumo de Dados",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      sharedPref.remove('user');
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginViewRoute, (Route<dynamic> route) => false);
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.exit_to_app,
                            size: 100,
                          ),
                        ),
                        Text(
                          "Sair",
                          style: TextStyle(fontSize: 18),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                )
              ])),
        ],
      ),
    );
  }
}

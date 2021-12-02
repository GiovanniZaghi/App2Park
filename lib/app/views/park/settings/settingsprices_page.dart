import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class SettingsPricesPage extends StatefulWidget {
  @override
  _SettingsPricesPageState createState() => _SettingsPricesPageState();
}

class _SettingsPricesPageState extends State<SettingsPricesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Preços"),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Carro",
                icon: Icon(
                  Icons.directions_car,
                ),
              ),
              Tab(
                text: "Moto",
                icon: Icon(
                  Icons.directions_bike,
                ),
              ),
              Tab(
                text: "Caminhão",
                icon: Icon(
                  Icons.directions_bus,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _body(context),
            _body(context),
            _body(context),
          ],
        ),
      ),
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
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.directions_car,
                            size: 100,
                          ),
                        ),
                        Text(
                          "Tabela Avulsos",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, TableCarViewRoute);
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.calendar_today,
                            size: 100,
                          ),
                        ),
                        Text(
                          "Tabela Mensalistas",
                          style: TextStyle(fontSize: 18),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
          Container(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Row(children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.date_range,
                            size: 100,
                          ),
                        ),
                        Text(
                          "Pacotes Diarias",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.location_on,
                            size: 100,
                          ),
                        ),
                        Text(
                          "Reserva de Permanencia",
                          style: TextStyle(fontSize: 18),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}

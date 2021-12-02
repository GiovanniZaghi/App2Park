import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class ErrorSinespPage extends StatefulWidget {
  @override
  _ErrorSinespPageState createState() => _ErrorSinespPageState();
}

class _ErrorSinespPageState extends State<ErrorSinespPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sinesp",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Atenção! Veículo com registro de roubo ou furto"),
          SizedBox(
            height: 20,
          ),
          ButtonApp2Park(
            text: 'Aceitar',
            onPressed: () {},
          ),
          SizedBox(
            height: 20,
          ),
          ButtonApp2Park(
            text: 'Rejeitar',
            onPressed: () {
              Navigator.of(context).pushNamed(HomeParkViewRoute);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class InfInviteEmployeesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/img/logo-app2park_branco.png",
            width: 250,
            height: 100,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Convidar Colaboradores",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 42,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          ButtonApp2Park(
            text: "Continuar",
            color: Colors.white,
            textStyleApp2Park: TextStyle(color: Colors.black, fontSize: 24),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(InviteEmployeesViewRoute, (Route<dynamic> route) => false);
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

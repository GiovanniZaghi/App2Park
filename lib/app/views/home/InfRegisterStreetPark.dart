import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/views/home/RegisterStreetPark.dart';
import 'package:app2park/generated/i18n.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class InfRegisterStreetParkArguments {
  String name_park;
  String type;
  String business_name;
  String cell;
  String doc;
  String vagas;

  InfRegisterStreetParkArguments(this.name_park,this.type, this.business_name,this.cell, this.doc, this.vagas);
}

class InfRegisterStreetPark extends StatelessWidget {
  final String name_park;
  final String type;
  final String business_name;
  final String cell;
  final String doc;
  final String vagas;

  const InfRegisterStreetPark(
      {Key key,
      @required this.name_park,
        @required this.type,
      @required this.business_name,
        @required this.cell,
      @required this.doc, @required this.vagas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Cadastro de Endereço do Estacionamento",
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
            text: S.of(context).Button_Next,
            color: Colors.white,
            textStyleApp2Park: TextStyle(color: Colors.black, fontSize: 24),
            onPressed: () {
              Navigator.of(context).pushNamed(RegisterStreetParkViewRoute,
                  arguments: RegisterStreetParkArguments(
                      name_park,type, business_name, cell,  doc, vagas));
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

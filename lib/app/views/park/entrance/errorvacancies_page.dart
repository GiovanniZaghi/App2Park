import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class ErrorVacanciesPage extends StatefulWidget {
  @override
  _ErrorVacanciesPageState createState() => _ErrorVacanciesPageState();
}

class _ErrorVacanciesPageState extends State<ErrorVacanciesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sem vagas disponiveis",
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
          Text("Não há vagas livres no estacionamento!"),
          SizedBox(
            height: 20,
          ),
          ButtonApp2Park(
            text: 'Continuar',
            onPressed: () {
              Navigator.of(context).pushNamed(HomeParkViewRoute);
            },
          ),
        ],
      ),
    );
  }
}

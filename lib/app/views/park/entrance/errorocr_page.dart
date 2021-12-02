import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class ErrorOcrPage extends StatefulWidget {
  @override
  _ErrorOcrPageState createState() => _ErrorOcrPageState();
}

class _ErrorOcrPageState extends State<ErrorOcrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Erro Leitura",
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
          Text("Não foi Possivel ler a placa!"),
          SizedBox(
            height: 20,
          ),
          ButtonApp2Park(
            text: 'Tentar Novamente',
            onPressed: () {},
          ),
          ButtonApp2Park(
            text: 'Digitar Placa',
            onPressed: () {
              Navigator.of(context).pushNamed(EntryTextViewRoute);
            },
          ),
        ],
      ),
    );
  }
}

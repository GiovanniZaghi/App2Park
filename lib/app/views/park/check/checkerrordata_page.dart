
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormValidate.dart';
import 'package:flutter/material.dart';

class CheckErrorDataPage extends StatefulWidget {
  @override
  _CheckErrorDataPageState createState() => _CheckErrorDataPageState();
}

class _CheckErrorDataPageState extends State<CheckErrorDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirmação de Dados",
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
          TextFormValidate(
            place: 'Digite a Placa',
            msg: 'Digite corretamente',
            label: 'XXX-0000',
          ),
          SizedBox(
            height: 20,
          ),
          Text("Placa não encontrada no sitema."
              "Por favor, digite as informações abaixo:"),
          Text("Marca : "),
          SizedBox(
            height: 20,
          ),
          Text("Modelo : "),
          SizedBox(
            height: 20,
          ),
          Text("Cor : "),
          Text("Tipo : "),
          SizedBox(
            height: 20,
          ),
          ButtonApp2Park(
            text: 'Continuar',
            onPressed: () {},
          ),
          SizedBox(
            height: 20,
          ),
          ButtonApp2Park(
            text: 'Tentar Novamente',
            onPressed: () {},
          ),
          SizedBox(
            height: 20,
          ),
          ButtonApp2Park(
            text: 'Digitar a Placa',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

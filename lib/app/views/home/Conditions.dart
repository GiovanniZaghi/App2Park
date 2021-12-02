import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class Conditions extends StatefulWidget {
  @override
  _ConditionsState createState() => _ConditionsState();
}

class _ConditionsState extends State<Conditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Termos de Uso'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Termos de Uso',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'O estacionamento deve ser criado apenas pelo proprietário.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Como proprietário, poderá cadastrar quantos colaboradores quiser.',style: TextStyle(
                  fontSize: 16,
                ),),
                SizedBox(
                  height: 10,
                ),
                Text('Envie convites para seus colaboradores para utilizarem gratuitamente o App2Park.',style: TextStyle(
                  fontSize: 16,
                ),),

              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeViewRoute, (Route<dynamic> route) => false);
                  },
                  color: Color.fromRGBO(41, 202, 168, 3),
                  child: Text('Recusar', style: TextStyle(color: Colors.white,)),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(InfRegisterParkViewRoute);
                  },
                  color: Color.fromRGBO(41, 202, 168, 3),
                  child: Text('Li e aceito', style: TextStyle(color: Colors.white,)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

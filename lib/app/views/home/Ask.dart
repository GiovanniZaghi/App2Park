import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class Ask extends StatefulWidget {
  @override
  _AskState createState() => _AskState();
}

class _AskState extends State<Ask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Condições para uso'),
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
                  '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Antes de criar um estacionamento, precisamos saber qual sua função.'
                      ,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Você é um Funcionário ou Proprietário do estacionamento ? ', style: TextStyle(
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
                    Navigator.of(context).pushNamed(AceptInviteViewRoute);
                  },
                  color: Color.fromRGBO(41, 202, 168, 3),
                  child: Text('Sou Funcionário', style: TextStyle(color: Colors.white,)),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ConditionsViewRoute);
                  },
                  color: Color.fromRGBO(41, 202, 168, 3),
                  child: Text('Sou Proprietário', style: TextStyle(color: Colors.white,)),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

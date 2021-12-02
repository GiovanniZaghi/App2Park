import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class AceptInvite extends StatefulWidget {
  @override
  _AceptInviteState createState() => _AceptInviteState();
}

class _AceptInviteState extends State<AceptInvite> {
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
                  'Por favor, solicite um convite para o proprietário do estacionamento!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'O App2Park é totalmente gratuíto para os colaboradores do estacionamento. Então, por favor, solicite que o proprietário cadastre este estacionamento. Em seguida o proprietário enviará “convites” para cada um dos colaboradores para participarem gratuitamente.',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Informe ao proprietário o seu e-mail que utilizou para se cadastrar no App2Park.'
                  'Clique no link que será enviado para seu e-mail, e o estacionamento já estará disponível em segundos.',style: TextStyle(fontSize: 18),),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){
                         Navigator.of(context).pushNamed(HomeViewRoute);
                      },
                      color: Color.fromRGBO(41, 202, 168, 3),
                      child: Text('Voltar',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

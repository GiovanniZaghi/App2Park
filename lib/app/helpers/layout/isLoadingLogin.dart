import 'package:flutter/material.dart';


class isLoadingLoginPage extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        color: Color.fromRGBO(41, 202, 168, 3),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/img/logo-app2park_branco.png",
                width: 350,
                height: 200,
              ),
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Estamos carregando todas as informações.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'O tempo de espera pode variar de acordo com a velocidade da sua internet.',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}

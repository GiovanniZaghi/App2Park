import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/views/login/RegisterUser.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class InfRegisterUserArguments {
  final String email;
  final String pass;


  InfRegisterUserArguments(this.email, this.pass,);
}

class InfRegisterUser extends StatelessWidget {
  final String email;
  final String pass;

  const InfRegisterUser(
      {Key key,
      @required this.email,
      @required this.pass,
      })
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
            "Cadastro de Usuário e Senha",
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
              Navigator.of(context).pushNamed(RegisterUserViewRoute,
                  arguments: RegisterUserArguments(
                      email, pass));
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

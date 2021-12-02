import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormValidate.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/module/config/UserRecoverResponse.dart';
import 'package:app2park/module/user/recover/RecoverEmail.dart';
import 'package:app2park/module/user/services/UserService.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class RecoverPasswordArguments {
  String email;

  RecoverPasswordArguments(this.email);
}

class RecoverPassword extends StatefulWidget {
  final String email;

  const RecoverPassword({@required this.email});

  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final _keyval = new TextEditingController();
  final _senha = new TextEditingController();

  bool _validateSenha = false;
  bool _validateKey = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recuperar Senha",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Container(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            children: <Widget>[
              Text("Digite o código de 4 dígitos enviado para seu e-mail.\n"+
                "Caso não tenha recebido nosso e-mail, por favor verifique sua caixa de spam."),
              SizedBox(
                height: 20,
              ),
              Text('Codigo : ', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              TextField(
                controller: _keyval,

                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    fontSize: 18
                ),
                decoration: InputDecoration(
                  hintText: 'Digite seu codigo',
                  errorText: _validateKey ? 'Digite um codigo' : null,
                  suffixIcon: Icon(Icons.mail),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Nova senha : ', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              TextField(
                controller: _senha,

                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                style: TextStyle(
                    fontSize: 18
                ),
                decoration: InputDecoration(
                  hintText: 'Digite sua nova Senha',
                  errorText: _validateSenha ? 'Digite uma senha ' : null,
                  suffixIcon: Icon(Icons.mail),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: ButtonApp2Park(
                  text: "Continuar",
                  onPressed: () async {
                    try {
                      if(_keyval.text.isEmpty){
                        setState(() {
                          _keyval.text.isEmpty ? _validateKey = true : _validateKey = false;
                        });

                      }else if(_senha.text.isEmpty){
                        setState(() {
                          _senha.text.isEmpty ? _validateSenha = true : _validateSenha = false;
                        });
                      }else{
                        RecoverEmail recoverEmail = RecoverEmail();
                        recoverEmail.email = widget.email.toLowerCase();
                        recoverEmail.keyval = _keyval.text;
                        recoverEmail.pass = _senha.text;
                        final UserRecoverResponse r =
                        await UserService.recoverkey(recoverEmail);
                        if (r.status == "COMPLETED") {
                          alertModals(context, r.status,
                              r.message);
                        }else{
                          alertModal(context, r.status, r.message);
                        }
                      }

                    } catch (e) {
                      DateTime now = DateTime.now();
                      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO RECOVERY PASSWORD', 'APP');
                      LogDao logDao = LogDao();
                      logDao.saveLog(logOff);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

alertModals(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
    child: Text(text),
    onPressed: () {
      Navigator.of(context).pushNamed(LoginViewRoute);
    },
  );

  AlertDialog alerta = AlertDialog(
    title: Text(textTitle),
    content: Text(textCenter),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}


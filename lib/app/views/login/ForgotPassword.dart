import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/layout/isLoadingLogin.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormValidate.dart';
import 'package:app2park/app/views/login/RecoverPassword.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/module/config/UserForgotResponse.dart';
import 'package:app2park/module/config/UserRecoverResponse.dart';
import 'package:app2park/module/user/recover/RecoverEmail.dart';
import 'package:app2park/module/user/services/UserService.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _validateEmail = false;
  final _email = new TextEditingController();

  bool isLoading = false;

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
    return isLoading ? isLoadingLoginPage() :  Center(
      child: Container(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            children: <Widget>[
              Text("Enviaremos um código para recuperação de sua senha para este e-mail."),
              SizedBox(
                height: 20,
              ),
              Text('Email : ', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    fontSize: 18
                ),
                decoration: InputDecoration(
                  hintText: 'Digite seu Email',
                  errorText: _validateEmail ? 'Digite um email' : null,
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
                    try{
                      if(_email.text.isEmpty){
                        setState(() {
                          _email.text.isEmpty ? _validateEmail = true : _validateEmail = false;
                        });
                      }
                      setState(() {
                        isLoading = true;
                      });
                      RecoverEmail recoverEmail = RecoverEmail();
                      recoverEmail.email = _email.text.toLowerCase();
                      final UserForgotResponse r = await UserService.recover(recoverEmail);
                      if(r.status == "COMPLETED"){
                        Navigator.of(context).pushNamed(
                            RecoverPasswordViewRoute,
                            arguments: RecoverPasswordArguments(
                              _email.text.toLowerCase(),
                            ));
                        setState(() {
                          isLoading = false;
                        });
                      }else{
                        alertModal(context, r.status, r.message);
                        setState(() {
                          isLoading = false;
                        });
                      }

                    }catch(e){
                      DateTime now = DateTime.now();
                      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO FORGOT PASSWORD', 'APP');
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

import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/validators/Validators.dart';
import 'package:app2park/app/views/login/InfRegisterUser.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPerson extends StatefulWidget {
  @override
  _RegisterPersonState createState() => _RegisterPersonState();
}

class _RegisterPersonState extends State<RegisterPerson> {

  final _formKey = GlobalKey<FormState>();
  final _email = new TextEditingController();
  final _pass = new TextEditingController();
  final _emailveri = new TextEditingController();
  final _passveri = new TextEditingController();
  bool _validateEmail = false;
  bool _validateSenha = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro de Usuário e Senha",
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
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            children: <Widget>[
              Text('Email : ',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                maxLength: 50,
                decoration: InputDecoration(
                  hintText: 'Digite um email',
                  errorText: _validateEmail ? 'Digite um email' : null,
                  suffixIcon: Icon(Icons.mail),
                ),
                controller: _email,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Container(
                height: 10,
              ),
              Text('Confirme o Email : ',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                maxLength: 50,
                decoration: InputDecoration(
                  hintText: 'Digite um email',
                  errorText: _validateEmail ? 'Digite um email' : null,
                  suffixIcon: Icon(Icons.mail),
                ),
                controller: _emailveri,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Container(
                height: 10,
              ),
              Text(
                'Senha : ',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                maxLength: 50,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Digite uma senha',
                  errorText: _validateSenha ? 'Digite uma senha' : null,
                  suffixIcon: Icon(Icons.vpn_key),
                ),
                controller: _pass,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Repita a Senha : ',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                maxLength: 50,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Digite uma senha',
                  errorText: _validateSenha ? 'Digite uma senha' : null,
                  suffixIcon: Icon(Icons.vpn_key),
                ),
                controller: _passveri,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: ButtonApp2Park(
                  text: 'Proximo',
                  onPressed: () async {
                    try {
                      bool sucess = true;
                      if (_email.text.isEmpty) {
                        setState(() {
                          _email.text.isEmpty ? _validateEmail = true : _validateEmail = false;
                          sucess = false;
                        });
                      } else if (_pass.text.isEmpty) {
                        setState(() {
                          _pass.text.isEmpty ? _validateSenha = true : _validateSenha = false;
                          sucess = false;
                        });
                      }else if (validaEmail(_email.text.toLowerCase())){
                          if(_emailveri.text == _email.text){
                            setState(() {
                              sucess = true;
                            });

                          }else{
                            alertModal(context, "Error Register", "Email digitado não confere");
                            setState(() {
                              sucess = false;
                            });
                          }

                            if(sucess){
                              if(_passveri.text == _pass.text){
                                setState(() {
                                  sucess = true;
                                });
                              if (_formKey.currentState.validate()) {

                                Navigator.of(context).pushNamed(
                                    InfRegisterUserViewRoute,
                                    arguments: InfRegisterUserArguments(
                                      _email.text,
                                      _pass.text,));
                              }
                            }else{
                              alertModal(context, "Error Register", "Senha digita não confere");
                              setState(() {
                                sucess = false;
                              });
                            }
                            }else{

                            }

                        }




                    } catch (e) {
                      DateTime now = DateTime.now();
                      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO REGISTER PERSON', 'APP');
                      LogDao logDao = LogDao();
                      logDao.saveLog(logOff);

                      alertModal(context, "Error Register", e.toString());
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

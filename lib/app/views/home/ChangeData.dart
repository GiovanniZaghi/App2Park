import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormNoValidate.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/validators/Validators.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/module/config/UserResponseChange.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/module/user/services/UserService.dart';
import 'package:app2park/module/user/userjwt/UserJwt.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ChangeData extends StatefulWidget {
  @override
  _ChangeDataState createState() => _ChangeDataState();
}

class _ChangeDataState extends State<ChangeData> {
  User userLoad = User();
  SharedPref sharedPref = SharedPref();
  String jwt = '';
  bool buttonenable = true;
  bool emailenable = true;
  bool passenable = true;
  bool cellenable = true;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {

      var connectivityResult = await (Connectivity().checkConnectivity());

      User user = User.fromJson(await sharedPref.read("user"));
      setState(() {
        userLoad = user;
        _email.text = userLoad.email.toLowerCase();
        _cell.text = userLoad.cell;
      });

      String jwts = await sharedPref.read("jwt");
      setState(() {
        jwt = jwts;
      });

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        setState(() {
          passenable = true;
          emailenable = true;
          cellenable = true;
          buttonenable = true;
        });

      }else{
        setState(() {
          passenable = false;
          emailenable = false;
          cellenable = false;
          buttonenable = false;
        });
      }

    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO CHANGE DATA', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _email = new TextEditingController();
  final _pass = new TextEditingController();
  final _cell = new MaskedTextController(mask: '(00)00000-0000');
  bool _validateEmail = false;
  bool _validateSenha = false;
  bool _validateCelular = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alterar Dados",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return isLoading
        ? isLoadingPage()
        : Center(
            child: Container(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  children: <Widget>[
                    Text(
                      'Email : ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: _email,
                      enabled: emailenable,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Digite seu Email',
                        errorText: _validateEmail ? 'Digite um email ' : null,
                        suffixIcon: Icon(Icons.mail),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Text(
                      'Senha : ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: _pass,
                      obscureText: true,
                      enabled: passenable,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Digite sua senha',
                        errorText: _validateSenha ? 'Digite uma senha' : null,
                        suffixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Text(
                      'Celular : ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _cell,
                      enabled: cellenable,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Digite seu celular',
                        errorText:
                            _validateCelular ? 'Digite um celular' : null,
                        suffixIcon: Icon(Icons.phone),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: buttonenable == true ? ButtonApp2Park(
                              text: "Continuar",
                              onPressed: () async {
                                try {
                                  if (!validaEmail(_email.text.toLowerCase())) {
                                    throw new Exception(
                                        "Digite os dados corretamente");
                                  }
                                  if (_email.text.isEmpty) {
                                    setState(() {
                                      _email.text.isEmpty
                                          ? _validateEmail = true
                                          : _validateEmail = false;
                                    });
                                  } else if (_pass.text.isEmpty) {
                                    setState(() {
                                      _pass.text.isEmpty
                                          ? _validateSenha = true
                                          : _validateSenha = false;
                                    });
                                  } else if (_cell.text.isEmpty) {
                                    setState(() {
                                      _cell.text.isEmpty
                                          ? _validateCelular = true
                                          : _validateCelular = false;
                                    });
                                  }
                                  UserJwt userjwt = new UserJwt();
                                  userjwt.id = userLoad.id;
                                  if (_cell.text != null) {
                                    userjwt.cell = _cell.text;
                                  }
                                  if (userjwt.email != null) {
                                    userjwt.email = _email.text.toLowerCase();
                                  }
                                  if (_pass.text != null) {
                                    userjwt.pass = _pass.text;
                                  }
                                  userjwt.jwt = jwt;
                                  userjwt.id = userLoad.id;
                                  setState(() {
                                    isLoading = true;
                                  });
                                  UserResponseChange r =
                                      await UserService.change(
                                          userjwt, userjwt.id);
                                  if (r.data != null) {
                                    User user = new User();

                                    user = r.data;

                                    sharedPref.remove('user');
                                    sharedPref.remove('jwt');

                                    sharedPref.save("user", user);

                                    sharedPref.save("jwt", jwt);

                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(HomeViewRoute,
                                            (Route<dynamic> route) => false);
                                  } else {
                                    throw new Exception(
                                        "Erro ao alterar o usuário");
                                  }
                                } catch (e) {
                                  alertModal(context, 'Error', e.toString());
                                }
                              }): Container(child: Text('Você precisa estar conectado a internet para alterar!'),),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

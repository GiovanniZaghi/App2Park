import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/layout/isLoadingLogin.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormValidate.dart';
import 'package:app2park/app/helpers/prefs/JwtPrefs.dart';
import 'package:app2park/app/helpers/prefs/UserPrefs.dart';
import 'package:app2park/app/helpers/validators/Validators.dart';
import 'package:app2park/app/views/park/price/tables/contract_daily_edit_page.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/generated/i18n.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app2park/module/config/UserResponse.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/module/user/services/UserService.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class RegisterUserArguments {
  String email;
  String pass;


  RegisterUserArguments(this.email, this.pass,);
}

class RegisterUser extends StatefulWidget {
  final String email;
  final String pass;


  const RegisterUser({
    @required this.email,
    @required this.pass,
  });

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final format = DateFormat("yyyy-MM-dd");
  final _formKey = GlobalKey<FormState>();
  final _name = new TextEditingController();
  final _lastname = new TextEditingController();
  final _cell = new MaskedTextController(mask: '(00)00000-0000');
  final _doc = new MaskedTextController(mask: '000.000.000-00');
  bool _validateName = false;
  bool _validateLastname = false;
  bool _validateCell = false;
  bool _validateDoc = false;
  bool checkedValue = false;

  bool active = false;
  bool isLoading = false;


  abrirUrl() async {
    const url = 'https://app2park.com.br/privacy.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
    return isLoading
        ? isLoadingLoginPage()
        : AbsorbPointer(
            absorbing: active,
            child: Center(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    children: <Widget>[
                      Text('Nome : ', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),
                      TextField(
                        maxLength: 25,
                        decoration: InputDecoration(
                          hintText: 'Digite seu nome',
                          errorText: _validateName ? 'Digite um nome' : null,
                          suffixIcon: Icon(Icons.person),
                        ),
                        controller: _name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Text('Sobrenome : ', style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                      TextField(
                        maxLength: 25,
                        decoration: InputDecoration(
                          hintText: 'Digite seu sobrenome',
                          errorText: _validateLastname ? 'Digite um sobrenome' : null,
                          suffixIcon: Icon(Icons.person),
                        ),
                        controller: _lastname,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Text('Celular : ', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
                      TextField(
                        maxLength: 14,
                        decoration: InputDecoration(
                          hintText: 'Digite seu Celular',
                          errorText: _validateCell ? 'Digite um Celular' : null,
                          suffixIcon: Icon(Icons.phone),
                        ),
                        controller: _cell,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Text('CPF : ',style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                      TextField(
                        maxLength: 14,
                        decoration: InputDecoration(
                          hintText: 'Digite seu CPF',
                          errorText: _validateDoc ? 'Digite um cpf valido' : null,
                          suffixIcon: Icon(Icons.account_box),
                        ),
                        controller: _doc,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      InkWell(
                        child: Text('Ler Política De Privacidade e Termos de uso',style: TextStyle(
                          fontSize: 18,
                          color: Colors.lightBlueAccent
                        ),),
                        onTap: (){
                          abrirUrl();
                        },
                      ),
                      Container(
                        height: 10,
                      ),
                      CheckboxListTile(
                        title: Text("Concordar com as Política De Privacidade e Termos de uso",style: TextStyle(
                          fontSize: 15
                        ),),
                        value: checkedValue,

                        onChanged: (newValue) {
                          setState(() {
                            checkedValue = newValue;
                          });
                        },

                         //  <-- leading Checkbox
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ButtonApp2Park(
                          text: 'Registrar',
                          onPressed: () {
                            alertModals(context, "Condições", "Para se cadastrar é preciso ser maior que 18 anos!!!");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  _registerPerson(BuildContext context) async {
    bool sucess = true;
    try {
      if(_name.text.isEmpty){
        setState(() {
          _name.text.isEmpty ? _validateName = true : _validateName = false;
          _lastname.text.isEmpty ? _validateLastname = true : _validateLastname = false;
          _cell.text.isEmpty ? _validateCell = true : _validateCell = false;
          _doc.text.isEmpty ? _validateDoc = true : _validateDoc = false;
          sucess = false;

        });
      }else if(_lastname.text.isEmpty){
        setState(() {
          _name.text.isEmpty ? _validateName = true : _validateName = false;
          _lastname.text.isEmpty ? _validateLastname = true : _validateLastname = false;
          _cell.text.isEmpty ? _validateCell = true : _validateCell = false;
          _doc.text.isEmpty ? _validateDoc = true : _validateDoc = false;
          sucess = false;

        });
      }else if(_cell.text.isEmpty){
        setState(() {
          _name.text.isEmpty ? _validateName = true : _validateName = false;
          _lastname.text.isEmpty ? _validateLastname = true : _validateLastname = false;
          _cell.text.isEmpty ? _validateCell = true : _validateCell = false;
          _doc.text.isEmpty ? _validateDoc = true : _validateDoc = false;
          sucess = false;

        });

      } else {
        if(checkedValue == false){
          setState(() {
            sucess = false;
            alertModalsError(context, "Erro", "Aceite os termos de uso");
          });
        }
        if (_formKey.currentState.validate()) {
          if (validaEmail(widget.email.toLowerCase())) {
            if(!validaCpf(_doc.text)){
              setState(() {
                isLoading = false;
                sucess = false;
              });
              alertModal(context, "Error Register", "CPF inválido");

            }
            if(sucess){
              User user = User();
              user.first_name = _name.text;
              user.last_name = _lastname.text;
              user.cell = _cell.text;
              user.doc = _doc.text;
              user.email = widget.email.toLowerCase();
              user.pass = widget.pass;
              setState(() {
                active = true;
                isLoading = true;
              });
              final UserResponse r = await UserService.save(user);
              if (r.status.toString() == 'COMPLETED') {
                JwtPrefs.clear();
                JwtPrefs jwt = JwtPrefs();
                jwt.save(r.jwt);
                UserPrefs userPrefs = UserPrefs();
                UserPrefs.clear();
                userPrefs.save(r.data);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginViewRoute, (Route<dynamic> route) => false);
                setState(() {
                  isLoading = false;
                });
              } else {
                alertModal(context, r.status, r.message);
              }
            }else{

            }
          } else {
            alertModal(context, "Error Register", "Error");
            setState(() {
              isLoading = false;
            });
          }
        } else {
          alertModal(context, "Error Register", "Error");
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO REGISTER USER', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  alertModals(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text("Concordar"),
      onPressed: () {
        Navigator.of(context).pop();
        _registerPerson(context);
      },
    );
    Widget noButton = FlatButton(
      child: Text("Voltar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alerta = AlertDialog(
      title: Text(textTitle),
      content: Text(textCenter),
      actions: [
        okButton,
        noButton
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
}

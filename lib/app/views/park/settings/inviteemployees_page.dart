import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/validators/Validators.dart';
import 'package:app2park/app/views/park/price/tables/contract_daily_edit_page.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/office/offices_dao.dart';
import 'package:app2park/db/dao/park/park_user_dao.dart';
import 'package:app2park/db/dao/user/user_dao.dart';
import 'package:app2park/module/config/UserResponse.dart';
import 'package:app2park/module/config/park_user_invite_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/module/puser/invite_object.dart';
import 'package:app2park/module/puser/park_user_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/module/user/services/UserService.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/office/office_off_model.dart';
import 'package:app2park/moduleoff/puser/park_user_off_model.dart';
import 'package:app2park/moduleoff/user/user_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';

class InviteEmployeesPage extends StatefulWidget {
  @override
  _InviteEmployeesPageState createState() => _InviteEmployeesPageState();
}

class _InviteEmployeesPageState extends State<InviteEmployeesPage> {
  final _formKey = GlobalKey<FormState>();
  final _nome = new TextEditingController();
  final _telefone = new MaskedTextController(mask: '(00)00000-0000');
  final _email = new TextEditingController();
  final _convite = new TextEditingController();
  String test = "Convite: ";
  String vers;

  OfficeOff _selectedCargo;
  OfficeDao _daoOff = OfficeDao();

  Park park = Park();
  SharedPref sharedPref = SharedPref();

  String id = '';
  String id_user = '';
  String sucess = 'Atenção!!!';
  String msg =
      'Antes de enviar o convite, solicite ao novo colaborador que instale o App2park no celular, e se cadastre.';
  bool _isButtonDisabled;
  String ou = '';
  String abaixo = '';
  String corpo =
      'Depois preencha os campos acima com o telefone e/ou e-mail utilizados pelo novo colaborador para se cadastrar no App2park.';
  double opa = 1.0;
  Future _future;

  bool _validaNome = false;
  bool _validaEmail = false;
  bool _validaTelefone = false;

  bool isLoading = false;
  bool validaCargo = false;

  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      User u = User.fromJson(await sharedPref.read("user"));
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        park = p;
        id = park.id;
        id_user = u.id;
        vers = packageInfo.version;
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO  INVITE EMPLOYEE PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void initState() {
    _future = _daoOff.findAllOffices();
    // TODO: implement initState
    loadSharedPrefs();
    _isButtonDisabled = false;
    super.initState();
  }

  void _disable() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

  void _enable() {
    setState(() {
      _isButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeParkViewRoute, (Route<dynamic> route) => false);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Convidar Colaboradores "),
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
              padding: EdgeInsets.only(top: 10),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Enviar convite por telefone e/ou email ?',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nome : ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      TextField(
                        controller: _nome,
                        decoration: InputDecoration(
                          hintText: 'Digite o nome',
                          suffixIcon: Icon(Icons.contact_mail),
                          errorText: _validaNome ? 'Digite um nome' : null,
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Email :',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          hintText: 'Digite o email',
                          suffixIcon: Icon(Icons.email),
                          errorText: _validaEmail ? 'Digite um email' : null,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              FutureBuilder<List<OfficeOff>>(
                                  future: _future,
                                  builder: (context, snapshot) {
                                    return DropdownButton<OfficeOff>(
                                        hint: Text(
                                          "Selecione o cargo",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        value: _selectedCargo,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedCargo = newValue;
                                            validaCargo = true;
                                          });
                                        },
                                        items: snapshot.data
                                            .map((off) =>
                                                DropdownMenuItem<OfficeOff>(
                                                  child: Text(off.office),
                                                  value: off,
                                                ))
                                            .toList());
                                  }),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        sucess,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(msg),
                      Text(
                        ou,
                        textAlign: TextAlign.center,
                      ),
                      Text(corpo),
                      Text(abaixo),
                      Container(
                        height: 30,
                      ),
                      //share(context),
                      _buildCounterButton(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget _buildCounterButton() {
    return Opacity(
        opacity: opa,
        child: new ButtonApp2Park(
          text: _isButtonDisabled ? "Convite Enviado" : "Enviar Convite",
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
          textStyleApp2Park: TextStyle(color: Colors.white, fontSize: 20),
          onPressed: () async {
            bool valido = true;
            List<String> errorList = List<String>();
            setState(() {
              isLoading = true;
            });
            if (_isButtonDisabled) {
              return null;
            }

            if (_nome.text.isEmpty) {
              setState(() {
                _nome.text.isEmpty
                    ? _validaNome = true
                    : _validaNome = false;
                valido = false;
                errorList.add('Digite o Nome corretamente!');
              });
            }

            if (_email.text.isEmpty) {
              setState(() {
                _email.text.isEmpty
                    ? _validaEmail = true
                    : _validaEmail = false;
                valido = false;
                errorList.add('Digite o Email corretamente!');
              });
            }

            if (validaCargo == false){
              setState(() {
                errorList.add('Selecione um Cargo ');
                valido = false;
              });
            }
            if(!validaEmail(_email.text)){
              setState(() {
                valido = false;
                errorList.add('Digite o Email corretamente!');
              });
            }

            if(valido){
              var connectivityResult = await (Connectivity().checkConnectivity());
              if (connectivityResult == ConnectivityResult.mobile ||
                  connectivityResult == ConnectivityResult.wifi) {
                try {
                  ParkUserDao parkUserDao = ParkUserDao();
                  UserDao userDao = UserDao();
                  InviteObject invite = InviteObject();
                  invite.email = _email.text.toLowerCase();
                  invite.first_name = _nome.text;
                  invite.cell = _telefone.text;
                  invite.id_park = id;
                  invite.id_office = _selectedCargo.id.toString();
                  invite.id_user = id_user;
                  ParkUserInviteResponse inviteResponse =
                  await ParkService.invite(invite);

                  if(inviteResponse.status == 'COMPLETED'){
                    if (inviteResponse.puser != null) {
                      List<ParkUser> ListparkUser = inviteResponse.puser;

                      for (int i = 0; i < ListparkUser.length; i++) {
                        ParkUser parkUser = ListparkUser[i];

                        bool ok = await parkUserDao
                            .verifyPuser(int.tryParse(parkUser.id));

                        if (!ok) {
                          ParkUserOff puserOff = ParkUserOff(
                              int.tryParse(parkUser.id),
                              int.tryParse(parkUser.id_park),
                              int.tryParse(parkUser.id_user),
                              int.tryParse(parkUser.id_office),
                              int.tryParse(parkUser.id_status),
                              parkUser.keyval,
                              parkUser.date_added,
                              parkUser.date_edited);
                          parkUserDao.saveParkUser(puserOff);
                        }

                        UserResponse userRes =
                        await UserService.getUser(parkUser.id_user);

                        if (userRes.status == 'COMPLETED') {
                          if (userRes.data != null) {
                            User user = userRes.data;

                            bool ok =
                            await userDao.verifyUser(int.tryParse(user.id));

                            if (!ok) {
                              UserOff userOff = UserOff(
                                  user.id,
                                  user.first_name,
                                  user.last_name,
                                  user.cell,
                                  user.doc,
                                  user.email,
                                  user.pass,
                                  user.id_status);

                              userDao.saveUser(userOff);
                            }
                          }
                        }
                      }

                      setState(() {
                        _convite.text = inviteResponse.link_invite;
                        test = _convite.text;
                        sucess = "Convite Enviado !!";
                        msg =
                        "Por favor, solicite que o colaborador acesse o link enviado por SMS/WhatsAPP/e-Mail.";
                        Navigator.of(context).pushNamed(HomeParkViewRoute);
                      });
                    }
                  }else{
                    setState(() {
                      isLoading = false;
                      sucess = 'Telefone/e-Mail não encontrado!';
                      msg =
                      'Verifique o telefone/e-Mail digitados, e tente novamente.';
                      ou = 'ou';
                      abaixo =
                      'Preencha os dados acima com telefone e/ou e-mail utilizados pelo novo colaborador para se cadastrar no App2park, e tente novamente.';
                      corpo =
                          'Solicite ao novo colaborador que instale o App2park, e se cadastre.' +
                              abaixo;
                      alertModal(context, sucess, corpo);
                    });
                  }

                } catch (e) {
                  isLoading = false;
                  DateTime now = DateTime.now();
                  LogOff logOff = LogOff('0', id_user, id, e.toString(), vers, now.toString(), 'COLABORADOR - ERRO AO CONVIDAR COLABORADOR', 'APP');
                  LogDao logDao = LogDao();
                  logDao.saveLog(logOff);
                  alertModals(context, 'Error', e);
                }
              } else if (connectivityResult == ConnectivityResult.none) {
                isLoading = false;
                alertModals(context, "Erro de Conexão",
                    "Verifique a conexão com a internet");
              }
            }else{
              setState(() {
                isLoading = false;
              });
              alertModalsError(context, "Erro", errorList.toString());
            }

          },
        ));
  }

  share(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          final RenderBox box = context.findRenderObject();
          Share.share(_convite.text,
              subject: _convite.text,
              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        },
        child: Icon(
          Icons.share,
          color: Colors.blue,
        ),
      ),
    );
  }

  alertModals(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeParkViewRoute, (Route<dynamic> route) => false);
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
}

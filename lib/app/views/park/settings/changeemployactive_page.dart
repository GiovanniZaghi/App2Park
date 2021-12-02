import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/office/offices_dao.dart';
import 'package:app2park/db/dao/park/park_user_dao.dart';
import 'package:app2park/module/config/get_parkuser_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/puser/invite_object_select.dart';
import 'package:app2park/module/puser/park_user_model.dart';
import 'package:app2park/module/puser/service/park_user_service.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/office/office_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeEmployActivePage extends StatefulWidget {
  @override
  _ChangeEmployActivePageState createState() => _ChangeEmployActivePageState();
}

class _ChangeEmployActivePageState extends State<ChangeEmployActivePage> {


  final _formKey = GlobalKey<FormState>();
  String nome = '';
  String telefone = '';
  String email = '';
  final _nome = new TextEditingController();
  final _email = new TextEditingController();
  final _telefone = new TextEditingController();
  String test = "Convite: ";

  SharedPref sharedPref = SharedPref();
  OfficeDao _daoff = OfficeDao();
  Future _future;
  InviteObjectSelect a;

  loadSharedPrefs() async {
    try {
      InviteObjectSelect p = InviteObjectSelect.fromJson(await sharedPref.read("inviteoff"));
      setState(() async{
        a = p;
        nome = p.first_name;
        _nome.text = p.first_name;
        telefone = p.cell;
        _telefone.text = p.cell;
        email = p.email.toLowerCase();
        _email.text = p.email;
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO CHANGE EMPLOYEE ACTIVE PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }
  OfficeOff _selectedCargo;

  Park park = Park();


  String id = '';
  String sucess = '';
  String msg = '';


  @override
  void initState() {
    _future = _daoff.findAllOffices();
    // TODO: implement initState
    loadSharedPrefs();
    super.initState();
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
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Text(
                  'Enviar convite por telefone e/ou email ?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Nome : $nome'),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Container(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Telefone '),
                  ],
                ),
                TextField(
                  controller: _telefone,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Email '),
                  ],
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FutureBuilder<List<OfficeOff>>(
                            future: _future,
                            builder: (context, snapshot) {
                              return DropdownButton<OfficeOff>(
                                  hint: Text("Select"),
                                  value: _selectedCargo,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedCargo = newValue;
                                    });
                                  },
                                  items: snapshot.data.map((off) =>
                                      DropdownMenuItem<OfficeOff>(
                                        child: Text(off.office),
                                        value: off,
                                      )
                                  ).toList());
                            }),
                      ],
                    )),
                Text(
                  sucess,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(msg),
                Container(
                  height: 30,
                ),
                //share(context),
                ButtonApp2Park(
                  backgroundColor: Color.fromRGBO(41, 202, 168, 3),
                  text: "Salvar",
                  onPressed: () async {
                    ParkUserDao parkUserDao = ParkUserDao();

                    ParkUser parkuser = ParkUser();
                    parkuser.id = a.id.toString();
                    parkuser.id_office = _selectedCargo.id.toString();

                    GetParkUserResponse getParkUserRes = await ParkUserService.updatePuser(parkuser);

                    if(getParkUserRes.status == 'COMPLETED'){
                    }

                   // bool ok = await parkUserDao.updateParkUser(a.id, _selectedStatus.id, _selectedCargo.id);

                  },
                  textStyleApp2Park:
                  TextStyle(color: Colors.white, fontSize: 20),
                ),
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

}

import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormValidate.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';

class ChangeDataParkPage extends StatefulWidget {
  @override
  _ChangeDataParkPageState createState() => _ChangeDataParkPageState();
}

class _ChangeDataParkPageState extends State<ChangeDataParkPage> {
  final _formKey = GlobalKey<FormState>();
  final _namePark = new TextEditingController();
  final _street = new TextEditingController();
  final _city = new TextEditingController();
  final _bus = new TextEditingController();

  Park p = new Park();
  SharedPref sharedPref = SharedPref();

  bool _validaName = false;
  bool _validaStreet = false;
  bool _validaCity = false;
  bool _validaBus = false;

  bool isLoading = false;

  bool nameParkenable = true;
  bool nameFantasykenable = true;
  bool streetenable = true;
  bool cityenable = true;
  bool buttonenable = true;

  loadSharedPrefs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      Park pk = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        p = pk;
        _namePark.text = p.name_park;
        _street.text = p.street;
        _city.text = p.city;
        _bus.text = p.business_name;
      });

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        setState(() {
          nameParkenable = true;
          nameFantasykenable = true;
          streetenable = true;
          cityenable = true;
          buttonenable = true;
        });

      }else{
       setState(() {
         nameParkenable = false;
         nameFantasykenable = false;
         streetenable = false;
         cityenable = false;
         buttonenable = false;
       });
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO CHANGE DATA PARK PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alterar dados Estacionamento",
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            children: <Widget>[
              Container(
                height: 10,
              ),
              Text(
                "Nome Fantasia : ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10,
              ),
              TextField(
                controller: _bus,
                keyboardType: TextInputType.text,
                enabled: nameFantasykenable,
                decoration: InputDecoration(
                  hintText: p.business_name,
                  suffixIcon: Icon(Icons.local_parking),
                  errorText: _validaBus ? 'Digite um Nome fantasia' : null,
                ),
              ),
              Container(
                height: 40,
              ),
              Text(
                "Nome do Estacionamento : ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10,
              ),
              TextField(
                controller: _namePark,
                keyboardType: TextInputType.text,
                enabled: nameParkenable,
                decoration: InputDecoration(
                  hintText: p.name_park,
                  suffixIcon: Icon(Icons.directions_car),
                  errorText: _validaName ? 'Digite um Nome do estacionamento' : null,
                ),
              ),
              Container(
                height: 40,
              ),
              Text(
                "Rua : ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10,
              ),
              TextField(
                controller: _street,
                keyboardType: TextInputType.text,
                enabled: streetenable,
                decoration: InputDecoration(
                  hintText: p.street,
                  suffixIcon: Icon(Icons.location_on),
                  errorText: _validaStreet ? 'Digite uma Rua' : null,
                ),
              ),

              Container(
                height: 40,
              ),
              Text(
                "Cidade : ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10,
              ),
              TextField(
                controller: _city,
                keyboardType: TextInputType.text,
                enabled: cityenable,
                decoration: InputDecoration(
                  hintText: p.city,
                  suffixIcon: Icon(Icons.location_on),
                  errorText: _validaCity ? 'Digite uma Cidade' : null,
                ),
              ),
              Container(
                height: 40,
              ),
             buttonenable == true ? ButtonApp2Park(
                text: "Continuar",
                onPressed: (){
                  if (_bus.text.isEmpty) {
                    setState(() {
                      _bus.text.isEmpty
                          ? _validaBus = true
                          : _validaBus = false;
                    });
                  }else if(_namePark.text.isEmpty){
                    setState(() {
                      _namePark.text.isEmpty
                          ? _validaName = true
                          : _validaName = false;
                    });
                  }else if(_street.text.isEmpty){
                    setState(() {
                      _street.text.isEmpty
                          ? _validaStreet = true
                          : _validaStreet = false;
                    });
                  }else if(_city.text.isEmpty){
                    setState(() {
                      _city.text.isEmpty
                          ? _validaCity = true
                          : _validaCity = false;
                    });
                  }
                  setState(() {
                    isLoading = true;
                  });
                  Navigator.of(context).pushNamedAndRemoveUntil(HomeParkViewRoute, (route) => false);
                },
              ): Container(child: Text('Você precisa estar conectado a internet para alterar!'),),
              Container(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

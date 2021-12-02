import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class EntryTextSimplePage extends StatefulWidget {
  @override
  _EntryTextSimplePageState createState() => _EntryTextSimplePageState();
}

class _EntryTextSimplePageState extends State<EntryTextSimplePage> {
  bool placaValida;

  final _placa = new MaskedTextController(mask: 'AAA0@00');
  var cupom_checkin_datetime = new DateTime.now();
  Park park = Park();
  User userLoad = User();
  bool _validaPlaca = false;


  int vehicle_id_app;
  var data = new DateTime.now();
  SharedPref sharedPref = SharedPref();

  loadSharedPrefs() async {
    try {
      vehicle_id_app = await sharedPref.read("id_vehicle");
      Park ps = Park.fromJson(await sharedPref.read("park"));
      User user = User.fromJson(await sharedPref.read("user"));
      setState(() {
        vehicle_id_app = vehicle_id_app;
        park = ps;
        userLoad = user;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Digite a Placa",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Placa : ', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                TextField(
                  controller: _placa,
                  style: TextStyle(
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Digite a Placa',
                    suffixIcon: Icon(Icons.directions_car),
                    errorText: _validaPlaca ? 'Digite uma placa' : null,
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonApp2Park(
            text: 'Continuar',
            onPressed: () async {
              if(_placa.text.isEmpty){
                setState(() {
                  _placa.text.isEmpty
                      ? _validaPlaca = true
                      : _validaPlaca = false;
                });
              }else{
                sharedPref.remove('placa');
                sharedPref.save("placa", _placa.text.toUpperCase());
                Navigator.of(context).popAndPushNamed(CheckDataSimpleOffPageViewRoute);
              }

            },
          ),
        ],
      ),
    );
  }
}

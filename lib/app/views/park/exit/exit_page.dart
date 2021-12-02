import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/cashier/cashs_dao.dart';
import 'package:app2park/db/dao/cashier/movement/cash_movement_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';



class ExitPage extends StatefulWidget {
  @override
  _ExitPageState createState() => _ExitPageState();
}

class _ExitPageState extends State<ExitPage> {
  SharedPref sharedPref = SharedPref();
  final _cupom = new TextEditingController();
  String result = '';
  var scanResult;
  User userLoad = User();
  Park parkLoad = Park();
  int id_user;
  int id_park;
  var data = new DateTime.now();
  CashsDao cashDao = CashsDao();
  CashMovementDao cashMoventDao = CashMovementDao();
  int res;

  bool ok = true;
  bool lerqr = false;

  GlobalKey qrKey = GlobalKey();
  QRViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    loadSharedPrefs();
    super.initState();
  }

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sharedPref.read("user"));
      Park park = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        userLoad = user;
        id_user = int.parse(userLoad.id);
        parkLoad = park;
        id_park = int.parse(parkLoad.id);

      });

      res = await cashMoventDao.getCashByUser(id_user, id_park);
      if(res == null){
        setState(() {
          ok = false;
        });
      }else{
        setState(() {
          ok = true;
        });
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO EXIT PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saída",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: ok ?  _body(context) : _aberto(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           lerqr == true? Expanded(
              child: QRView(key: qrKey,
              onQRViewCreated: _onQRviewCreated),
            ) : Container(),
            Container(
              child: Text(
                'Digite o cupom',
                style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: _cupom,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(suffixIcon: Icon(Icons.vpn_key)),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonApp2Park(
              text: 'Continuar',
              onPressed: () async {
                sharedPref.remove("exitcar");
                sharedPref.save("exitcar", _cupom.text);
                Navigator.pushNamed(context, CheckExitViewRoute);
              },
            ),
            SizedBox(
              height: 20,
            ),
            ButtonApp2Park(
              text: 'Ler QRCode',
              onPressed: () async {
                setState(() {
                  lerqr = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
  _aberto(BuildContext context){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Atenção !!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          Text('Não existe um caixa aberto.'),
          SizedBox(
            height: 5,
          ),
          ButtonApp2Park(
            text: 'Abrir Caixa',
              onPressed: (){
              Navigator.of(context).pushNamed(OpenCashierPageViewRoute);
            },
          ),
        ],
      ),
    );
  }
  alertModals(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pushNamed(HomeParkViewRoute);
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

  Future<void> requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();


    setState(() {
    });
  }

  void _onQRviewCreated(QRViewController controller) {

    this.controller = controller;
    controller.scannedDataStream.listen((scanData){

      String scan = scanData.split('&')[1];

      String scan2 = scan.split('=')[1];


      setState(() {
        _cupom.text = scan2;
        lerqr = false;
      });
    });

  }
}

import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park/ParkDao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/vehicles_dao.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/ParkOff.dart';
import 'package:app2park/moduleoff/ticket/tickets_off_model.dart';
import 'package:app2park/moduleoff/vehicles/vehicles_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class CupomPrintPage extends StatefulWidget {
  @override
  _CupomPrintPageState createState() => _CupomPrintPageState();
}

class _CupomPrintPageState extends State<CupomPrintPage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice _device;
  bool _connected = false;
  String pathImage;
  TestPrint testPrint;
  Timer _timer;
  SharedPref sharedPref = SharedPref();
  int id_ticket_app = 0;
  int id_ticket = 0;
  TicketsOffModel ticketOffModel;
  TicketsDao ticketsDao = TicketsDao();
  ParkDao parkDao = ParkDao();
  VehiclesDao vehicleDao = VehiclesDao();
  VehiclesOffModel vehiclesOffModel;
  ParkOff parkOff;
  int id_cupom;
  String data_entrada;
  String nome_estacionamento;
  String placa;
  String data;
  bool carregando = false;
  User userLoad = User();
  int id_ticke = 1;

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    initPlatformState();
    initSavetoPath();
    testPrint= TestPrint();
  }

  initSavetoPath()async{
    //read and write
    //image max 300px X 300px
    final filename = 'logo-app2park_branco.png';
    var bytes = await rootBundle.load("assets/img/logo-app2park_branco.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes,'$dir/$filename');
    setState(() {
      pathImage='$dir/$filename';
    });
  }

  loadSharedPrefs() async {
    try {

      var connectivityResult =
      await (Connectivity().checkConnectivity());

      int id = await sharedPref.read("id_ticket_app");
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        id_ticke =  await sharedPref.read("id_ticket") ?? 1;
      }
      TicketsOffModel ticketsModel = await ticketsDao.getTicketByIdTicketApp(id);
      ParkOff parkof = await parkDao.getParksByIdPark(ticketsModel.id_park);
      VehiclesOffModel vehicle = await vehicleDao.getVehicleById(ticketsModel.id_vehicle_app ?? 1);
      User user = User.fromJson(await sharedPref.read("user"));

      setState(() {
        id_ticket_app = id;
        ticketOffModel = ticketsModel;
        vehiclesOffModel = vehicle;
        userLoad = user;
        parkOff = parkof;
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          id_ticket = id_ticke;
        }
        id_cupom = ticketsModel.id_cupom;
        data_entrada = ticketsModel.cupom_entrance_datetime;
        nome_estacionamento = parkof.name_park;
        placa = vehicle.plate;
        data = "app2park.com.br/ticket.php";
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          data = "app2park.com.br/ticket.php?id=${id_ticke}&cupom=${ticketsModel.id_cupom}";
        }else{
          data = "app2park.com.br/ticket.php?id_app=${id}&cupom=${ticketsModel.id_cupom}&park=${ticketsModel.id_park}";
        }
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO CUPO PRINT PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }


  Future<void> initPlatformState() async {
    bool isConnected=await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if(isConnected) {
      setState(() {
        _connected=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
        title: Text('Imprimir Cupom'),

      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 10,),
                  Text(
                    'Impressora:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 30,),
                  Expanded(
                    child: DropdownButton(
                      items: _getDeviceItems(),
                      onChanged: (value) => setState(() => _device = value),
                      value: _device,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.brown,
                    onPressed:(){
                      initPlatformState();
                    },
                    child: Text('Buscar dispositivos', style: TextStyle(color: Colors.white),),
                  ),
                  SizedBox(width: 20,),
                  RaisedButton(
                    color: _connected ?Colors.red:Colors.green,
                    onPressed:
                    _connected ? _disconnect : _connect,
                    child: Text(_connected ? 'Desconectar' : 'Conectar', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                child:  RaisedButton(
                  color: Colors.brown,
                  onPressed:(){
                    testPrint.sample(pathImage, id_cupom.toString(), placa, data_entrada, nome_estacionamento, data, parkOff, vehiclesOffModel, userLoad);
                  },
                  child: Text('Imprimir Cupom', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }


  void _connect() {
    if (_device == null) {
      show('No device selected.');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth.connect(_device).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }


  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = true);
  }

//write to app path
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future show(
      String message, {
        Duration duration: const Duration(seconds: 3),
      }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }
}

class TestPrint {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample(String pathImage, String id_cupom, String placa, String data_entrada, String nome_estacionamento, String data, ParkOff parkOff, VehiclesOffModel vehicle, User user) async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT

//     var response = await http.get("IMAGE_URL");
//     Uint8List bytes = response.bodyBytes;
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.printNewLine();
        bluetooth.printCustom("APP2PARK",3,2);
        bluetooth.printNewLine();
        bluetooth.printCustom("CUPOM",3,1); //path of your image/logo
        bluetooth.printNewLine();
        bluetooth.printCustom("Cupom : $id_cupom",0,0);
        bluetooth.printCustom("Placa : $placa",0,0);
        bluetooth.printCustom("Entrada : $data_entrada",0,0);
        bluetooth.printNewLine();
        bluetooth.printCustom("Veiculo :",1,1);
        bluetooth.printCustom("${vehicle.model} ",0,0);
        bluetooth.printCustom("${vehicle.maker} ",0,0);
        bluetooth.printCustom("${vehicle.year} ",0,0);
        bluetooth.printCustom("${vehicle.color} ",0,0);
        bluetooth.printNewLine();
        bluetooth.printCustom("Estacionamento :",1,1);
        bluetooth.printCustom("$nome_estacionamento ",0,0);
        bluetooth.printCustom("${parkOff.street} ${parkOff.number}",0,0);
        bluetooth.printCustom("${parkOff.city} ${parkOff.state}",0,0);
        bluetooth.printCustom("CNPJ : ${parkOff.doc} ",0,0);
        bluetooth.printCustom("Atendente :  ${user.first_name} ${user.last_name} ",0,0);
        bluetooth.printNewLine();
        bluetooth.printCustom("Acesso o link abaxo para:  ",0,0);
        bluetooth.printCustom("- Solicitar sua NF/Recibo",0,0);
        bluetooth.printCustom("- Visualizar as fotos do veículo",0,0);
        bluetooth.printNewLine();
        bluetooth.printCustom("$data",0,1);
        bluetooth.printNewLine();
        bluetooth.printQRcode("$data", 200, 200, 2);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}
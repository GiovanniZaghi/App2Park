import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/price/extrato.dart';
import 'package:app2park/app/helpers/price/price_helper_class.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park/ParkDao.dart';
import 'package:app2park/db/dao/ticket_service_additional_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/vehicles_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/exit_service_additional_model.dart';
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
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';


class CupomExitPrintPage extends StatefulWidget {
  @override
  _CupomExitPrintPageState createState() => _CupomExitPrintPageState();

}

class _CupomExitPrintPageState extends State<CupomExitPrintPage> {

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
  String data_saida;
  String nome_estacionamento;
  String placa;
  String data;
  bool carregando = false;
  User userLoad = User();
  int id_ticke = 1;
  TicketServiceAdditionalDao ticketServiceAdditionalDao =
  TicketServiceAdditionalDao();
  List<ExitServiceAdditionalModel> exitserviceAdittionalList = List<ExitServiceAdditionalModel>();
  List<Extrato> eList = List<Extrato>();
  double total_adicional = 0;
  DateTime dataEntrada;
  double valor_total = 0.0;
  double valor_tabela = 0.0;
  double valor_total_extrato = 0.0;
  String tempoPodeFicar = '';




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

      Park ps = Park.fromJson(await sharedPref.read("park"));
      int id_tick = await sharedPref.read("id_ticket_app");
      String ent = await sharedPref.read("entrada");
      String sai = await sharedPref.read('saida');
      var toleranciaSoma = DateTime.parse('2020-09-28 00:00:00');
      String daily = await sharedPref.read("diaria");
      DateTime tolerancia;
      int id_price_detached_app =
      await sharedPref.read("id_price_detached_app");

      exitserviceAdittionalList = await ticketServiceAdditionalDao
          .getAllServicesAdditionalByIdTicketApp(id_tick);

      TicketsOffModel ticketsModel = await ticketsDao.getTicketByIdTicketApp(id_tick);
      ParkOff parkof = await parkDao.getParksByIdPark(ticketsModel.id_park);
      VehiclesOffModel vehicle = await vehicleDao.getVehicleById(ticketsModel.id_vehicle_app ?? 1);
      User user = User.fromJson(await sharedPref.read("user"));
      if(exitserviceAdittionalList.length < 1){
        tolerancia = DateTime.parse('2020-09-28 00:00:00');
      }
      for (int i = 0; i < exitserviceAdittionalList.length; i++) {
        ExitServiceAdditionalModel e = exitserviceAdittionalList[i];
        total_adicional += e.price;

        var lck = e.lack.split(':');
        tolerancia = toleranciaSoma.add(Duration(hours: int.tryParse(lck[0]), minutes: int.tryParse(lck[1]), seconds: int.tryParse(lck[2])));

      }
      valor_total += total_adicional;


      PriceHelperClass priceHelper = PriceHelperClass();
      var dai = daily.split(':');

      int hr = int.tryParse(dai[0]);
      int min = int.tryParse(dai[1]);
      int sec = int.tryParse(dai[2]);

      eList = await priceHelper.calcularPreco(ent, sai, id_price_detached_app, tolerancia.hour, tolerancia.minute, tolerancia.second, hr, min, sec);

      for (int i = 0; i < eList.length; i++) {
        Extrato extrato = eList[i];

        if (extrato.nome == "Total") {
          valor_total_extrato = extrato.preco;
        }
      }

      Extrato efinal = eList.last;
      tempoPodeFicar = efinal.nome;

      setState(() {
        id_ticket_app = id_tick;
        ticketOffModel = ticketsModel;
        vehiclesOffModel = vehicle;
        userLoad = user;
        parkOff = parkof;
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          id_ticket = id_ticke;
        }
        id_cupom = ticketsModel.id_cupom;
        data_entrada = ent;
        data_saida = sai;
        nome_estacionamento = parkof.name_park;
        placa = vehicle.plate;
        valor_tabela = valor_total_extrato;
        valor_total = total_adicional + valor_tabela;
      });

    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO CUPOM EXIT PRINT PAGE', 'APP');
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
                    for(int i = 0; i < exitserviceAdittionalList.length; i++){
                      removerAcentos(exitserviceAdittionalList[i].name);
                      print("REGEX : " + removerAcentos(exitserviceAdittionalList[i].name));
                    }
                    for(int i = 0; i< eList.length; i++){
                      removerAcentos(eList[i].nome);
                      print("REGEX : " + removerAcentos(eList[i].nome));
                    }
                    testPrint.sample(pathImage, id_cupom.toString(), placa, data_entrada, nome_estacionamento, data, parkOff, vehiclesOffModel, userLoad, exitserviceAdittionalList, data_saida, eList, '${NumberFormat.currency(name: '').format(valor_total)}');
                  },
                  child: Text('Imprimir Cupom', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20,),
              ButtonApp2Park(text: 'Voltar Inicio', onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeParkViewRoute, (Route<dynamic> route) => false);
              },),
            ],
          ),
        ),
      ),
    );
  }


  String removerAcentos(String texto)
  {

    String comAcentos = "ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç";
    String semAcentos = "AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc";

    for (int i = 0; i < comAcentos.length; i++)
    {
      texto = texto.replaceAll(comAcentos[i], semAcentos[i]);
    }
    return texto;
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

String removerAcentos(String texto) {
  print(texto);

  String comAcentos = "ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç";
  String semAcentos = "AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc";
  for (int i = 0; i < comAcentos.length; i++)
  {
    texto = texto.replaceAll(new RegExp(comAcentos), semAcentos);
    print(texto);
  }

  print(texto);
  return texto;
}



class TestPrint {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample(String pathImage, String id_cupom, String placa, String data_entrada, String nome_estacionamento, String data, ParkOff parkOff, VehiclesOffModel vehicle, User user, List<ExitServiceAdditionalModel> exitserviceAdittionalList, String data_saida,
      List<Extrato> eList, String valor_total, {Function removerAcentos}) async {
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
        bluetooth.printCustom("Recibo",3,1); //path of your image/logo
        bluetooth.printNewLine();
        bluetooth.printCustom("Entrada : $data_entrada",0,0);
        bluetooth.printCustom("Saida : $data_saida",0,0);
        bluetooth.printCustom("Estacionamento :",1,1);
        bluetooth.printCustom("${nome_estacionamento.toString().replaceAll(new RegExp("[ãâàáä]"), "a")
            .replaceAll(new RegExp("[êèéë]"), "e")
            .replaceAll(new RegExp("[îìíï]"), "i")
            .replaceAll(new RegExp("[õôòóö]"), "o")
            .replaceAll(new RegExp("[ûúùü]"), "u")
            .replaceAll(new RegExp("[ÃÂÀÁÄ]"), "A")
            .replaceAll(new RegExp("[ÊÈÉË]"), "E")
            .replaceAll(new RegExp("[ÎÌÍÏ]"), "I")
            .replaceAll(new RegExp("[ÕÔÒÓÖ]"), "O")
            .replaceAll(new RegExp("[ÛÙÚÜ]"), "U")
            .replaceAll('ç', 'c')
            .replaceAll('Ç', 'C')
            .replaceAll('ñ', 'n')
            .replaceAll('Ñ', 'N')} ",0,0);
        bluetooth.printCustom("${parkOff.street.toString().replaceAll(new RegExp("[ãâàáä]"), "a")
            .replaceAll(new RegExp("[êèéë]"), "e")
            .replaceAll(new RegExp("[îìíï]"), "i")
            .replaceAll(new RegExp("[õôòóö]"), "o")
            .replaceAll(new RegExp("[ûúùü]"), "u")
            .replaceAll(new RegExp("[ÃÂÀÁÄ]"), "A")
            .replaceAll(new RegExp("[ÊÈÉË]"), "E")
            .replaceAll(new RegExp("[ÎÌÍÏ]"), "I")
            .replaceAll(new RegExp("[ÕÔÒÓÖ]"), "O")
            .replaceAll(new RegExp("[ÛÙÚÜ]"), "U")
            .replaceAll('ç', 'c')
            .replaceAll('Ç', 'C')
            .replaceAll('ñ', 'n')
            .replaceAll('Ñ', 'N')} ${parkOff.number}",0,0);
        bluetooth.printCustom("${parkOff.city.toString()..replaceAll("ã", "a")
            .replaceAll(new RegExp("[êèéë]"), "e")
            .replaceAll(new RegExp("[îìíï]"), "i")
            .replaceAll(new RegExp("[õôòóö]"), "o")
            .replaceAll(new RegExp("[ûúùü]"), "u")
            .replaceAll(new RegExp("[ÃÂÀÁÄ]"), "A")
            .replaceAll(new RegExp("[ÊÈÉË]"), "E")
            .replaceAll(new RegExp("[ÎÌÍÏ]"), "I")
            .replaceAll(new RegExp("[ÕÔÒÓÖ]"), "O")
            .replaceAll(new RegExp("[ÛÙÚÜ]"), "U")
            .replaceAll('ç', 'c')
            .replaceAll('Ç', 'C')
            .replaceAll('ñ', 'n')
            .replaceAll('Ñ', 'N')} ${parkOff.state.toString().replaceAll("ã", "a")
            .replaceAll(new RegExp("[êèéë]"), "e")
            .replaceAll(new RegExp("[îìíï]"), "i")
            .replaceAll(new RegExp("[õôòóö]"), "o")
            .replaceAll(new RegExp("[ûúùü]"), "u")
            .replaceAll(new RegExp("[ÃÂÀÁÄ]"), "A")
            .replaceAll(new RegExp("[ÊÈÉË]"), "E")
            .replaceAll(new RegExp("[ÎÌÍÏ]"), "I")
            .replaceAll(new RegExp("[ÕÔÒÓÖ]"), "O")
            .replaceAll(new RegExp("[ÛÙÚÜ]"), "U")
            .replaceAll('ç', 'c')
            .replaceAll('Ç', 'C')
            .replaceAll('ñ', 'n')
            .replaceAll('Ñ', 'N')}",0,0);
        bluetooth.printCustom("DOC : ${parkOff.doc} ",0,0);
        bluetooth.printNewLine();
        exitserviceAdittionalList.length == 1 ? bluetooth.printCustom("Servicos Adicionais:  ",1,1) : null;
        for(int i = 0; i < exitserviceAdittionalList.length; i++){
          bluetooth.printCustom("${exitserviceAdittionalList[i].name.toString().replaceAll(new RegExp("[ãâàáä]"), "a")
              .replaceAll(new RegExp("[êèéë]"), "e")
              .replaceAll(new RegExp("[îìíï]"), "i")
              .replaceAll(new RegExp("[õôòóö]"), "o")
              .replaceAll(new RegExp("[ûúùü]"), "u")
              .replaceAll(new RegExp("[ÃÂÀÁÄ]"), "A")
              .replaceAll(new RegExp("[ÊÈÉË]"), "E")
              .replaceAll(new RegExp("[ÎÌÍÏ]"), "I")
              .replaceAll(new RegExp("[ÕÔÒÓÖ]"), "O")
              .replaceAll(new RegExp("[ÛÙÚÜ]"), "U")
              .replaceAll('ç', 'c')
              .replaceAll('Ç', 'C')
              .replaceAll('ñ', 'n')
              .replaceAll('Ñ', 'N')}",0,0);

        }
        bluetooth.printNewLine();
        bluetooth.printCustom("Extrato:  ",1,1);
        bluetooth.printCustom("Tipo: | Quantidade: | Preco:  ",1,1);
        for(int i = 0; i < eList.length; i++){
          bluetooth.printCustom("${eList[i].nome.toString().replaceAll(new RegExp("ã"), "a")
              .replaceAll(new RegExp("[êèéë]"), "e")
              .replaceAll(new RegExp("[îìíï]"), "i")
              .replaceAll(new RegExp("[õôòóö]"), "o")
              .replaceAll(new RegExp("[ûúùü]"), "u")
              .replaceAll(new RegExp("[ÃÂÀÁÄ]"), "A")
              .replaceAll(new RegExp("[ÊÈÉË]"), "E")
              .replaceAll(new RegExp("[ÎÌÍÏ]"), "I")
              .replaceAll(new RegExp("[ÕÔÒÓÖ]"), "O")
              .replaceAll(new RegExp("[ÛÙÚÜ]"), "U")
              .replaceAll('ç', 'c')
              .replaceAll('Ç', 'C')
              .replaceAll('ñ', 'n')
              .replaceAll('Ñ', 'N')} | ${eList[i].quantidade} | ${eList[i].preco}",0,0);
        }
        bluetooth.printNewLine();

        bluetooth.printCustom("Total: $valor_total",2,2);
        bluetooth.printNewLine();
        bluetooth.printCustom(" ",2,2);
        bluetooth.printCustom(" ",2,2);
        bluetooth.printCustom(" ",2,2);
        bluetooth.paperCut();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printNewLine();
      }
    });
  }
}
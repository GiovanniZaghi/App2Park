import 'dart:io';

import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'dart:io' show Platform;
import 'package:image_picker/image_picker.dart';
const String TEXT_SCANNER = 'TEXT_SCANNER';
const String BARCODE_SCANNER = 'BARCODE_SCANNER';

class EntryCarPage extends StatefulWidget {
  @override
  _EntryCarPageState createState() => _EntryCarPageState();
}


class _EntryCarPageState extends State<EntryCarPage> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _textValue = "Aguardando Leitura";
  SharedPref sharedPref = SharedPref();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "",
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
          Text(_textValue),
           Platform.isIOS ? Container() : ButtonApp2Park(
            text: 'Capturar Placa',
            onPressed: () async {

              await _read();
              sharedPref.remove('placa');
              sharedPref.save("placa", _textValue);
              Navigator.of(context).pushNamed(CheckDataSimpleOffPageViewRoute);
            },
          ),
          SizedBox(
            height: 20,
          ),
          ButtonApp2Park(
            text: 'Digitar Placa',
            onPressed: () {
              //Navigator.of(context).pushNamed(EntryTextViewRoute);
              Navigator.of(context).pushNamed(EntryTextSimplePageViewRoute);
            },
          ),
        ],
      ),
    );
  }


  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        autoFocus: true,
        flash: false,
        showText: true,
        multiple: true,
        fps: 1,
        waitTap: true,
      );

      for(int i = 0; i <texts.length; i++){
        setState(() {
          String plateReplaced = texts[i].value.replaceAll("-", "");
          plateReplaced = plateReplaced.replaceAll(" ", "");
          bool ok = ValidaPlaca(plateReplaced);
          if(ok){
            _textValue = plateReplaced;
          }else{
          }
        });
      }
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }
}

bool ValidaPlaca(String plate){
  RegExp placaAntiga = new RegExp(
    r"[a-zA-Z]{3}[0-9]{4}",
    caseSensitive: true,
    multiLine: false,
  );
  RegExp placaNova = new RegExp(
    r"[a-zA-Z]{3}[0-9]{1}[a-zA-Z]{1}[0-9]{2}",
    caseSensitive: true,
    multiLine: false,
  );

  if(placaAntiga.hasMatch(plate)){
    if(plate.length == 7){
      return true;
    }
  }
  if(placaNova.hasMatch(plate)){
    if(plate.length == 7){
      return true;
    }
  }
  return false;
}


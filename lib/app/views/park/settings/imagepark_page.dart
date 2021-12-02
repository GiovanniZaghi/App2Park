import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';

import '../../../../config_dev.dart';

Future<Response> sendForm(
    String url, Map<String, dynamic> data, Map<String, File> files) async {
  Map<String, MultipartFile> fileMap = {};
  for (MapEntry fileEntry in files.entries) {
    File file = fileEntry.value;
    String fileName = basename(file.path);
    fileMap[fileEntry.key] =
        MultipartFile(file.openRead(), await file.length(), filename: fileName);
  }
  data.addAll(fileMap);
  var formData = FormData.fromMap(data);
  Dio dio = new Dio();
  return await dio.post(url,
      data: formData, options: Options(contentType: 'multipart/form-data'));
}

Future<Response> sendFile(String url, File file) async {
  Dio dio = new Dio();
  var len = await file.length();
  var response = await dio.post(url,
      data: file.openRead(),
      options: Options(headers: {
        Headers.contentLengthHeader: len,
      } // set content-length
          ));
  return response;
}


class ImageParkPage extends StatefulWidget {
  ImageParkPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ImageParkPageState createState() => _ImageParkPageState();
}

class _ImageParkPageState extends State<ImageParkPage> {

  Park park = Park();
  SharedPref sharedPref = SharedPref();

  loadSharedPrefs() async {
    try {
      Park ps = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        park = ps;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPrefs();
  }

  File _image;
  Future<File> file;
  var image;

  chooseImage() {
    setState(() async {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      showImage();
    });

  }
  showImage(){
    setState(() {
      _image = image;
    });
  }
  _alertModal(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text(text),
      onPressed: () {
        Navigator.of(context).pushNamed(HomeViewRoute);
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


  Future getImage(context) async {
    //upload image
    //scenario  one - upload image as poart of formdata
    var res1 = await sendForm(urlRequest+'api/parks/photo',
        {'id_park': park.id ?? '1'}, {'file': image});
    if(res1.statusCode == 200){
      _alertModal(context, "Foto Atualizada", "Nova Foto Atualizada com Sucesso");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logo do Estacionamento"),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlineButton(
              onPressed: chooseImage,
              child: Text('Selecione a Imagem'),
            ),

            Center(
              child: _image == null
                  ? Text('Nenhuma imagem selecionada')
                  : Image.file(_image),
            ),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              onPressed: (){
                getImage(context);
              },
              child: Text('Salvar imagem'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/version_dao.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/version_off.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/routes/ConstRoutes.dart';
class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}
class _AboutState extends State<About> {
  bool travado = true;
  String vers = '';
  VersionDao versionDao = VersionDao();
  @override
  void initState() {
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
  }
  loadSharedPrefs() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      vers = packageInfo.version;
      List<VersionOff> ListVersionOff = await versionDao.getVersionInfo();
      for (int i = 0; i < ListVersionOff.length; i++) {
        VersionOff versionOff = ListVersionOff[i];
        if (versionOff.name == vers) {
          setState(() {
            travado = false;
          });
        }
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO ABOUT PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }
  abrirUrlPrivacy() async {
    const url =
        'https://app2park.com.br/privacy.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  abrirUrl() async {
    const url =
        'https://www.youtube.com/channel/UCFRXE1XmZobWIjFoh6VuIAA/playlists';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  abrirUrlSite() async {
    const url = 'https://www.app2park.com.br';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  abrirUrlWpp() async {
    const url = 'https://api.whatsapp.com/send?phone=+5511933165686';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  abrirUrlEmail() async {
    const url = 'mailto:app2park@app2park.com.br';
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
        title: Text('Sobre o App2Park'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }
  _body(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Text(
                  'Versão do App : ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$vers',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Text(
              'Descrição : ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text('APP para Gerenciamento de Estacionamentos de Veículos',style: TextStyle(fontSize: 18),),
            SizedBox(height: 15,),
            Row(
              children: [
                Text(
                  'Site : ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Text(
                    'www.App2Park.com.br',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    abrirUrlSite();
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Fone : ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  child: Text(
                    '(11) 93316-5686(WhatsApp)',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    abrirUrlWpp();
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Email : ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  child: Text(
                    'app2park@app2park.com.br',
                    style:
                    TextStyle(fontSize: 15, color: Colors.lightBlueAccent),
                  ),
                  onTap: () {
                    abrirUrlEmail();
                  },
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text('Treinamento : ',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                InkWell(
                  onTap: (){
                    abrirUrl();
                  },
                  child: Text('Youtube',style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text(
                  'NOVANDI INFORMÁTICA',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'CNPJ : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '64.656.465/0001-88',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            Text(
              'Rua dos 3 Irmãos,201 - Cj. 87',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text('CEP: 05615-190',style: TextStyle(
              fontSize: 20,
            ),),
            Text('Brasil - Morumbi - São Paulo - SP',style: TextStyle(
              fontSize: 20,
            ),),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Política de Privacidade: ',style: TextStyle(fontSize: 20),),
                InkWell(child: Text('Clique Aqui',style: TextStyle(fontSize: 20,color: Colors.lightBlueAccent),),onTap: (){abrirUrlPrivacy();},),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ButtonApp2Park(
              text: 'Voltar',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
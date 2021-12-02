import 'dart:io';

import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/generated/i18n.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerPerson extends StatefulWidget {
  @override
  _DrawerPersonState createState() => _DrawerPersonState();
}

class _DrawerPersonState extends State<DrawerPerson> {
  User userLoad = User();
  SharedPref sharedPref = SharedPref();
  String nome = '';
  String email = '';
  String first = '';

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sharedPref.read("user"));
      setState(() {
        userLoad = user;
        nome = userLoad.first_name + ' ' + userLoad.last_name;
        email = userLoad.email;
        first = userLoad.first_name.substring(0, 1) +
            '' +
            userLoad.last_name.substring(0, 1);
      });
    } catch (e) {
      print(e);
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO DRAWER PERSON', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  abrirUrl() async {
    const url = 'https://www.youtube.com/channel/UCFRXE1XmZobWIjFoh6VuIAA/playlists';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(41, 202, 168, 3),
        child: _listMenu(),
      ),
    );
  }

  Widget _avatar(context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color.fromRGBO(41, 202, 168, 3),
      ),
      accountName: Text(nome ?? " "),
      accountEmail: Text(email ?? " "),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.blueAccent
            : Colors.white,
        child: Text(
          first ?? " ",
          style: TextStyle(
            fontSize: 30.0,
            color: Color.fromRGBO(41, 202, 168, 3),
          ),
        ),
      ),
    );
  }

  _listMenu() {
    return ListView(
      children: <Widget>[
        _avatar(context),
        Divider(
          color: Colors.white,
        ), // adiciona o avatar
        ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              "Início",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Voltar para o Início",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeViewRoute, (Route<dynamic> route) => false);
            }),
        ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            title: Text(
              "Dados do usuário",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Alterar Dados",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(ChangeDataViewRoute);
            }),

        ListTile(
            leading: Icon(
              Icons.directions_car,
              color: Colors.white,
            ),
            title: Text(
              "Criar Estacionamento",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Cria um Estacionamento",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              var connectivityResult =
                  await (Connectivity().checkConnectivity());

              if (connectivityResult == ConnectivityResult.mobile ||
                  connectivityResult == ConnectivityResult.wifi) {
                Navigator.of(context).pushNamed(AskViewRoute);
              }else{
                alertModal(context, 'Atenção', 'Para utilizar desse recurso, você precisa está conectado a internet!!');
              }
            }),
        Platform.isIOS ? Divider(color: Colors.white,) : ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              "Assinatura",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Assinatura App2Park",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                  SignaturePageViewRoute);
            }),
        ListTile(
            leading: Icon(
              Icons.help_outline,
              color: Colors.white,
            ),
            title: Text(
              "Sobre",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "About",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AboutPageViewRoute);

            }),
        ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: Text(
              "Configurações",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Configurações",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(SettingsViewRoute);
            }),
      ],
    );
  }
}

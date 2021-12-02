import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/sinc/sinc.dart';
import 'package:app2park/app/menu/home/DrawerPerson.dart';
import 'package:app2park/app/menu/home/ScreenWidget.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import "package:flutter/material.dart";


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animationTranslate;
  Animation animationSize;
  Animation animationSizeBorder;
  User userLoad = User();
  SharedPref sharedPref = SharedPref();
  Sinc sinc = Sinc();

  @override
  void initState() {
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    animationTranslate = Tween(begin: 0.0, end: 300.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    animationTranslate.addListener(() {
      setState(() {});
    });
    animationSize = Tween(begin: 1.0, end: 0.8)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    animationSize.addListener(() {
      setState(() {});
    });

    animationSizeBorder = Tween(begin: 0.0, end: 10.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    animationSizeBorder.addListener(() {
      setState(() {});
    });
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sharedPref.read("user"));
      setState(() {
        userLoad = user;
      });

      sinc.sincPeriodicPark(context, user.id);
      sinc.start3();
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO HOME', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _onTapMenu() {
    if (controller.value == 1) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DrawerPerson(),
        Transform.scale(
          scale: animationSize.value,
          child: Container(
              transform: Matrix4.identity()
                ..translate(animationTranslate.value, 0.0),
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(animationSizeBorder.value),
                  child: ScreenWidget(
                    onTap: _onTapMenu,
                  ))),
        )
      ],
    );
  }
}

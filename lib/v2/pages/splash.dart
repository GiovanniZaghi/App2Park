import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

class SplashScreenWidget extends StatelessWidget {
  SplashScreenWidget({this.screenDestiny});
  final Widget screenDestiny;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 3,
          // imageBackground: AssetImage("assets/bg_splash.png"),
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(0,250,154,5),
              Color.fromRGBO(0,255,127,90),
              Color.fromRGBO(60,179,93,100),
            ],
          ),
          navigateAfterSeconds: screenDestiny,
          useLoader: false,
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/logo-app2park_branco.png"),
              fit: BoxFit.none,
            ),
          ),
        ),
      ],
    );
  }
}
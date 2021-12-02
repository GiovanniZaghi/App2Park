import 'dart:async';

import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class isLoadingPage extends StatefulWidget {
  @override
  _isLoadingPageState createState() => _isLoadingPageState();
}
class _isLoadingPageState extends State<isLoadingPage> with TickerProviderStateMixin {
  AnimationController _controllerAnimation;
  @override
  void initState() {
    super.initState();
    _controllerAnimation = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
  }
  @override
  void dispose() {
    _controllerAnimation.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //Timer(Duration(seconds: 10),() => Navigator.of(context).pushNamedAndRemoveUntil(HomeViewRoute, (route) => false));
    return WillPopScope(

      onWillPop: () => Future.value(false),
      child: Center(

        child: AnimatedBuilder(

          animation: _controllerAnimation,
          builder: (_, child) {
            return Transform.rotate(


              angle: _controllerAnimation.value * 2 * pi,
              child: child,
            );
          },
          child: Stack(

            children: [
              Image.asset(
                "assets/img/ellipse_inside.png",
                width: 200,
                height: 200,
              ),
              Image.asset(
                "assets/img/ellipse_outside.png",
                width: 200,
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
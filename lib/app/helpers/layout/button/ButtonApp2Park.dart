import 'package:flutter/material.dart';

const app2Park = Color.fromRGBO(41, 202, 168, 3);
const App2ParkStyle = TextStyle(color: Colors.white, fontSize: 24);

class ButtonApp2Park extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;
  final Color backgroundColor;
  final TextStyle textStyleApp2Park;

  ButtonApp2Park(
      {this.text = "Ok",
      this.color = app2Park,
      this.onPressed,
      this.backgroundColor,
      this.textStyleApp2Park = App2ParkStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: new RaisedButton(
              onPressed: onPressed,
              color: color,
              child: Text(
                text,
                style: textStyleApp2Park,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              )),
        ),
      ),
    );
  }
}

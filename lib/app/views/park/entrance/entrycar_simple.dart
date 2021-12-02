import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class EntryCarSimple extends StatefulWidget {
  @override
  _EntryCarSimpleState createState() => _EntryCarSimpleState();
}

class _EntryCarSimpleState extends State<EntryCarSimple> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }
}

_body(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ButtonApp2Park(
          text: 'Entrada completa',
          onPressed: () async {
            Navigator.of(context).pushNamed(EntryCarViewRoute);
          },
        ),
        SizedBox(
          height: 20,
        ),
        ButtonApp2Park(
          text: 'Entrada simplificada',
          onPressed: () {
            Navigator.of(context).pushNamed(EntryTextSimplePageViewRoute);
          },
        ),
      ],
    ),
  );
}

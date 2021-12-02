import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
final String text = 'Continuar';

alertModal(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
    child: Text(text),
    onPressed: () {
      Navigator.of(context).pop();
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

abrirUrl() async {
  const url = 'https://www.youtube.com/channel/UCFRXE1XmZobWIjFoh6VuIAA/playlists';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

alertModalYoutube(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
    child: Text('Abrir curso no youtube'),
    onPressed: () {
      abrirUrl();
    },
  );

  Widget ok = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );


  AlertDialog alerta = AlertDialog(
    title: Text(textTitle),
    content: Text(textCenter),
    actions: [
      okButton,
      ok
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

alertButtonClose(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
    child: Text(text),
    onPressed: () {
      Navigator.of(context).pushNamed(HomeParkViewRoute);
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


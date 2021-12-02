import 'package:flutter/material.dart';

class SettingfunctionalitiesPage extends StatefulWidget {
  @override
  _SettingfunctionalitiesPageState createState() => _SettingfunctionalitiesPageState();
}

class _SettingfunctionalitiesPageState extends State<SettingfunctionalitiesPage> {
  bool fun1 = false;
  bool fun2 = false;
  bool fun3 = false;

  bool isFun1 = false;
  bool isFun2 = false;
  bool isFun3 = false;

  Map<String, bool> values = {
    'Utiliza “prisma” para identificar os veículo? ': true,
    'Utiliza vários “Locais de Estacionamento”? ': false,
    'Manobristas utilizarão o APP?': false,
    'Serviços Adicionais  utilizarão o APP? ': false,
    'Participar da Promoção de Lançamento do APP? ': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Funcionalidades"),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return ListView(
      children: values.keys.map((String key) {
        return new CheckboxListTile(
          title: new Text(key),
          value: values[key],
          onChanged: (bool value) {
            setState(() {
              values[key] = value;
            });
          },
        );
      }).toList(),
    );
  }
}

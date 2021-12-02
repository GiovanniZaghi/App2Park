import 'package:flutter/material.dart';

class SettingsHourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Horario de Funcionamento"),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: createTable(),
    );
  }

  createTable() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Table(
          defaultColumnWidth: FixedColumnWidth(130.0),
          border: TableBorder(
            horizontalInside: BorderSide(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            verticalInside: BorderSide(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 1.0,
            ),
          ),
          children: [
            _createLineTable("Dia, Diurno, Noturno"),
            _createLineTable("segunda, 06:00 - 18:00,18:00 - 23:00 "),
            _createLineTable("terça, 06:00 - 18:00, 18:00 - 23:00"),
            _createLineTable("quarta, 06:00 - 18:00, 18:00 - 23:00"),
            _createLineTable("quinta, 06:00 - 18:00, 18:00 - 23:00"),
            _createLineTable("sexta, 06:00 - 18:00, 18:00 - 23:00"),
            _createLineTable("sabado, 06:00 - 14:00, "),
            _createLineTable("domingo, , "),
          ],
        ),
      ),
    );
  }

  _createLineTable(String listaNomes) {
    return TableRow(
      children: listaNomes.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }
}

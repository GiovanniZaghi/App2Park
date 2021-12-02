import 'package:flutter/material.dart';

class TableCheck extends StatefulWidget {
  final bool check;
  final String desc;
  final String preco;
  final String carencia;

  TableCheck(this.check, this.desc, this.preco, this.carencia);

  @override
  _TableCheckState createState() => _TableCheckState();
}

class _TableCheckState extends State<TableCheck> {
  final bool check = false;
  final String desc = '';
  final String preco = '0,00';
  final String carencia = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        children: [
          TableRow(children: [
            TableCell(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: check,
                      onChanged: (bool value) {
                        setState(() {
                          value = check;
                        });
                      },
                    ),
                  ],
                ),
              ),
              verticalAlignment: TableCellVerticalAlignment.bottom,
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(child: Text(desc)),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(child: Text(preco)),
            ),
            TableCell(
              child: Center(child: Text(carencia)),
              verticalAlignment: TableCellVerticalAlignment.top,
            ),
          ]),
        ],
      ),
    );
  }
}

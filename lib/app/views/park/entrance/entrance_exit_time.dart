import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/nav/Nav.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/views/park/entrance/entrance_select_price_page.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ExitTime extends StatefulWidget {
  @override
  _ExitTimeState createState() => _ExitTimeState();
}

class _ExitTimeState extends State<ExitTime> {


  var dateFormat = new DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime maxTime = DateTime.now();
  String _fim =  DateTime.now().toString();
  SharedPref sharedPref = SharedPref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Escolha o horario de saida"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Escolha o horario previsto para saida  ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      minTime: DateTime(maxTime.year,maxTime.month,maxTime.day,),
                      maxTime: DateTime(maxTime.year,maxTime.month, maxTime.day + 363,),
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                    _fim = dateFormat.format(time);
                    setState(() {});
                  }, currentTime: DateTime.parse(_fim), locale: LocaleType.pt);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " ${_fim.substring(0, 19)}",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Escolher",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
        ButtonApp2Park(
          text: 'Escolher Horário',
          onPressed: () {
            sharedPref.save("horario_saida", _fim);
            Navigator.of(context).pushNamedAndRemoveUntil(EntranceSelectPriceViewRoute, (route) => false);
          },
        )
        ],
      ),
    );
  }
}

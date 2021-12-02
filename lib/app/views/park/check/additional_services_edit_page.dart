import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ServiceAdditionalEdit extends StatefulWidget {
  @override
  _ServiceAdditionalEditState createState() => _ServiceAdditionalEditState();
}

class _ServiceAdditionalEditState extends State<ServiceAdditionalEdit> {
  SharedPref sharedPref = SharedPref();
  final _price = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',',precision: 2);
  final _ordem = new TextEditingController();
  final _tolerance = new TextEditingController();
  bool hab = true;
  bool desa = false;
  String _time = '00:00:00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serviços Adicionais preço'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Preço : ', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),

                    ],
                  ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
                    child: TextField(
                      controller: _price,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.attach_money),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Tolerância : ',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 4.0,
                    onPressed: () {
                      DatePicker.showTimePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true, onConfirm: (time) {
                            _time = '${time.toString().substring(11, 19)}';
                            setState(() {
                              _time = '${time.toString().substring(11, 19)}';
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                      setState(() {

                      });
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
                                      " $_time",
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
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Observação : ',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),

                    ],
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.textsms),
                      hintText: 'Digite uma observação'
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonApp2Park(
                    text: 'Salvar',
                    onPressed: (){},
                  ),
                ],
              ),
            ),
          ),
    );
  }
}


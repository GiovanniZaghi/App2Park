import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/validators/Validators.dart';
import 'package:app2park/db/dao/agreement/agreement_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/module/agreement/agreement_model.dart';
import 'package:app2park/module/config/agreement_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/agreements/agreements_off_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:form/form.dart';
import 'package:intl/intl.dart';

class ContractMonthlyEdit extends StatefulWidget {
  @override
  _ContractMonthlyEditState createState() => _ContractMonthlyEditState();
}

class _ContractMonthlyEditState extends State<ContractMonthlyEdit> {
  final _responsavel = new TextEditingController();
  final _telefone = new MaskedTextController(mask: '(00)00000-0000');
  final _email = new TextEditingController();
  final _cpf = new MaskedTextController(mask: '000.000.000-00');
  bool nf = true;
  bool _isVisi = true;
  bool cpf = false;
  bool _isVisible = false;
  bool cnpj = false;
  final _razao = new TextEditingController();
  bool _validateRazao = false;
  final _fone = new MaskedTextController(mask: '(00)00000-0000');
  bool _validateFone = false;
  final _emailJuridico = new TextEditingController();
  bool _validateEmailJuridico = false;
  final _cnpj = new MaskedTextController(mask: '00.000.000/0000-00');
  bool _validateCnpj = false;
  bool boleto = false;
  final _pagamento = new TextEditingController();
  bool seg = true;
  bool ter = true;
  bool qua = true;
  bool qui = true;
  bool sex = true;
  bool sab = true;
  bool dom = true;
  var dateFormat = new DateFormat('yyyy-MM-dd HH:mm:ss');
  var dateFormatOnly = new DateFormat('dd-MM-yyyy');
  String _date = DateTime.now().toString();
  DateTime year = DateTime.now();
  String _time = '2020-10-15 00:00:00';
  String _enc = DateTime.now().toString();
  String _fim = '2020-10-15 00:00:00';
  List<String> platesList = List<String>();
  SharedPref sharedPref = SharedPref();
  PriceDetachedDao priceDao = PriceDetachedDao();
  final _vagas = new TextEditingController();
  final _placas = new TextEditingController();
  final _preco = MoneyMaskedTextController(
      decimalSeparator: '.', precision: 2, thousandSeparator: ',');
  final _comentario = new TextEditingController();
  bool pago = true;
  bool npago = false;
  int id_park = 0;
  int id_user = 0;
  AgreementsDao agreementsDao = AgreementsDao();
  int id_agreement_app = 0;
  int id_agreement = 0;
  DateTime datahora = DateTime.now();
  int id_table = 0;
  String _until = DateTime.now().toString();
  String untilFormat;

  String _ence;
  String _data;

  int id_price_detached = 0;
  Future<List<PriceDetachedOff>> _future;
  PriceDetachedOff selectedPrice;
  PriceDetachedOff _selectedItem;
  List<DropdownMenuItem<PriceDetachedOff>> _dropdownMenuItems;
  List<PriceDetachedOff> _dropdownItems = [];


  List<DropdownMenuItem<PriceDetachedOff>> buildDropDownMenuItems(
      List listItems) {
    List<DropdownMenuItem<PriceDetachedOff>> items = List();
    for (PriceDetachedOff listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
  }

  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      User u = User.fromJson(await sharedPref.read("user"));
      AgreementsOff a =
          AgreementsOff.fromJson(await sharedPref.read("monthly"));
      List<PriceDetachedOff> listStatus =
          await priceDao.getPriceDetached(int.tryParse(p.id));
      for (int i = 0; i < listStatus.length; i++) {
        PriceDetachedOff statusList = listStatus[i];
        _dropdownItems.add(statusList);
      }
      setState(() {
        id_park = int.parse(p.id);
        id_user = int.parse(u.id);
        id_agreement_app = a.id_agreement_app;
        id_agreement = a.id;
        _future = priceDao.getPriceDetached(int.parse(p.id));
        _responsavel.text = a.accountable_name;
        _telefone.text = a.accountable_cell;
        _email.text = a.accountable_email;
        _cpf.text = a.accountable_doc;
        nf = a.send_nf == 1 ? true : false;
        a.doc_nf == 1 ? cnpj = true : cpf = true;
        cnpj == true ? _isVisible = true : _isVisible = false;
        cnpj == true ? _razao.text = a.company_name : _razao.text = '';
        cnpj == true ? _fone.text = a.company_cell : _fone.text = '';
        cnpj == true ? _emailJuridico.text = a.company_email : _emailJuridico.text = '';
        cnpj == true ? _cnpj.text = a.company_doc : _cnpj.text = '';
        boleto = a.bank_slip_send == 1 ? boleto = true : boleto = false;
        _pagamento.text = a.payment_day.toString();
        seg = a.mon == 1 ? true : false;
        ter = a.tue == 1 ? true : false;
        qua = a.wed == 1 ? true : false;
        qui = a.thur == 1 ? true : false;
        sex = a.fri == 1 ? true : false;
        sab = a.sat == 1 ? true : false;
        dom = a.sun == 1 ? true : false;
        _date = a.agreement_begin;
        _data = dateFormatOnly.format(DateTime.parse(a.agreement_begin));
        if(a.time_on.length < 11){
          _time = '2020-10-15 ' + a.time_on;
        }else{
          _time = a.time_on;
        }
        _enc = a.agreement_end;
        _ence = dateFormatOnly.format(DateTime.parse(a.agreement_end));
        if(a.time_off.length < 11){
          _fim = '2020-10-15 ' + a.time_off;
        }else{
          _fim = a.time_off;
        }

        _vagas.text = a.parking_spaces.toString();
        List splitedText = a.plates.split(new RegExp(r","));
        for (int i = 0; i < splitedText.length; i++) {
          RegExp placaAntiga = new RegExp(
            r"[a-zA-Z]{3}[0-9]{4}",
            caseSensitive: true,
            multiLine: false,
          );
          if (placaAntiga.hasMatch(splitedText[i])) {
            platesList.add(splitedText[i]);
          }
          RegExp placaNova = new RegExp(
            r"[a-zA-Z]{3}[0-9]{1}[a-zA-Z]{1}[0-9]{2}",
            caseSensitive: true,
            multiLine: false,
          );
          if (placaNova.hasMatch(splitedText[i])) {
            platesList.add(splitedText[i]);
          }
        }
        _preco.updateValue(a.price);
        _comentario.text = a.comment;
        pago = a.status_payment == 1 ? pago = true : pago = false;
        npago = a.status_payment == 0 ? true : false;
       _until =  a.until_payment == null ? _until = DateTime.now().toString() : a.until_payment;
        untilFormat = dateFormatOnly.format(DateTime.parse(_until));
        print(_until);
        print(untilFormat);
        _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
        _selectedItem = _dropdownMenuItems[0].value;
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO CONTRACT MONTH EDIT PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
        title: Text('Contrato de Mensalista'),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              FormInput(
                "Login",
                child: Column(
                  children: <Widget>[
                    Text(
                      'Contrato de Mensalista',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Respons??vel ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '(nome completo)',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Input(
                      "Responsavel",
                      controller: _responsavel,
                      validators: [
                        Validators.required..msg('Insira o nome completo')
                      ],
                      decoration: InputDecoration(
                          hintText: 'Digite o nome do Responsavel',
                          suffixIcon: Icon(Icons.person)),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Fone : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Input(
                      "Telefone",
                      controller: _telefone,
                      autovalidate: true,
                      keyboardType: TextInputType.number,
                      validators: [
                        Validators.required..msg('Insira o Telefone'),
                        Validators.minLength(14)
                          ..msg('Insira os dados corretamente'),
                      ],
                      decoration: InputDecoration(
                          hintText: 'Digite o telefone',
                          suffixIcon: Icon(Icons.phone)),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'e-Mail : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Input(
                      "Email",
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      autovalidate: true,
                      validators: [
                        Validators.email..msg("Insira um email valido ")
                      ],
                      decoration: InputDecoration(
                          hintText: 'Digite o email',
                          suffixIcon: Icon(Icons.mail)),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'CPF : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Input(
                      "Cpf",
                      controller: _cpf,
                      autovalidate: true,
                      validators: [
                        Validators.required..msg('Insira o CPF'),
                        Validators.minLength(14)
                          ..msg('Insira os dados corretamente'),
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.contact_mail),
                          hintText: 'Digite o CPF'),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Enviar NF ?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Checkbox(
                          value: nf,
                          onChanged: (bool newValue) {
                            setState(() {
                              _isVisi = newValue;
                              _isVisible = false;
                              if (cnpj == true) {
                                _isVisible = newValue;
                              }
                              nf = newValue;
                              if (nf == false) {
                                _isVisi = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: _isVisi,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'CPF :',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Checkbox(
                              value: cpf,
                              onChanged: (bool newValue) {
                                setState(() {
                                  cpf = newValue;
                                  _isVisible = false;
                                  cnpj = false;
                                });
                              },
                            ),
                            Text('ou'),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'CNPJ :',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Checkbox(
                              value: cnpj,
                              onChanged: (bool newValue) {
                                setState(() {
                                  cnpj = newValue;
                                  _isVisible = newValue;
                                  cpf = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: Container(
                        width: 200,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Raz??o : ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            TextField(
                              controller: _razao,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.contact_mail),
                                  errorText: _validateRazao
                                      ? 'Digite uma Raz??o Social'
                                      : null,
                                  hintText: 'Digite a Raz??o Social'),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Fone : ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            TextField(
                              controller: _fone,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.phone),
                                  errorText: _validateFone
                                      ? 'Digite um Telefone'
                                      : null,
                                  hintText: 'Digite o telefone'),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'e-Mail : ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            TextField(
                              controller: _emailJuridico,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.mail),
                                  errorText: _validateEmailJuridico
                                      ? 'Digite um Email '
                                      : null,
                                  hintText: 'Digite o email'),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'CNPJ : ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            TextField(
                              controller: _cnpj,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.contact_mail),
                                  errorText:
                                      _validateCnpj ? 'Digite um CNPJ' : null,
                                  hintText: 'Digite o cnpj'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Enviar boleto ?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                          value: boleto,
                          onChanged: (bool newValue) {
                            setState(() {
                              boleto = newValue;
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Dias da',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'semana',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: seg,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      seg = newValue;
                                    });
                                  },
                                ),
                                Text('seg'),
                                Checkbox(
                                  value: ter,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      ter = newValue;
                                    });
                                  },
                                ),
                                Text('ter'),
                                Checkbox(
                                  value: qua,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      qua = newValue;
                                    });
                                  },
                                ),
                                Text('qua'),
                                Checkbox(
                                  value: qui,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      qui = newValue;
                                    });
                                  },
                                ),
                                Text('qui')
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: sex,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      sex = newValue;
                                    });
                                  },
                                ),
                                Text('sex'),
                                Checkbox(
                                  value: sab,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      sab = newValue;
                                    });
                                  },
                                ),
                                Text('sab'),
                                Checkbox(
                                  value: dom,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      dom = newValue;
                                    });
                                  },
                                ),
                                Text('dom'),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hor??rio de : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
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
                          _time = dateFormat.format(time);
                          setState(() {});
                        },
                            currentTime: DateTime.parse(_time),
                            locale: LocaleType.pt);
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
                                        " ${_time.substring(11,19)}",
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
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'At?? : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
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

                              _fim = dateFormat.format(time);
                              setState(() {});
                            },
                            currentTime: DateTime.parse(_fim),
                            locale: LocaleType.pt);
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
                                        " ${_fim.substring(11,19)}",
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
                    SizedBox(height: 15,),
                    Row(
                      children: <Widget>[
                        Text(
                          'Data inicio : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            theme: DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            showTitleActions: true,
                            minTime: DateTime(year.year - 3, 01, 01),
                            maxTime: DateTime(year.year + 3, 31, 12),
                            onConfirm: (date) {
                              _date = '${date.toString().substring(0, 10)}';
                              _data = dateFormatOnly.format(date);
                              setState(() {});
                            },
                            currentTime: DateTime.parse(_date),
                            locale: LocaleType.pt);
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
                                        Icons.date_range,
                                        size: 18.0,
                                        color: Colors.teal,
                                      ),
                                      Text(
                                        "${_data}",
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
                        Text(
                          'Data Termino : ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            theme: DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            showTitleActions: true,
                            minTime: DateTime(year.year - 3, 01, 01),
                            maxTime: DateTime(year.year + 3, 31, 12),
                            onConfirm: (date) {
                          _enc = '${date.toString().substring(0, 10)}';
                          _ence = dateFormatOnly.format(date);

                          setState(() {});
                        },
                            currentTime: DateTime.parse(_enc),
                            locale: LocaleType.pt);
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
                                        Icons.date_range,
                                        size: 18.0,
                                        color: Colors.teal,
                                      ),
                                      Text(
                                        " ${_ence}",
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
                      height: 20.0,
                    ),
                    Text(
                      'Tabela de Pre??os : ',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Tabela de Pre??o utilizada em caso de exceder o hor??rio contratado.',
                      style:
                      TextStyle(fontSize: 16,),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          child: DropdownButton(
                              value: _selectedItem,
                              items: _dropdownMenuItems,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItem = value;
                                });
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Quantidade de Vagas :',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Input(
                      "Vagas",
                      controller: _vagas,
                      autovalidate: true,
                      validators: [
                        Validators.required..msg("Insira a quantidade de vagas")
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Digite a quantidade de Vagas',
                          suffixIcon: Icon(Icons.format_list_numbered)),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Placas Autorizadas :',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 150,
                          child: SizedBox(
                            child: Input(
                              "Placas",
                              controller: _placas,
                              decoration: InputDecoration(
                                hintText:
                                    'Digite a placa / Clique no + para adicionar',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                platesList
                                    .add(_placas.text.toUpperCase() + ', \n');
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: Column(
                        children: platesList
                            .map<Widget>((v) => Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(v),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              platesList.remove(v);
                                            });
                                          },
                                          child: Icon(
                                            Icons.remove,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Pre??o : ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Input(
                      "Preco",
                      controller: _preco,
                      keyboardType: TextInputType.number,
                      validators: [Validators.required..msg("Insira o Valor")],
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.attach_money),
                          hintText: r'Digite o valor R$ 00.00'),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Comentario : ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Input(
                      "Comentario",
                      controller: _comentario,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.textsms),
                          hintText: 'Digite um comentario'),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        Text('Pago at?? : ',style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            theme: DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            showTitleActions: true,
                            minTime: DateTime(year.year - 3, 01, 01),
                            maxTime: DateTime(year.year + 3, 31, 12),
                            onConfirm: (date) {
                              _until = '${date.toString().substring(0, 10)}';
                              untilFormat = dateFormatOnly.format(date);

                              setState(() {});
                            },
                            currentTime: DateTime.parse(_enc),
                            locale: LocaleType.pt);
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
                                        Icons.date_range,
                                        size: 18.0,
                                        color: Colors.teal,
                                      ),
                                      Text(
                                        " ${untilFormat}",
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
                      height: 25,
                    ),
                    ButtonApp2Park(
                      onPressed: () async {
                        bool validador = false;
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        List<String> erros = List<String>();
                        if (FormInput.get("Login").validate()) {
                          setState(() {
                            if (nf) {
                              if (cnpj) {
                                if (_razao.text.isEmpty) {
                                  _razao.text.isEmpty
                                      ? _validateRazao = true
                                      : _validateRazao = false;
                                  _fone.text.isEmpty
                                      ? _validateFone = true
                                      : _validateFone = false;
                                  _emailJuridico.text.isEmpty
                                      ? _validateEmailJuridico = true
                                      : _validateEmailJuridico = false;
                                  _cnpj.text.isEmpty
                                      ? _validateCnpj = true
                                      : _validateCnpj = false;
                                } else if (_fone.text.isEmpty) {
                                  _razao.text.isEmpty
                                      ? _validateRazao = true
                                      : _validateRazao = false;
                                  _fone.text.isEmpty
                                      ? _validateFone = true
                                      : _validateFone = false;
                                  _emailJuridico.text.isEmpty
                                      ? _validateEmailJuridico = true
                                      : _validateEmailJuridico = false;
                                  _cnpj.text.isEmpty
                                      ? _validateCnpj = true
                                      : _validateCnpj = false;
                                } else if (_emailJuridico.text.isEmpty) {
                                  _razao.text.isEmpty
                                      ? _validateRazao = true
                                      : _validateRazao = false;
                                  _fone.text.isEmpty
                                      ? _validateFone = true
                                      : _validateFone = false;
                                  _emailJuridico.text.isEmpty
                                      ? _validateEmailJuridico = true
                                      : _validateEmailJuridico = false;
                                  _cnpj.text.isEmpty
                                      ? _validateCnpj = true
                                      : _validateCnpj = false;
                                } else if (_cnpj.text.isEmpty) {
                                  _razao.text.isEmpty
                                      ? _validateRazao = true
                                      : _validateRazao = false;
                                  _fone.text.isEmpty
                                      ? _validateFone = true
                                      : _validateFone = false;
                                  _emailJuridico.text.isEmpty
                                      ? _validateEmailJuridico = true
                                      : _validateEmailJuridico = false;
                                  _cnpj.text.isEmpty
                                      ? _validateCnpj = true
                                      : _validateCnpj = false;
                                }
                                _razao.text.isEmpty
                                    ? _validateRazao = true
                                    : _validateRazao = false;
                                _fone.text.isEmpty
                                    ? _validateFone = true
                                    : _validateFone = false;
                                _emailJuridico.text.isEmpty
                                    ? _validateEmailJuridico = true
                                    : _validateEmailJuridico = false;
                                _cnpj.text.isEmpty
                                    ? _validateCnpj = true
                                    : _validateCnpj = false;
                              }
                            }
                          });
                          if (validaCpf(_cpf.text)) {
                          } else {
                            setState(() {
                              validador = true;
                            });
                            erros.add('CPF INVALIDO');
                          }
                          if (nf) {
                            if (cnpj) {
                              if (validaEmail(
                                  _emailJuridico.text.toLowerCase())) {
                                if (validaCnpj(_cnpj.text)) {
                                } else {
                                  setState(() {
                                    validador = true;
                                  });
                                  erros.add('CNPJ INVALIDO');
                                }
                              } else {
                                setState(() {
                                  validador = true;
                                });
                                erros.add("EMAIL JURIDICO INVALIDO");
                              }
                            }
                          }
                          String placas = '';
                          for(int i = 0; i <platesList.length; i++){
                            placas = placas + "," + platesList[i];
                          }
                          if(platesList.length == 0){
                            erros.add('Adicione uma Placa');

                            alertModalsError(context, "Dados Incorretos", erros.toString());
                          }else{
                            if (!validador) {
                              agreementsDao.updateAgreement(
                                  id_park,
                                  id_agreement_app,
                                  _date.substring(0,10),
                                  _enc.substring(0,10),
                                  _responsavel.text,
                                  _cpf.text,
                                  _telefone.text,
                                  _email.text.toLowerCase(),
                                  nf == true ? 1 : 0,
                                  cnpj == true ? 1 : 0,
                                  _razao.text,
                                  _cnpj.text,
                                  _fone.text,
                                  _emailJuridico.text.toLowerCase(),
                                  boleto == true ? 1 : 0,
                                  int.tryParse(_pagamento.text),
                                  seg ? 1 : 0,
                                  ter ? 1 : 0,
                                  qua ? 1 : 0,
                                  qui ? 1 : 0,
                                  sex ? 1 : 0,
                                  sab ? 1 : 0,
                                  dom ? 1 : 0,
                                  _time.substring(11,19),
                                  _fim.substring(11,19),
                                  _selectedItem.id_price_detached_app,
                                  int.parse(_vagas.text),
                                  _preco.numberValue,
                                  platesList.toString().toUpperCase(),
                                  _comentario.text,
                                  0,
                                  _until.toString()
                              );
                              sharedPref.remove("monthly");
                              if (connectivityResult ==
                                  ConnectivityResult.mobile ||
                                  connectivityResult == ConnectivityResult.wifi) {
                                if (id_agreement != 0) {
                                  Agreements agreement = Agreements();
                                  agreement.date_time = datahora.toString();
                                  agreement.agreement_begin = _date.substring(0,10);
                                  agreement.agreement_end = _enc;
                                  agreement.accountable_name = _responsavel.text;
                                  agreement.accountable_doc = _cpf.text;
                                  agreement.accountable_cell = _telefone.text;
                                  agreement.accountable_email =
                                      _email.text.toLowerCase();
                                  agreement.send_nf = nf ? '1' : '0';
                                  agreement.doc_nf = cnpj ? '1' : '0';
                                  agreement.company_name = _razao.text;
                                  agreement.company_doc = _cnpj.text;
                                  agreement.company_cell = _fone.text;
                                  agreement.company_email =
                                      _emailJuridico.text.toLowerCase();
                                  agreement.bank_slip_send = boleto == true ? '1' : '0';
                                  agreement.payment_day = _pagamento.text;
                                  agreement.mon = seg ? '1' : '0';
                                  agreement.tue = ter ? '1' : '0';
                                  agreement.wed = qua ? '1' : '0';
                                  agreement.thur = qui ? '1' : '0';
                                  agreement.fri = sex ? '1' : '0';
                                  agreement.sat = sab ? '1' : '0';
                                  agreement.sun = dom ? '1' : '0';
                                  agreement.time_on = _time.substring(11,19);
                                  agreement.time_off = _fim.substring(11,19);
                                  agreement.id_price_detached = _selectedItem
                                      .id_price_detached_app
                                      .toString();
                                  agreement.parking_spaces = _vagas.text;
                                  agreement.price = _preco.text;
                                  agreement.plates = platesList.toString().toUpperCase();
                                  agreement.comment = _comentario.text;
                                  agreement.status_payment = '0';
                                  agreement.until_payment = _until.toString();
                                  AgreementResponse agreementRes =
                                  await ParkService.updateAgreement(
                                      id_agreement.toString(), agreement);
                                  Agreements agreements = agreementRes.data;
                                }
                              }
                              alertModals(
                                  context, "Sucesso", "Salvo Com Sucesso");
                            } else {
                              alertModalsError(
                                  context, 'Dados Incorretos', erros.toString());
                            }
                          }



                          // Se o formul??rio for v??lido, mostra uma snackbar. Em um projeto real,
                          // voc?? costuma chamar um servidor ou salvar as informa????es em um banco de dados.
                        }
                      },
                      text: 'Salvar',
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

alertModals(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          MonthlyListViewRoute, (Route<dynamic> route) => false);
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
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

alertModalsError(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
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
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

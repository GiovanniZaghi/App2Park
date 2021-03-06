import 'dart:convert';

import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/cashier/movement/cash_movement_dao.dart';
import 'package:app2park/module/cashier/movement/cash_movement_model.dart';
import 'package:app2park/module/cashier/service/cash_service.dart';
import 'package:app2park/module/config/cash_movement_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/cashier/movement/cash_movement_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class PaymentCashierPage extends StatefulWidget {
  @override
  _PaymentCashierPageState createState() => _PaymentCashierPageState();
}

class _PaymentCashierPageState extends State<PaymentCashierPage> {
  var data = new DateTime.now();
  SharedPref sharedPref = SharedPref();
  final _cash = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');
  final _value = new TextEditingController();
  int id_user;
  int id_park;
  User userLoad = User();
  Park parkLoad = Park();
  CashMovementDao cashMoventDao = CashMovementDao();
  String usuario;
  String abertura;
  String fechamento;
  int id_cash_app;
  int id_cash = 0;
  int id_open;
  int res;
  bool ok = true;
  bool _validate = false;
  bool _cashValidate = false;
  String cupom_checkin_datetime =
  DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();

  bool isLoading = false;

  int ress;
  int cashsid;
  int cx;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      var connectivityResult =
      await (Connectivity().checkConnectivity());
      User user = User.fromJson(await sharedPref.read("user"));
      Park park = Park.fromJson(await sharedPref.read("park"));
      res = await cashMoventDao.getCashByUser(int.tryParse(user.id), int.tryParse(park.id));
      List<CashMovementOff> cashMovementList = await cashMoventDao.getCashMovementByIdCash(res);
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        ress = await cashMoventDao.getCashByUserON(res);
      }
      int cashs = res;
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        cashsid = ress;
      }
      CashMovementOff cashMove = cashMovementList.first;
      res = await cashMoventDao.getCashByUser(int.tryParse(user.id), int.tryParse(park.id));
      cx = await cashMoventDao.getCashByPark(int.tryParse(park.id));

      setState(() {
        userLoad = user;
        id_user = int.parse(userLoad.id);
        usuario = userLoad.first_name + ' ' + userLoad.last_name;
        parkLoad = park;
        id_park = int.parse(parkLoad.id);
        id_cash_app = cashs;
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          id_cash = cashsid;
        }
        id_open = cashMove.id_cash_type_movement;
        abertura = cashMove.date_added.substring(0,19);
        fechamento = cashMove.id_cash_type_movement.toString();
        if(res == null){
          ok = true;
        }else{
          ok = false;

        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento de Despesa'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: ok ? _aberto(context) : _body(context),
    );
  }

  _body(BuildContext context) {
    return isLoading ? isLoadingPage() : Container(
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Pagamento de Despesa',
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Usurario : $usuario'),
                Text('Abertura : $abertura'),
                Text('Fechamento : Caixa Aberto'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Dinheiro : ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Container(
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _cash,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: _cashValidate
                            ? 'Valor precisa ser maior que 0'
                            : null,
                        suffixIcon: Icon(Icons.attach_money),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'NF e Raz??o Social : ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _value,
              keyboardType: TextInputType.text,
              maxLength: 50,
              style: TextStyle(),
              decoration: InputDecoration(
                hintText: 'Digite a NF ou Raz??o Social',
                errorText: _validate ? 'NF/Raz??o minimo de 10 digitos' : null,
                suffixIcon: Icon(Icons.comment),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 200,
            child: ButtonApp2Park(
              text: 'Confirmar',
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                var connectivityResult =
                    await (Connectivity().checkConnectivity());
                sharedPref.remove('cashs');
                sharedPref.remove('cashid');

                if (_value.text.length < 10) {
                  setState(() {
                    _validate = true;
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    _validate = false;
                  });
                  double dinheiro = _cash.numberValue;
                  double dinheiroF = _cash.numberValue * -1;
                  if (dinheiro > 0.00) {
                    setState(() {
                      _cashValidate = false;
                    });
                    sharedPref.remove('cashmove');
                    CashMovementOff cashMovementOff = CashMovementOff(
                        0,
                        id_cash,
                        id_cash_app,
                        0,
                        0,
                        0,
                        0,
                        data.toString(),
                        3,
                        1,
                        0,
                        0,
                        '0',
                        dinheiroF.toString(),
                        _value.text);
                   int id_cashs_m = await cashMoventDao.saveCashMovement(cashMovementOff);
                    sharedPref.save("cashmove", cashMovementOff);

                    if (connectivityResult == ConnectivityResult.mobile ||
                        connectivityResult == ConnectivityResult.wifi) {

                      CashMovement cashMovement = CashMovement();
                      cashMovement.id_cash = id_cash.toString();
                      cashMovement.id_cash_movement_app = id_cashs_m.toString();
                      cashMovement.date_added = cupom_checkin_datetime;
                      cashMovement.id_cash_type_movement =  '3';
                      cashMovement.id_payment_method = '1';
                      cashMovement.value_initial = '0';
                      cashMovement.value = dinheiroF.toString();
                      cashMovement.comment = _value.text;

                      CashMovementResponse cashMovementResponse =  await CashTypeService.cashMovement(cashMovement);

                      CashMovement cashMovements = cashMovementResponse.data.first;

                      bool oks = await cashMoventDao.updateCashMovement(int.parse(cashMovements.id), id_cashs_m);

                    }

                    setState(() {
                      isLoading = false;
                    });

                    Navigator.of(context).pushNamed(HomeParkViewRoute);

                    alertButtonClose(context, 'Sucesso', 'Pagamento salvo');
                  } else {
                    setState(() {
                      _cashValidate = true;
                      isLoading = false;
                    });
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _aberto(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Aten????o!!!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'N??o existe um caixa aberto.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          ButtonApp2Park(
            text: 'Voltar',
            onPressed: () {
              Navigator.of(context).pushNamed(HomeParkViewRoute);
            },
          ),
        ],
      ),
    );
  }

  alertModals(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text('OK'),
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
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}

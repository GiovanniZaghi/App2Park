import 'dart:convert';

import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/cashier/cashs_dao.dart';
import 'package:app2park/db/dao/cashier/movement/cash_movement_dao.dart';
import 'package:app2park/module/cashier/cashs_model.dart';
import 'package:app2park/module/cashier/movement/cash_movement_model.dart';
import 'package:app2park/module/cashier/service/cash_service.dart';
import 'package:app2park/module/config/cash_movement_response.dart';
import 'package:app2park/module/config/cash_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/cashier/cashs_off_model.dart';
import 'package:app2park/moduleoff/cashier/movement/cash_movement_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class OpenCashierPage extends StatefulWidget {
  @override
  _OpenCashierPageState createState() => _OpenCashierPageState();
}

class _OpenCashierPageState extends State<OpenCashierPage> {
  User userLoad = User();
  SharedPref sharedPref = SharedPref();
  Park parkLoad = Park();
  int id_user;
  int id_park;
  var data = new DateTime.now();
  CashsDao cashDao = CashsDao();
  CashMovementDao cashMoventDao = CashMovementDao();
  String cupom_checkin_datetime =
  DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();
  int res;
  bool isLoading = false;

  bool ok = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPrefs();
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sharedPref.read("user"));
      Park park = Park.fromJson(await sharedPref.read("park"));
      res = await cashMoventDao.getCashByUser(int.tryParse(user.id), int.tryParse(park.id));
      setState(() {
        userLoad = user;
        id_user = int.parse(userLoad.id);
        parkLoad = park;
        id_park = int.parse(parkLoad.id);
        if (res == null) {
          ok = false;
        } else {
          ok = true;
        }
      });




    } catch (e) {}
  }

  final _cash = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',',precision: 2);
  final _value = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abertura de Caixa'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: ok ? _aberto(context) : _body(context),
    );
  }

  _body(BuildContext context) {
    return isLoading ? isLoadingPage() :  Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Abrir um novo caixa',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Saldo Inicial : ',
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
                          hintText: '000,00',
                          suffixIcon: Icon(Icons.attach_money),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Comentarios : ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Flexible(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _value,
                    keyboardType: TextInputType.text,
                    maxLength: 50,
                    style: TextStyle(),
                    decoration: InputDecoration(
                      hintText: 'Digite seu comentario ',
                      suffixIcon: Icon(Icons.comment),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ButtonApp2Park(
                    text: 'Confirmar',
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      var connectivityResult =
                          await (Connectivity().checkConnectivity());

                      CashsOff cashOff = CashsOff(0, id_park, id_user);

                      int idCash = await cashDao.saveCash(cashOff);
                      double dinheiroF = _cash.numberValue;
                      CashMovementOff cashMovementOff = CashMovementOff(
                          0,
                          0,
                          idCash,
                          0,
                          0,
                          0,
                          0,
                          data.toString(),
                          1,
                          1,
                          0,
                          0,
                          '0',
                          dinheiroF.toString(),
                          _value.text);
                      int id_cashs_m = await cashMoventDao.saveCashMovement(cashMovementOff);
                      if (connectivityResult == ConnectivityResult.mobile ||
                          connectivityResult == ConnectivityResult.wifi) {

                        Cashs cashs =  Cashs();
                        cashs.id_cash_app = idCash.toString();
                        cashs.id_user = userLoad.id;
                        cashs.id_park = parkLoad.id;

                        CashResponse cashResponse = await CashTypeService.cash(cashs);

                        Cashs cashss = cashResponse.data.first;

                        bool ok = await cashDao.updateCashs(int.parse(cashss.id), idCash);


                        CashMovement cashMovement = CashMovement();
                        cashMovement.id_cash = int.parse(cashss.id).toString();
                        cashMovement.id_cash_movement_app = id_cashs_m.toString();
                        cashMovement.date_added = cupom_checkin_datetime;
                        cashMovement.id_cash_type_movement =  '1';
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

                      alertButtonClose(context, 'Sucesso', 'Caixa Aberto');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _aberto(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Atenção !!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Já existe um caixa aberto.'),
          SizedBox(
            height: 5,
          ),
          Text('Não é possível abrir um novo caixa,'),
          SizedBox(
            height: 5,
          ),
          Text('enquanto já existir outro aberto.'),
          SizedBox(
            height: 30,
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
}

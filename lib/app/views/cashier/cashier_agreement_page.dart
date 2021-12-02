import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/agreement/agreement_dao.dart';
import 'package:app2park/db/dao/cashier/movement/cash_movement_dao.dart';
import 'package:app2park/db/dao/payment/payment_method_park_dao.dart';
import 'package:app2park/module/agreement/agreement_model.dart';
import 'package:app2park/module/cashier/movement/cash_movement_model.dart';
import 'package:app2park/module/cashier/service/cash_service.dart';
import 'package:app2park/module/config/agreement_response.dart';
import 'package:app2park/module/config/cash_movement_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/agreements/agreements_off_model.dart';
import 'package:app2park/moduleoff/cashier/movement/cash_movement_off_model.dart';
import 'package:app2park/moduleoff/payment/payment_method_park_inner.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class CashierAgreement extends StatefulWidget {
  @override
  _CashierAgreementState createState() => _CashierAgreementState();
}

class _CashierAgreementState extends State<CashierAgreement> {
  var data = new DateTime.now();
  SharedPref sharedPref = SharedPref();
  final _cash = new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',',precision: 2);
  final _value = new TextEditingController();
  int id_user;
  int id_park;
  User userLoad = User();
  Park parkLoad = Park();
  CashMovementDao cashMoventDao = CashMovementDao();
  String cupom_checkin_datetime =
  DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();
  String usuario;
  String abertura;
  String fechamento;
  int id_cash_app;
  int id_cash = 0;
  int id_open;
  int res;
  bool _validate = false;
  bool _cashValidate = false;
  int ress;
  int cashsid;
  int cx;

  bool isLoading = false;

  double valor_total = 0.0;


  bool ok = true;
  AgreementsDao _daoAgre = AgreementsDao();
  PaymentMethodParkDao _daoPay = PaymentMethodParkDao();

  AgreementsOff _selectedItem;
  List<DropdownMenuItem<AgreementsOff>> _dropdownMenuItems;
  List<AgreementsOff> _dropdownItems = [
  ];

  PaymentMethodParkInner _selectedItemPrice;
  List<DropdownMenuItem<PaymentMethodParkInner>> _dropdownMenuItemsPrice;
  List<PaymentMethodParkInner> _dropdownItemsPrice = [
  ];

  List<DropdownMenuItem<AgreementsOff>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<AgreementsOff>> items = List();
    for (AgreementsOff listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text('${listItem.accountable_name}  (${listItem.company_name})'),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<PaymentMethodParkInner>> buildDropDownMenuItemsPrice(List listItems) {
    List<DropdownMenuItem<PaymentMethodParkInner>> items = List();
    for (PaymentMethodParkInner listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text('${listItem.name}'),
          value: listItem,
        ),
      );
    }
    return items;
  }
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
      List<AgreementsOff> listAgree = await _daoAgre.getAgreementsCash(int.tryParse(park.id));
      for(int i = 0; i < listAgree.length; i++){
        AgreementsOff agreementsList = listAgree[i];
        _dropdownItems.add(agreementsList);
      }

      List<PaymentMethodParkInner> listPrayment = await _daoPay.getPaymentCash(int.tryParse(park.id));
      for(int i = 0; i < listPrayment.length; i++){
        PaymentMethodParkInner paymentList = listPrayment[i];
        _dropdownItemsPrice.add(paymentList);

      }
      List<CashMovementOff> cashMovementList = await cashMoventDao.getCashMovementByIdCash(res);
      CashMovementOff cashMove = cashMovementList.first;
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        ress = await cashMoventDao.getCashByUserON(res);
      }
      int cashs = res;
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        cashsid = ress;
      }
      res = await cashMoventDao.getCashByUser(int.tryParse(user.id), int.tryParse(park.id));
      cx = await cashMoventDao.getCashByPark(int.tryParse(park.id));

      setState(() {
        if(res == null){
          ok = true;
        }else{
          ok = false;
        }
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

        _dropdownMenuItemsPrice = buildDropDownMenuItemsPrice(_dropdownItemsPrice);
        _selectedItemPrice = _dropdownMenuItemsPrice[0].value;

        if(listAgree.length > 0){

          _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
          _selectedItem = _dropdownMenuItems[0].value;
        }else{
          alertModal(context, 'Atenção!!', 'Não existem contratos para esse estacionamento.');
        }

      });
    } catch (e) {}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento Mensalista'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: ok ? _aberto(context) : _body(context),
    );
  }

  _body(BuildContext context) {
    return isLoading ? isLoadingPage() : Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pagamento de mensalista',
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
                  Text('Fechamento : $fechamento'),
                ],
              ),
            ),
            Text('Escolha o Contrato : ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Row(
              children: <Widget>[
                SizedBox(
                  child: DropdownButton(
                      value: _selectedItem,
                      items: _dropdownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value;
                          _cash.updateValue(_selectedItem.price);
                          valor_total = ((_cash.numberValue * _selectedItemPrice.variable_rate) / 100) + _cash.numberValue;
                        });
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text('Forma de Pagamento : ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Row(
              children: <Widget>[
                SizedBox(
                  child: DropdownButton(
                      value: _selectedItemPrice,
                      items: _dropdownMenuItemsPrice,
                      onChanged: (value) {
                        setState(() {
                          _selectedItemPrice = value;
                          valor_total = ((_cash.numberValue * _selectedItemPrice.variable_rate) / 100) + _cash.numberValue;
                        });
                      }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Valor : ', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                Flexible(
                  child: Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value){
                          setState(() {
                            valor_total = ((_cash.numberValue * _selectedItemPrice.variable_rate) / 100) + _cash.numberValue;
                          });
                        },
                        controller: _cash,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          errorText: _cashValidate ? 'Valor precisa ser maior que 0' : null,
                          suffixIcon: Icon(Icons.attach_money),
                        ),
                      ),
                    ),
                  ),
                ),
              ],),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Text('Valor total : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text('${NumberFormat.currency(name: '').format(valor_total)}'),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 200,
              child: ButtonApp2Park(
                text: 'Confirmar',
                onPressed: ()async{
                  setState(() {
                    isLoading = true;
                  });

                  var connectivityResult =
                  await (Connectivity().checkConnectivity());

                    if(valor_total > 0.00){
                      setState(() {
                        _cashValidate = false;
                      });
                      sharedPref.remove('cashmove');
                      sharedPref.remove('cashs');
                      sharedPref.remove('cashid');
                      CashMovementOff cashMovementOff = CashMovementOff(
                          0,0,id_cash_app,0,0,_selectedItem.id,_selectedItem.id_agreement_app, data.toString(),2,_selectedItemPrice.id_payment_method,0,0,'0',valor_total.toString(),_value.text
                      );

                      int id_cashs_m = await cashMoventDao.saveCashMovement(cashMovementOff);
                      sharedPref.save("cashmove", cashMovementOff);

                      if (connectivityResult == ConnectivityResult.mobile ||
                          connectivityResult == ConnectivityResult.wifi) {

                        CashMovement cashMovement = CashMovement();
                        cashMovement.id_cash = id_cash.toString();
                        cashMovement.id_cash_movement_app = id_cashs_m.toString();
                        cashMovement.id_agreement = _selectedItem.id.toString();
                        cashMovement.id_agreement_app = _selectedItem.id_agreement_app.toString();
                        cashMovement.date_added = cupom_checkin_datetime;
                        cashMovement.id_cash_type_movement =  '2';
                        cashMovement.id_payment_method = _selectedItemPrice.id_payment_method.toString();
                        cashMovement.value = valor_total.toString();
                        cashMovement.comment = _value.text;

                        CashMovementResponse cashMovementResponse =  await CashTypeService.cashMovement(cashMovement);

                        CashMovement cashMovements = cashMovementResponse.data.first;

                        bool oks = await cashMoventDao.updateCashMovement(int.parse(cashMovements.id), id_cashs_m);

                      }

                      if (_selectedItem.agreement_type == 0){
                        print(_selectedItem.until_payment);
                        print(_selectedItem.until_payment);

                        DateTime up = DateFormat("yyyy-MM-dd").parse(_selectedItem.until_payment).add(Duration(days: 30));
                      print(up);
                      String dt = DateFormat("yyyy-MM-dd").format(up);

                      print(dt.toString());

                      _daoAgre.updateAgreementsUntilPayment(dt.toString(),_selectedItem.id_agreement_app);
                      if (connectivityResult == ConnectivityResult.mobile ||
                          connectivityResult == ConnectivityResult.wifi) {

                        Agreements agreement = Agreements();

                        agreement.id_agreement_app = _selectedItem.id_agreement_app.toString();
                        agreement.id = _selectedItem.id.toString();
                        agreement.until_payment = dt.toString();

                        AgreementResponse agreementRes =  await ParkService.updateAgreement(_selectedItem.id.toString(), agreement);

                        Agreements agreements = agreementRes.data;

                      }

                      }else {
                        _daoAgre.updateAgreementsCash(_selectedItem.id_agreement_app);
                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {

                          Agreements agreement = Agreements();

                          agreement.id_agreement_app = _selectedItem.id_agreement_app.toString();
                          agreement.id = _selectedItem.id.toString();
                          agreement.status_payment = '1';

                          AgreementResponse agreementRes =  await ParkService.updateAgreement(_selectedItem.id.toString(), agreement);

                          Agreements agreements = agreementRes.data;

                        }
                      }
                      setState(() {
                        isLoading = false;
                      });

                      Navigator.of(context).pushNamed(HomeParkViewRoute);

                      alertButtonClose(context, 'Sucesso', 'Pagamento salvo');

                    }else{
                      setState(() {
                        _cashValidate = true;
                        isLoading = false;
                      });
                    }

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  _aberto(BuildContext context){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Atenção!!!', style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text('Não existe um caixa aberto.', style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          ButtonApp2Park(
            text: 'Voltar',
            onPressed: (){
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

import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/payment_method_park_dao.dart';
import 'package:app2park/db/dao/status/status_dao.dart';
import 'package:app2park/module/config/payment_method_park_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/payments/payment_method_park_model.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_inner_join_payment_method_park_model.dart';
import 'package:app2park/moduleoff/status/status_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class TaxPaymentPage extends StatefulWidget {
  @override
  _TaxPaymentPageState createState() => _TaxPaymentPageState();
}

class _TaxPaymentPageState extends State<TaxPaymentPage> {
  var con = Icon(Icons.attach_money);
  final _flat_rate_controller = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',',precision: 5);
  final _variable_rate_controller = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',',precision: 5);
  final _min_value_controller = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',',precision: 2);
  final _sort_order_controller = new TextEditingController();
  StatusDao _daostatus = StatusDao();
  StatusOff _selectedStatus;
  List<DropdownMenuItem<StatusOff>> _dropdownMenuItemsStatus;
  List<StatusOff> _dropdownItemsStatus = [

  ];
  int id = 0;
  Park park = Park();
  SharedPref sharedPref = SharedPref();
  String nome = "";
  String titulo = " ";
  int id_status;
  PaymentMethodInnerJoinPaymentMethodPark paymentModel =
      PaymentMethodInnerJoinPaymentMethodPark();
  PaymentMethodParkDao dao = new PaymentMethodParkDao();
  bool buttonenable = true;
  bool flatenable = true;
  bool variablenable = true;
  bool minenable = true;
  bool sortenable = true;
  int s = 0;

  bool isLoading  = false;

  loadSharedPrefs() async {
    try {
      var connectivityResult =
      await (Connectivity().checkConnectivity());

      Park p = Park.fromJson(await sharedPref.read("park"));
      PaymentMethodInnerJoinPaymentMethodPark pm =
          PaymentMethodInnerJoinPaymentMethodPark.fromJson(
              await sharedPref.read("paymentedit"));
      List<StatusOff> listStatus = await _daostatus.findAllStatus();
      if(s < 2){
        for(int i = 0; i < listStatus.length; i++){
          StatusOff statusList = listStatus[i];
          _dropdownItemsStatus.add(statusList);
          s++;
        }
      }
      setState((){
        paymentModel = pm;
        id = int.parse(p.id);
        _flat_rate_controller.updateValue(pm.flat_rate);
        _variable_rate_controller.updateValue(pm.variable_rate);
        _min_value_controller.updateValue(pm.min_value);
        _sort_order_controller.text = pm.sort_order.toString();
        titulo = pm.name;
        id_status = pm.status;
        _dropdownMenuItemsStatus = buildDropDownMenuItemsStatus(_dropdownItemsStatus);
        _selectedStatus = _dropdownMenuItemsStatus[id_status].value;
      });

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        setState(() {
          flatenable = true;
          variablenable = true;
          minenable = true;
          sortenable = true;
          buttonenable = true;
        });

      }else{
        setState(() {
          flatenable = false;
          variablenable = false;
          minenable = false;
          sortenable = false;
          buttonenable = false;
        });
      }

    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO TAX PAYMENT PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  List<DropdownMenuItem<StatusOff>> buildDropDownMenuItemsStatus(List listItems) {
    List<DropdownMenuItem<StatusOff>> items = List();
    for (StatusOff listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.status,style: TextStyle(fontSize: 22),),
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
    _refreshLocalGallery();
  }
  Future<Null> _refreshLocalGallery() async {
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshLocalGallery,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Formas de Pagamento'),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
        ),
        body: isLoading ? isLoadingPage() : _dashboard(context),
      ),
    );
  }

  _dashboard(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Informe as taxas cobradas por esta Forma de Pagamento!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Forma de Pagamento'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  titulo,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Taxa Fixa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              textAlign: TextAlign.start,
              enabled: flatenable,
              controller: _flat_rate_controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(suffixIcon: Icon(Icons.trending_up)),
              onChanged: (value) {
                NumberFormat.currency(name: '').format(paymentModel.flat_rate = _flat_rate_controller.numberValue);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Taxa Variavel (%)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              textAlign: TextAlign.start,
              enabled: variablenable,
              controller: _variable_rate_controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(suffixIcon: Icon(Icons.shop)),
              onChanged: (value) {
                NumberFormat.currency(name: '').format(paymentModel.variable_rate = _variable_rate_controller.numberValue);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              r'Valor mínimo da compra (R$)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              textAlign: TextAlign.start,
              enabled: minenable,
              controller: _min_value_controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(suffixIcon: Icon(Icons.attach_money)),
              onChanged: (value) {
                NumberFormat.currency(name: '').format(paymentModel.min_value = _min_value_controller.numberValue);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Ordem',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              textAlign: TextAlign.start,
              enabled: sortenable,
              controller: _sort_order_controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(suffixIcon: Icon(Icons.list)),
              onChanged: (value) {
                paymentModel.sort_order = int.parse(value);
              },
            ),
            SizedBox(height: 15,),
            Text('Status : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Row(
              children: <Widget>[
                SizedBox(
                  child: DropdownButton(
                      value: _selectedStatus,
                      items: _dropdownMenuItemsStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  buttonenable == true ? ButtonApp2Park(
                    text: 'Salvar',
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      var connectivityResult =
                      await (Connectivity().checkConnectivity());

                      dao.updatePaymentMethodPark(
                          paymentModel.id,
                          paymentModel.flat_rate,
                          paymentModel.variable_rate,
                          paymentModel.min_value,
                          _selectedStatus.id,
                          paymentModel.sort_order);

                      if (connectivityResult == ConnectivityResult.mobile ||
                          connectivityResult == ConnectivityResult.wifi) {

                        PaymentMethodParkModel paymentMethod = PaymentMethodParkModel();
                        paymentMethod.id = paymentModel.id.toString();
                        paymentMethod.flat_rate = paymentModel.flat_rate.toString();
                        paymentMethod.variable_rate = paymentModel.variable_rate.toString();
                        paymentMethod.min_value = paymentModel.min_value.toString();
                        paymentMethod.status = _selectedStatus.id.toString();
                        paymentMethod.sort_order = paymentModel.sort_order.toString();

                        PaymentMethodParkResponse paymentres = await ParkService.updatePaymentsMethodPark(paymentModel.id.toString(), paymentMethod);

                      }

                      setState(() {
                        isLoading = false;
                      });

                      alertModals(
                          context, "Sucesso", "Adicionado com sucesso!");
                    },
                    color: Color.fromRGBO(41, 202, 168, 3),
                  ) : Container(child: Text('Você precisa estar conectado a internet para alterar!'),),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
                'Estas configurações são utilizadas para calcular o valor a ser pago pelo cliente, considerando as taxas cobradas em cada operadora.'),
            SizedBox(
              height: 15,
            ),
            Text(
              'Exemplo:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Um estacionamento que receba apenas em dinheiro e cartão de crédito.'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Taxas do Cartão de Crédito'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(r'Taxa Fixa = R$ 0,00'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Taxa Variável = 6,40%'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(r'Valor Mínimo = R$ 10,00'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      r'Para cobrar R$ 10,00 de um cliente, a tela de pagamento, ficará assim:'),
                ),
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('Dinheiro')]),
                      Column(children: [Text(r'R$ 10,00')]),
                    ]),
                    TableRow(children: [
                      Column(children: [Text('Cartão de Crédito')]),
                      Column(children: [Text(r'R$ 10,64')]),
                    ]),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Taxa Fixa ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(r'(em R$)')
                          ],
                        ),
                        Text('Cobrada por pagamento recebido.'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Taxa Variável ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('(em %)')
                          ],
                        ),
                        Text('Cobrada por pagamento recebido.'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Valor Mínimo ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text('Que é aceito por pagamento.'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Importante!!! ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                            'O estacionamento pode optar por não cobrar preços diferentes para cada meio de pagamento. Para isso, basta preencher os campos com zeros.'),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Ordem ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                            'Que estas formas de pagamento serão exibidas na tela de pagamento, para facilitar a escolha pelo operador do caixa.'),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}

alertModals(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(PaymentFormViewRoute, (route) => false);
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

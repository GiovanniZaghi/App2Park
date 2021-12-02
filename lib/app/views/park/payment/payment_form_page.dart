import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/payment_method_park_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_inner_join_payment_method_park_model.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_park_check_box.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dart_extensions/dart_extensions.dart';


class PaymentFormPage extends StatefulWidget {
  @override
  _PaymentFormPageState createState() => _PaymentFormPageState();
}

class _PaymentFormPageState extends State<PaymentFormPage> {
  var con = Icon(Icons.attach_money);
  int id = 0;
  Park park = Park();
  SharedPref sharedPref = SharedPref();
  String nome = "";
  List<PaymentMethodInnerJoinPaymentMethodPark>
      paymentMethodInnerJoinPaymentMethodParkList = new List<PaymentMethodInnerJoinPaymentMethodPark>();
  PaymentMethodParkDao dao = new PaymentMethodParkDao();

  bool datatable = false;

  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        id = int.parse(p.id);
      });
      paymentMethodInnerJoinPaymentMethodParkList =
          await dao.getMethodParkInnerJoin(id);
      paymentMethodInnerJoinPaymentMethodParkList = paymentMethodInnerJoinPaymentMethodParkList.distinctBy((selector) => selector.id);
      for (int i = 0;
          i < paymentMethodInnerJoinPaymentMethodParkList.length;
          i++) {
        PaymentMethodInnerJoinPaymentMethodPark
            paymentMethodInnerJoinPaymentMethodPark =
            paymentMethodInnerJoinPaymentMethodParkList[i];
      }
      setState(() {
        datatable = true;
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO PAYMENT FORM PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void initState() {
    _refreshLocalGallery();
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
  }

  Future<Null> _refreshLocalGallery() async {
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formas de Pagamento'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, HomeParkViewRoute, (route) => false);
          },),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshLocalGallery,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Text(
                'Quais formas de pagamento este estacionamento oferece aos seus clientes?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              datatable == true ? DataTable(
                
                showCheckboxColumn: true,
                columns: [

                  DataColumn(label: Text('Forma de Pagamento', style: TextStyle(),)),
                  DataColumn(label: Text('Status')),
                ],
                rows:
                    paymentMethodInnerJoinPaymentMethodParkList // Loops through dataColumnText, each iteration assigning the value to element
                        .map(
                          ((element) => DataRow(

                                cells: <DataCell>[
                                  DataCell(Text(element.name), onTap: () {
                                    sharedPref.remove("paymentedit");
                                    sharedPref.save("paymentedit", element);
                                    Navigator.of(context)
                                        .pushNamed(TaxPaymentPageViewRoute);
                                  }),
                                  //Extracting from Map element the value
                                  DataCell(Text(element.st), onTap: () {
                                    sharedPref.remove("paymentedit");
                                    sharedPref.save("paymentedit", element);
                                    Navigator.of(context)
                                        .pushNamed(TaxPaymentPageViewRoute);
                                  }),

                                ],
                              )),
                        )
                        .toList(),
              ) : Container(),

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
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

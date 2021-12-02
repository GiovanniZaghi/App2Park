import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/price/extrato.dart';
import 'package:app2park/app/helpers/price/price_helper_class.dart';
import 'package:app2park/app/views/park/exit/exit_payment_card_page.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/payment_method_park_dao.dart';
import 'package:app2park/db/dao/ticket_service_additional_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/moduleoff/exit_payment_method_park.dart';
import 'package:app2park/moduleoff/exit_service_additional_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExitService extends StatefulWidget {
  @override
  _ExitServiceState createState() => _ExitServiceState();
}

class _ExitServiceState extends State<ExitService> {
  var con = Icon(Icons.attach_money);
  int id = 0;
  int id_vehicle = 0;
  Park park = Park();
  SharedPref sharedPref = SharedPref();
  String nome = "";
  String plate = '';
  String modelo = '';
  String type = '';
  String entrada = '';
  String saida = '';
  String estacionamento = '';
  String nametable = '';
  String tempoPodeFicar = '';
  int id_ticket_app = 0;
  List<ExitServiceAdditionalModel> exitserviceAdittionalList =
      List<ExitServiceAdditionalModel>();
  TicketServiceAdditionalDao ticketServiceAdditionalDao =
      TicketServiceAdditionalDao();
  List<ExitPaymentMethodPark> exitpaymentMethodParkList =
      List<ExitPaymentMethodPark>();
  PaymentMethodParkDao paymentMethodParkDao = PaymentMethodParkDao();
  double total_adicional = 0;
  DateTime dataEntrada;
  double valor_total = 0.0;
  double valor_tabela = 0.0;
  double valor_total_extrato = 0.0;
  List<Extrato> eList = List<Extrato>();
  DateTime tolerancia;
  DateTime saidaEsta;

  bool datatable = false;
  DateTime todayDate;
  String inicioCob = '';
  bool isOK = false;


  @override
  void initState() {
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
  }

  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      int v = await sharedPref.read("id_vehicle");
      String ent = await sharedPref.read("entrada");
      String sai = await sharedPref.read('saida');
      String pla = await sharedPref.read("plate");
      String nam = await sharedPref.read("nametable");
      String daily = await sharedPref.read("diaria");
      int id_tick = await sharedPref.read("id_ticket_app");
      int id_price_detached_app =
          await sharedPref.read("id_price_detached_app");
      String mod = await sharedPref.read("model");
      String ty = await sharedPref.read("type");
      exitserviceAdittionalList = await ticketServiceAdditionalDao
          .getAllServicesAdditionalByIdTicketApp(id_tick);
      int id_cupom = int.parse(await sharedPref.read("exitcar"));
      var toleranciaSoma = DateTime.parse('2020-09-28 00:00:00');
      if (exitserviceAdittionalList.length < 1) {
        tolerancia = DateTime.parse('2020-09-28 00:00:00');
      }
      for (int i = 0; i < exitserviceAdittionalList.length; i++) {
        ExitServiceAdditionalModel e = exitserviceAdittionalList[i];
        total_adicional += e.price;

        var lck = e.lack.split(':');
        tolerancia = toleranciaSoma.add(Duration(
            hours: int.tryParse(lck[0]),
            minutes: int.tryParse(lck[1]),
            seconds: int.tryParse(lck[2])));
      }

      valor_total += total_adicional;
      int id_park = int.parse(p.id);
      exitpaymentMethodParkList =
          await paymentMethodParkDao.getPaymentsMethodFilter(id_park);
      for (int i = 0; i < exitpaymentMethodParkList.length; i++) {
        ExitPaymentMethodPark e = exitpaymentMethodParkList[i];
      }

      PriceHelperClass priceHelper = PriceHelperClass();
      var dai = daily.split(':');

      int hr = int.tryParse(dai[0]);
      int min = int.tryParse(dai[1]);
      int sec = int.tryParse(dai[2]);

      eList = await priceHelper.calcularPreco(ent, sai, id_price_detached_app,
          tolerancia.hour, tolerancia.minute, tolerancia.second, hr, min, sec);

      for (int i = 0; i < eList.length; i++) {
        Extrato extrato = eList[i];

        if (extrato.nome == "Total") {
          valor_total_extrato = extrato.preco;
        }
      }

      Extrato efinal = eList.last;
      tempoPodeFicar = efinal.nome;

      setState(() {
        id = int.parse(p.id);
        park = p;
        id_vehicle = v;
        entrada = ent;
        saida = sai;
        plate = pla;
        id_ticket_app = id_tick;
        modelo = mod;
        type = ty;
        nametable = nam;
        estacionamento = p.name_park;

        valor_tabela = valor_total_extrato;

        valor_total = total_adicional + valor_tabela;
        datatable = true;
        todayDate = DateTime.parse(entrada);
        todayDate.add(Duration(days:tolerancia.day,hours: tolerancia.hour,minutes: tolerancia.minute,seconds: tolerancia.second));
        inicioCob = DateFormat('yyyy-MM-dd HH:mm:ss').format(todayDate);
        saidaEsta = DateTime.parse(saida);
        String esta = DateFormat('yyyy-MM-dd HH:mm:ss').format(todayDate.add(Duration(hours: tolerancia.hour, minutes: tolerancia.minute, seconds: tolerancia.second)));
        DateTime esta2 = DateTime.parse(esta);
        isOK = esta2.isAfter(saidaEsta);



      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO EXIT SERVICES PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Formas de Pagamento'),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Pagamento",
                icon: Icon(
                  Icons.payment,
                ),
              ),
              Tab(
                text: "Extrato",
                icon: Icon(
                  Icons.receipt,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _body(context),
            _extrato(context),
          ],
        ),
      ),
    );
  }

  _body(BuildContext context) {
    return new Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Placa : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    plate,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 05,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Modelo : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$modelo',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Tipo : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$type',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Entrada : ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(entrada))}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Saida : ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(saida))}',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Selecione a forma  de pagamento ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              datatable == true
                  ? DataTable(
                      showCheckboxColumn: false,
                      columns: [
                        DataColumn(
                            label: Text(
                          'Tipo: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                        DataColumn(
                            label: Text(
                          'Preço: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                      ],
                      rows:
                          exitpaymentMethodParkList // Loops through dataColumnText, each iteration assigning the value to element
                              .map(
                                ((element) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('${element.name} :'),
                                            onTap: () {
                                          double valor_juros = (((valor_total *
                                                      element.variable_rate) /
                                                  100) +
                                              valor_total);
                                          sharedPref.remove("valortotal");
                                          sharedPref.save(
                                              "valortotal", valor_juros);
                                          double tax = element.variable_rate;
                                          sharedPref.save(
                                              "taxa", tax);

                                          if (element.id_payment_method == 1) {
                                            sharedPref.remove("paymentmethods");
                                            sharedPref.save(
                                                "paymentmethods", 1);
                                            double tax = element.variable_rate;
                                            sharedPref.save(
                                                "taxa", tax);

                                            Navigator.of(context).pushNamed(
                                                ExitPaymentMoneyViewRoute);
                                          } else if (element
                                                  .id_payment_method ==
                                              2) {
                                            sharedPref.remove("paymentmethods");
                                            sharedPref.save(
                                                "paymentmethods", 2);
                                            double tax = element.variable_rate;
                                            sharedPref.save(
                                                "taxa", tax);
                                            Navigator.of(context).pushNamed(
                                                ExitPaymentCardViewRoute);
                                          } else {
                                            sharedPref.remove("paymentmethods");
                                            sharedPref.save(
                                                "paymentmethods", 3);
                                            double tax = element.variable_rate;

                                            sharedPref.save(
                                                "taxa", tax);
                                            Navigator.of(context).pushNamed(
                                                ExitPaymentCardViewRoute);
                                          }
                                        }),
                                        //Extracting from Map element the value
                                        DataCell(
                                            Text('' +
                                                NumberFormat.currency(name: '')
                                                    .format(((valor_total *
                                                                element
                                                                    .variable_rate) /
                                                            100) +
                                                        valor_total)
                                                    .toString()), onTap: () {
                                          double valor_juros = (((valor_total *
                                                      element.variable_rate) /
                                                  100) +
                                              valor_total);
                                          sharedPref.remove("valortotal");
                                          sharedPref.save(
                                              "valortotal", valor_juros);
                                          double tax = element.variable_rate;
                                          sharedPref.save(
                                              "taxa", tax);
                                          if (element.id_payment_method == 1) {
                                            sharedPref.remove("paymentmethods");
                                            sharedPref.save(
                                                "paymentmethods", 1);
                                            double tax = element.variable_rate;
                                            sharedPref.save(
                                                "taxa", tax);
                                            Navigator.of(context).pushNamed(
                                                ExitPaymentMoneyViewRoute);
                                          } else if (element
                                                  .id_payment_method ==
                                              2) {
                                            sharedPref.remove("paymentmethods");
                                            sharedPref.save(
                                                "paymentmethods", 2);
                                            double tax = element.variable_rate;
                                            sharedPref.save(
                                                "taxa", tax);
                                            Navigator.of(context).pushNamed(
                                                ExitPaymentCardViewRoute);
                                          } else {
                                            sharedPref.remove("paymentmethods");
                                            sharedPref.save(
                                                "paymentmethods", 3);
                                            double tax = element.variable_rate;
                                            sharedPref.save(
                                                "taxa", tax);
                                            Navigator.of(context).pushNamed(
                                                ExitPaymentCardViewRoute);
                                          }
                                        }),
                                      ],
                                    )),
                              )
                              .toList(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _extrato(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$estacionamento',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${park.business_name}',
                          style: TextStyle(
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${park.street}, ${park.number} - ${park.complement} - ${park.city} - ${park.state}',
                          style: TextStyle(
                              fontSize: 16),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: <Widget>[
                        park.type == '1' ? Text(
                          'CPF : ${park.doc}',
                          style: TextStyle(
                              fontSize: 16,),
                        ) : Text('CNPJ : ${park.doc}',
                          style: TextStyle(
                            fontSize: 16,),),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        plate,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(' - '),
                      Text(
                        '$modelo',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Tipo : ",
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        Text(
                          '$type',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  tolerancia.toString() != '00:00:00' ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Entrada : ',
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        Text(
                          '${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(entrada))}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ) : Text(''),
                  tolerancia.toString() != '00:00:00' ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Saida : ',
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        Text(
                          '${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(saida))}',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ) : Text(''),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            exitserviceAdittionalList.length > 0 ?  Text(
              'Serviços Adicionais',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ) : Container(),
            exitserviceAdittionalList.length > 0 ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: datatable == true
                  ? DataTable(
                      showCheckboxColumn: false,
                      columns: [
                        DataColumn(
                            label: Text(
                          'Nome',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                        DataColumn(
                            label: Text(
                          'Preço',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                      ],
                      rows:
                          exitserviceAdittionalList // Loops through dataColumnText, each iteration assigning the value to element
                              .map(
                                ((element) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('${element.name}',style: TextStyle(fontSize: 16),)),
                                        //Extracting from Map element the value
                                        DataCell(Text(
                                            '${NumberFormat.currency(name: '').format(element.price)}',style: TextStyle(fontSize: 16),)),
                                      ],
                                    )),
                              )
                              .toList(),
                    )
                  : Container(),
            ) : Container(),
            exitserviceAdittionalList.length > 0 ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Total Serviços Adicionais: ${NumberFormat.currency(name: '').format(total_adicional)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ) : Container(),
            SizedBox(
              height: 05,
            ),
            exitserviceAdittionalList.length > 0 ? Row(
              children: <Widget>[
                tolerancia.toString().substring(11,19) != '00:00:00' ? Text(
                  'Tempo de Estacionamento\n Grátis :  ${tolerancia.toString().substring(11,19)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ) : Text(''),
              ],
            ) : Container(),
            SizedBox(
              height: 5,
            ),
            !isOK ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Estacionamento ',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        tolerancia.toString() == '00:00:00' ? Text(
                          'Entrada',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ) : Text(
                          'Inicio da cobrança : ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        tolerancia.toString().substring(11,19) == '00:00:00' ? Text(
                          '${DateFormat("dd/MM/yyyy hh:mm:ss").format(todayDate)}',
                          style: TextStyle(fontSize: 18),
                        ) : Text(
                          '${DateFormat('yyyy-MM-dd HH:mm:ss').format(todayDate.add(Duration(hours: tolerancia.hour, minutes: tolerancia.minute, seconds: tolerancia.second)))}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        tolerancia.toString().substring(11,19) == '00:00:00' ? Text(
                          'Saída : ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ) : Text('Término : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Text(
                          "${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(saida))}",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Tabela de preço : ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${nametable}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: datatable == true
                          ? DataTable(
                        horizontalMargin: 1,
                        showCheckboxColumn: false,
                        columns: [
                          DataColumn(
                              label: Text(
                                'Tipo: ',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                          DataColumn(
                              label: Text(
                                'Qtde',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                          DataColumn(
                              label: Text(
                                'Preço: ',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                        ],
                        rows:
                        // Loops through dataColumnText, each iteration assigning the value to element
                        eList
                            .map(
                          ((element) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                 element.preco >= 0.00 ? Text('${element.nome} ') : Text('${element.nome} ${element.tempo.toString().substring(0,19)}'),
                              ),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    element.quantidade > 0 ? Text('${element.quantidade}x\n${NumberFormat.currency(name: '').format(element.preco)}') : Text(''),
                                  ],
                                ),
                              ),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                   element.preco > 0.00 ? element.quantidade > 1 ? Text(
                                       '${NumberFormat.currency(name: '').format(element.preco * element.quantidade)}') : Text('${NumberFormat.currency(name: '').format(element.preco)}') : Text(''),
                                  ],
                                ),
                              ),
                              //Extracting from Map element the value
                            ],
                          )),
                        )
                            .toList(),
                      )
                          : Container()),
                ],
              ),
            ) : Text(''),
            SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Total = ${NumberFormat.currency(name: '').format(valor_total)}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

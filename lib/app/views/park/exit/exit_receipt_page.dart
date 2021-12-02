import 'dart:convert';

import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/price/extrato.dart';
import 'package:app2park/app/helpers/price/price_helper_class.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/receipt/receipt_dao.dart';
import 'package:app2park/db/dao/ticket_service_additional_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/module/config/receipt_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/receipt/receipt.dart';
import 'package:app2park/module/receipt/receipt_send.dart';
import 'package:app2park/module/receipt/service/receipt_service.dart';
import 'package:app2park/moduleoff/exit_service_additional_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/receipt/receipt_off.dart';
import 'package:app2park/moduleoff/ticket/tickets_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ReceiptPage extends StatefulWidget {
  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}


class _ReceiptPageState extends State<ReceiptPage> {
  Park park = Park();
  SharedPref sharedPref = SharedPref();
  String nomePark;
  String CNPJ;
  String endereco;
  String entrada = '';
  String saida = '';
  String plate = '';
  String modelo = '';
  String type = '';
  int id_ticket_app = 0;
  double variable_rate;
  TicketServiceAdditionalDao ticketServiceAdditionalDao =
  TicketServiceAdditionalDao();
  List<ExitServiceAdditionalModel> exitserviceAdittionalList = List<ExitServiceAdditionalModel>();
  List<Extrato> eList = List<Extrato>();

  double total_adicional = 0;
  DateTime dataEntrada;
  double valor_total = 0.0;
  double valor_tabela = 0.0;
  double valor_total_extrato = 0.0;
  double valor_total_old = 0.0;
  String tempoPodeFicar = '';
  double valor_juros;
  var desconto;
  DateTime tolerancia;
  DateTime saidaEsta;

  bool datatable = false;
  DateTime todayDate;
  String inicioCob = '';
  bool isOK = false;
  TicketsDao ticketsDao = TicketsDao();
  String link = "";
  String ticket = "";


  loadSharedPrefs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      Park ps = Park.fromJson(await sharedPref.read("park"));
      int id_tick = await sharedPref.read("id_ticket_app");
      String pla = await sharedPref.read("plate");
      String mod = await sharedPref.read("model");
      String ty = await sharedPref.read("type");
      String ent = await sharedPref.read("entrada");
      String sai = await sharedPref.read('saida');
      exitserviceAdittionalList = await ticketServiceAdditionalDao
          .getAllServicesAdditionalByIdTicketApp(id_tick);
      List<TicketsOffModel> ticketOffList = await ticketsDao.getTicketInfo(id_tick, int.parse(ps.id));

      TicketsOffModel ticketOff = ticketOffList.first;



      int id_tic = ticketOff.id;

      String nam = await sharedPref.read("nametable");
      String daily = await sharedPref.read("diaria");
      double tax = await sharedPref.read("taxa");
      double desct = await sharedPref.read("desconto");
      int id_price_detached_app =
      await sharedPref.read("id_price_detached_app");
      var toleranciaSoma = DateTime.parse('2020-09-28 00:00:00');
      DateTime tolerancia;
      if(exitserviceAdittionalList.length < 1){
        tolerancia = DateTime.parse('2020-09-28 00:00:00');
      }
      for (int i = 0; i < exitserviceAdittionalList.length; i++) {
        ExitServiceAdditionalModel e = exitserviceAdittionalList[i];
        total_adicional += e.price;

        var lck = e.lack.split(':');
        tolerancia = toleranciaSoma.add(Duration(hours: int.tryParse(lck[0]), minutes: int.tryParse(lck[1]), seconds: int.tryParse(lck[2])));

      }
      valor_total += total_adicional;


      PriceHelperClass priceHelper = PriceHelperClass();
      var dai = daily.split(':');

      int hr = int.tryParse(dai[0]);
      int min = int.tryParse(dai[1]);
      int sec = int.tryParse(dai[2]);

      eList = await priceHelper.calcularPreco(ent, sai, id_price_detached_app, tolerancia.hour, tolerancia.minute, tolerancia.second, hr, min, sec);

      for (int i = 0; i < eList.length; i++) {
        Extrato extrato = eList[i];

        if (extrato.nome == "Total") {
          valor_total_extrato = extrato.preco;
        }
      }
      Extrato efinal = eList.last;
      tempoPodeFicar = efinal.nome;
      setState(() {
        park = ps;
        plate = pla;
        modelo = mod;
        type = ty;
        CNPJ = park.doc;
        entrada = ent;
        saida = sai;
        id_ticket_app = id_tick;
        valor_tabela = valor_total_extrato;
        valor_total = total_adicional + valor_tabela;
        valor_total_old = valor_total;
        variable_rate = tax;
        desconto = desct;
        valor_total = (((valor_total *
            variable_rate) /
            100) + valor_total);
         valor_juros = (valor_total - desconto);
        variable_rate = (valor_total_old * variable_rate) / 100;

        todayDate = DateTime.parse(entrada);
        todayDate.add(Duration(days:tolerancia.day,hours: tolerancia.hour,minutes: tolerancia.minute,seconds: tolerancia.second));
        inicioCob = DateFormat('yyyy-MM-dd HH:mm:ss').format(todayDate);
        saidaEsta = DateTime.parse(saida);
        String esta = DateFormat('yyyy-MM-dd HH:mm:ss').format(todayDate.add(Duration(hours: tolerancia.hour, minutes: tolerancia.minute, seconds: tolerancia.second)));
        DateTime esta2 = DateTime.parse(esta);
        isOK = esta2.isAfter(saidaEsta);


        ReceiptSend receiptSend = ReceiptSend();
        receiptSend.name_park = ps.name_park;
        receiptSend.doc = ps.doc;
        receiptSend.street = ps.street;
        receiptSend.number = ps.number;
        receiptSend.city = ps.city;
        receiptSend.state = ps.state;
        receiptSend.plate = pla;
        receiptSend.model = mod;
        receiptSend.data_ent = ent;
        receiptSend.data_sai = sai;
        receiptSend.total = valor_total_old.toString();
        receiptSend.taxa = variable_rate.toString();
        receiptSend.desconto = desconto.toString();
        receiptSend.total_pago = valor_juros.toString();


        List<String> exitserviceList = List<String>();
        exitserviceAdittionalList.forEach((element) {
          exitserviceList.add('${element.name} - ${NumberFormat.currency(name: '').format(element.price)}');
        });
        List<String> extratoList = List<String>();
        eList.forEach((element) {

          if(element.nome == 'Total'){
            extratoList.add('${element.nome} - ${NumberFormat.currency(name: '').format(element.preco)}');
          } else if (element.nome == 'Mesmo preço até: '){
            extratoList.add('${element.nome}  ${DateFormat("dd/MM/yyyy HH:mm:ss").format(element.tempo)}');
          }else{
            extratoList.add('${element.nome} - ${element.quantidade} - ${NumberFormat.currency(name: '').format(element.preco)}');
          }
        });
        if(extratoList.length >= 0){
          receiptSend.eList = extratoList.toString();
        }else{

        }

        if(exitserviceList.length >= 0){
          receiptSend.exitserviceAdittionalList = exitserviceList.toString();
        }else{

        }


        Receipt receipt = Receipt();
        receipt.res = receiptSend.toString();
        receipt.id_ticket = ticketOff.id.toString();
        receipt.id_cupom = ticketOff.id_cupom.toString();
        link = "https://www.app2park.com.br/recibo.php?id=${ticketOff.id}&cupom=${ticketOff.id_cupom}";
        ticket = ticketOff.id.toString();

        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          ReceiptService.CriarRecibo(receipt);
        }else{
          ReceiptOff receipts = ReceiptOff('0', id_ticket_app ,ticketOff.id.toString(), ticketOff.id_cupom.toString(), receiptSend.toJson().toString());
          ReceiptDao receiptDao = ReceiptDao();
          receiptDao.saveReceipt(receipts);
        }
      });

    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO EXIT RECEIPT PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  abrirUrlRecibo() async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  void initState() {
    loadSharedPrefs();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recibo'),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomeParkViewRoute, (Route<dynamic> route) => false);
        }),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }


  _body(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset(
                    "assets/img/logo-app2park.png",
                    width: 150,
                    height: 50,
                  ),

                ],
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('App2Park.com.br',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Recibo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                ],
              ),
            ),

            Row(
              children: [
                Text("Ticket : ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text("${ticket}",style: TextStyle(fontSize: 20),),
              ],
            ),

            SizedBox(height: 15,),
            Text('${park.name_park}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text('${park.street}, ${park.number} - ${park.complement} - ${park.city} - ${park.state}',style: TextStyle(fontSize: 18),),
            Text('DOC : ${CNPJ}',style: TextStyle(fontSize: 18),),
            Row(
              children: [
                Text('Telefone para contato :',style: TextStyle(fontSize: 20),),
                Text("${park.cell}",style: TextStyle(fontSize: 18),),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              children: <Widget>[
                Text('$plate',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text(' - '),
                Text('$modelo',style: TextStyle(fontSize: 18),)
              ],
            ),
            exitserviceAdittionalList.length > 0 ? SizedBox(height: 50,) : Container(),
            exitserviceAdittionalList.length > 0 ? Text('Serviços Adicionais', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),) : Container(),
            exitserviceAdittionalList.length > 0 ? Text('${exitserviceAdittionalList.toList().asMap().values.map((e) => e.name)} : ${exitserviceAdittionalList.toList().asMap().values.map((e) => e.price)}') : Container(),
            SizedBox(height: 35,),

            !isOK ? Column(
              children: <Widget>[
                Text('Estacionamento', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Entrada : ', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('${DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.parse(entrada))}',style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Saída : ', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                      Text('${DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.parse(saida))}',style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
                SizedBox(height: 35,),
                Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: DataTable(
                      horizontalMargin: 1,
                      showCheckboxColumn: false,
                      columns: [
                        DataColumn(
                            label: Text(
                              'Tipo:',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                        DataColumn(
                            label: Text(
                              'Qtde',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                        DataColumn(
                            label: Text(
                              'Preço:',
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
                              element.preco > 0.00 ? Text('${element.nome} ') : Text('${element.nome} ${element.tempo.toString()}'),
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
                    )),
              ],
            ) : Container(),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  Text(
                    'Total = ${NumberFormat.currency(name: '').format(valor_total_old)}',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                variable_rate == 0.0 || variable_rate == null || variable_rate < 0 ? Container() : Text('Taxa do cartão : ' + NumberFormat.currency(name: '').format(variable_rate),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                 desconto == 0.0 || variable_rate == null || variable_rate < 0 ? Container() : Text("Desconto : ${NumberFormat.currency(name: '').format(desconto)}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                 valor_juros == null || valor_juros < 0 ? Container() : Text('Total Pago : ${NumberFormat.currency(name: '').format(valor_juros)}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                ],
              ),
            ), SizedBox(height: 30,),
            Text("Link do recibo online",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            InkWell(
              child: Text('${link}',style: TextStyle(fontSize: 20,color: Colors.lightBlueAccent),),
              onTap: (){
                abrirUrlRecibo();

              },
            ),
            SizedBox(
              height: 20,
            ),
            ButtonApp2Park(
              text: 'Imprimir Cupom',
              onPressed: (){
                Navigator.of(context).pushNamed(CupomExitPrintPageViewRoute);
              },
            ),
            SizedBox(height: 30,),
            ButtonApp2Park(
              text: 'Voltar',
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeParkViewRoute, (Route<dynamic> route) => false);
              },
            ),

          ],
        ),
      ),
    );
  }
}

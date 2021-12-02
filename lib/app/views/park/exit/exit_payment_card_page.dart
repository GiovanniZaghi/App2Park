import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/cashier/cashs_dao.dart';
import 'package:app2park/db/dao/cashier/movement/cash_movement_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/module/cashier/movement/cash_movement_model.dart';
import 'package:app2park/module/cashier/service/cash_service.dart';
import 'package:app2park/module/config/cash_movement_response.dart';
import 'package:app2park/module/config/ticket_historic_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/cashier/cashs_off_model.dart';
import 'package:app2park/moduleoff/cashier/movement/cash_movement_off_model.dart';
import 'package:app2park/moduleoff/exit_join_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_inner_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_off_model.dart';
import 'package:app2park/moduleoff/ticket/tickets_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class ExitPaymentCard extends StatefulWidget {
  @override
  _ExitPaymentCardState createState() => _ExitPaymentCardState();
}

class _ExitPaymentCardState extends State<ExitPaymentCard> {
  var con = Icon(Icons.attach_money);
  int id = 0;
  int id_vehicle = 0;
  Park park = Park();
  SharedPref sharedPref = SharedPref();
  String cupom_checkin_datetime =
  DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();
  String nome = "";
  List<PriceDetachedInnerJoinOff>
  priceDetachedInnerJoinOffList =
  new List<PriceDetachedInnerJoinOff>();
  List<ExitJoinModel> exitJoinList;
  TicketsDao ticketsDao = TicketsDao();
  CashsDao cashsDao = CashsDao();
  CashMovementDao cashMovementDao = CashMovementDao();
  PriceDetachedDao dao = new PriceDetachedDao();
  TicketHistoricDao ticketHistoricDao = TicketHistoricDao();
  String plate = '';
  String modelo = '';
  String type = '';
  bool visi = false;
  String saida = '';
  String entrada = '';
  double valortotal = 0.0;
  final _pay = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',',precision: 2);
  final _total = new TextEditingController();
  final _observation = new TextEditingController();
  int id_user;
  int id_park;
  int id_ticket_app;
  int id_ticket = 0;
  int id_cash = 0;
  int id_cash_app =0;
  int meioPagamento = 0;
  double variable_rate;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int id_price_detached = 0;
  int id_price_detached_app = 0;

  loadSharedPrefs() async {
    try {
      Park p = Park.fromJson(await sharedPref.read("park"));
      int v = await sharedPref.read("id_vehicle");
      String ent = await sharedPref.read("entrada");
      String sai = await sharedPref.read('saida');
      String mod = await sharedPref.read("model");
      String ty = await sharedPref.read("type");
      double vt = await sharedPref.read("valortotal");
      int id_tick = await sharedPref.read("id_ticket_app");
      User user = User.fromJson(await sharedPref.read("user"));
      int payme = await sharedPref.read("paymentmethods");
      int id_price = await sharedPref.read("id_price_detached");
      int id_price_app = await sharedPref.read("id_price_detached_app");

      List<TicketsOffModel> ticketOffList = await ticketsDao.getTicketInfo(id_tick, int.parse(p.id));

      TicketsOffModel ticketOff = ticketOffList.first;

      int id_tic = ticketOff.id;

      List<CashsOff> cashList = await cashsDao.getCashInfo(int.parse(p.id), int.parse(user.id));

      CashsOff cashOff = cashList.first;

      int id_c = cashOff.id;

      int id_c_app = cashOff.id_cash_app;

      setState(() {
        id = int.parse(p.id);
        id_vehicle = v;
        entrada = ent;
        saida = sai;
        modelo = mod;
        type = ty;
        valortotal = vt;
        _pay.updateValue(vt);
        id_park = int.parse(p.id);
        id_ticket_app = id_tick;
        id_user = int.parse(user.id);
        id_ticket = id_tic;
        id_cash = id_c;
        id_cash_app = id_c_app;
        meioPagamento = payme;
        id_price_detached = id_price;
        id_price_detached_app = id_price_app;

      });
      int id_cupom = int.parse(await sharedPref.read("exitcar"));
      exitJoinList = await ticketsDao.getExitInformation(id_cupom);
      for (int i = 0; i < exitJoinList.length; i++) {
        ExitJoinModel exitJoinModel = exitJoinList[i];
        if (exitJoinModel.id_ticket_historic_status == 11) {
          setState(() {
            plate = exitJoinModel.plate;
            modelo = exitJoinModel.model;
          });
        } else {
          setState(() {
            plate = exitJoinModel.plate;
            modelo = exitJoinModel.model;
          });
        }
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO EXIT PAYMENT CARD PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
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
        title: Text('Pagamento'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return isLoading ? isLoadingPage() : Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Pagamento Cartão', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),),
                  Text('Apenas continue depois que o pagamento for finalizado com o pagamento aceito pela operadora de cartões!!!', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  ),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Placa : $plate"),
              Text("Modelo : $modelo"),
              Text("Tipo : $type"),
              SizedBox(height: 10,),
              Text('Entrada : ${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(entrada))}'),
              Text('Saida : ${DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(saida))}'),
              SizedBox(
                height: 20,
              ),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(2.0),
                  1: FlexColumnWidth(1.0),
                  2: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [
                        Text(
                          'Total Calculado :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [
                        Text(
                          '${NumberFormat.currency(name: '').format(valortotal)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ]),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [Text('Total Cobrado :')]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _pay,
                              keyboardType: TextInputType.number,
                              onChanged: (value){
                                if(_pay.numberValue < valortotal){
                                  setState(() {
                                    visi = true;
                                  });
                                }else{
                                  setState(() {
                                    visi = false;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      )]),
                    ),

                  ]),
                ],
              ),
              Form(
                key: _formKey,
                child: Visibility(
                  visible: visi,
                  child: TextFormField(
                    controller: _observation,
                    decoration: InputDecoration(
                        hintText: 'Motivo por cobrar a menos:'
                    ),
                    validator: (value){
                      if(visi == true){
                        if(value.length < 5){
                          return "Esse campo é Obrigatório";
                        }
                        return null;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ButtonApp2Park(
                onPressed: (){
                  if (_formKey.currentState.validate()) {
                    alertModals(context, 'Atenção',
                        'Apenas continue depois que o pagamento for finalizado com o pagamento aceito pela operadora de cartões!!!');
                  }
                },
                text: 'Continuar',
              ),
              SizedBox(
                height: 15,
              ),
              ButtonApp2Park(
                onPressed: (){
                  alertVolta(context, 'Atenção! ', ''
                      'Pagamento não foi realizado!!');
                },
                text: 'Voltar',
              ),
            ],
          ),
        )
    );
  }
  alertModals(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text('Pagamento Realizado'),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          setState(() {
            isLoading = true;
          });
          double dinheiro = _pay.numberValue;
          double desconto = valortotal - dinheiro;
          sharedPref.save("desconto", desconto);

          var connectivityResult = await (Connectivity().checkConnectivity());

          TicketHistoricOffModel ticketHistoricOffModel = TicketHistoricOffModel(0, 0, id_ticket_app, 11, id_user, 0, 0,saida);

          int id_ticket_historic = await ticketHistoricDao.saveTicketHistoric(ticketHistoricOffModel);

          CashMovementOff cashMovementOff = CashMovementOff(0, id_cash, id_cash_app, id_ticket, id_ticket_app, 0, 0, cupom_checkin_datetime, 2, meioPagamento,id_price_detached,id_price_detached_app, dinheiro.toString(),desconto.toString(), _observation.text);

          int id_cash_movement = await cashMovementDao.saveCashMovement(cashMovementOff);


          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {

            TicketHistoricModel ticketHistoric = TicketHistoricModel();
            ticketHistoric.id_ticket_historic_status = '11';
            ticketHistoric.id_ticket_historic_app = id_ticket_historic.toString();
            ticketHistoric.id_ticket = id_ticket.toString();
            ticketHistoric.id_ticket_app = id_ticket_app.toString();
            ticketHistoric.id_user = id_user.toString();
            ticketHistoric.date_time = cupom_checkin_datetime;

            TicketHistoricResponse ticketHRes = await TicketService.createTicketHistoric(ticketHistoric);

            if(ticketHRes.status == 'COMPLETED'){

              TicketHistoricModel ticketHis = ticketHRes.data;

              bool ok = await ticketHistoricDao.updateTicketHistoricIdOn(int.parse(ticketHis.id), id_ticket, id_ticket_historic);

            }

            CashMovement cashMovement = CashMovement();
            cashMovement.id_cash = id_cash.toString();
            cashMovement.id_ticket = id_ticket.toString();
            cashMovement.id_cash_movement_app = id_cash_movement.toString();
            cashMovement.id_ticket_app = id_ticket_app.toString();
            cashMovement.date_added = cupom_checkin_datetime;
            cashMovement.id_cash_type_movement =  '2';
            cashMovement.id_payment_method = meioPagamento.toString();
            cashMovement.id_price_detached = id_price_detached.toString();
            cashMovement.id_price_detached_app = id_price_detached_app.toString();
            cashMovement.value = dinheiro.toString();
            cashMovement.comment = _observation.text;


            CashMovementResponse cashMovementResponse =  await CashTypeService.cashMovement(cashMovement);

            CashMovement cashMovements = cashMovementResponse.data.first;

            bool ok = await cashMovementDao.updateCashMovement(int.parse(cashMovements.id), id_cash_movement);


          }

          Navigator.of(context).pushNamed(ReceiptPageViewRoute);
        }else{
          Navigator.of(context).pop();
          setState(() {
            isLoading = false;
          });

        }
      },
    );
    Widget backButton = FlatButton(
      child: Text('Voltar'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alerta = AlertDialog(
      title: Text(textTitle),
      content: Text(textCenter),
      actions: [
        okButton,
        backButton,
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
  alertVolta(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text('Tentar novamente'),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          isLoading = false;
        });


      },
    );
    Widget exitButton = FlatButton(
      child: Text('Saída do Veículo'),
      onPressed: () async{
        if (_formKey.currentState.validate()) {
          setState(() {
            isLoading = true;
          });
          double dinheiro = _pay.numberValue;
          double desconto = valortotal - dinheiro;
          var connectivityResult = await (Connectivity().checkConnectivity());

          TicketHistoricOffModel ticketHistoricOffModel = TicketHistoricOffModel(0, 0, id_ticket_app, 11, id_user, 0, 0,saida);

          int id_ticket_historic = await ticketHistoricDao.saveTicketHistoric(ticketHistoricOffModel);

          CashMovementOff cashMovementOff = CashMovementOff(0, id_cash, id_cash_app, id_ticket, id_ticket_app, 0, 0, cupom_checkin_datetime, 2, meioPagamento,id_price_detached,id_price_detached_app, dinheiro.toString(),desconto.toString(),_observation.text);

          int id_cash_movement = await cashMovementDao.saveCashMovement(cashMovementOff);


          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {

            TicketHistoricModel ticketHistoric = TicketHistoricModel();
            ticketHistoric.id_ticket_historic_status = '11';
            ticketHistoric.id_ticket_historic_app = id_ticket_historic.toString();
            ticketHistoric.id_ticket = id_ticket.toString();
            ticketHistoric.id_ticket_app = id_ticket_app.toString();
            ticketHistoric.id_user = id_user.toString();
            ticketHistoric.date_time = cupom_checkin_datetime;

            TicketHistoricResponse ticketHRes = await TicketService.createTicketHistoric(ticketHistoric);

            if(ticketHRes.status == 'COMPLETED'){

              TicketHistoricModel ticketHis = ticketHRes.data;

              bool ok = await ticketHistoricDao.updateTicketHistoricIdOn(int.parse(ticketHis.id), id_ticket, id_ticket_historic);

            }

            CashMovement cashMovement = CashMovement();
            cashMovement.id_cash = id_cash.toString();
            cashMovement.id_ticket = id_ticket.toString();
            cashMovement.id_cash_movement_app = id_cash_movement.toString();
            cashMovement.id_ticket_app = id_ticket_app.toString();
            cashMovement.date_added = cupom_checkin_datetime;
            cashMovement.id_cash_type_movement =  '2';
            cashMovement.id_payment_method = meioPagamento.toString();
            cashMovement.id_price_detached = id_price_detached.toString();
            cashMovement.id_price_detached_app = id_price_detached_app.toString();
            cashMovement.value = dinheiro.toString();
            cashMovement.comment = _observation.text;
            double desconto = valortotal - dinheiro;
            sharedPref.save("desconto", desconto);


            CashMovementResponse cashMovementResponse =  await CashTypeService.cashMovement(cashMovement);

            CashMovement cashMovements = cashMovementResponse.data.first;

            bool ok = await cashMovementDao.updateCashMovement(int.parse(cashMovements.id), id_cash_movement);

          }

          Navigator.of(context).pushNamed(ReceiptPageViewRoute);
        }else{
          Navigator.of(context).pop();
          setState(() {
            isLoading = false;
          });
        }
      },
    );

    AlertDialog alerta = AlertDialog(
      title: Text(textTitle),
      content: Text(textCenter),
      actions: [
        okButton,
        exitButton,
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
}

import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/price/price_helper_class.dart';
import 'package:app2park/db/dao/agreement/agreement_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/module/config/ticket_historic_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/agreements/agreements_off_model.dart';
import 'package:app2park/moduleoff/exit_join_model.dart';
import 'package:app2park/moduleoff/get_plate_by_cupom.dart';
import 'package:app2park/moduleoff/get_ticket_by_cupom.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/name_table_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_off_model.dart';
import 'package:app2park/moduleoff/ticket/tickets_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class CheckExitPage extends StatefulWidget {
  @override
  _CheckExitPageState createState() => _CheckExitPageState();
}

class _CheckExitPageState extends State<CheckExitPage> {
  SharedPref sharedPref = SharedPref();
  List<ExitJoinModel> exitJoinList;
  TicketsDao ticketsDao = TicketsDao();
  AgreementsDao agreementDao = AgreementsDao();
  TicketHistoricDao ticketHistoricDao = TicketHistoricDao();
  List<AgreementsOff> agreementsList = List<AgreementsOff>();
  String plate = ' ';
  String modelo = ' ';
  bool jasaiu = false;
  bool botaosaiu = false;
  bool cupomexists = false;
  bool agreementinvalid = true;
  String tipo = 'Avulso';
  List<String> errorList = List<String>();
  Park park = Park();
  User userLoad = User();
  int id_ticket_app = 0;
  int id_tabela = 0;
  int mensalista = 0;
  int id_vehicle = 0;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String saida =
      DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();
  String entrada = '';
  String nometabela = '';
  int id_price_detached = 0;
  TicketsOffModel ticketOff;
  String pay_until;
  String nows = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  @override
  void initState() {
    loadSharedPrefs();
    super.initState();

  }

  loadSharedPrefs() async {
    try {
      int id_cupom = int.parse(await sharedPref.read("exitcar"));
      Park ps = Park.fromJson(await sharedPref.read("park"));
      User user = User.fromJson(await sharedPref.read("user"));
      int v = await sharedPref.read("id_vehicle");

      setState(() {
        userLoad = user;
        park = ps;
      });

      if (await ticketsDao.verifyCupom(id_cupom, int.parse(ps.id))) {
        List<GetTicketByCupom> lista = await ticketHistoricDao.getCupombyTicket(
            id_cupom, int.parse(ps.id));

        GetTicketByCupom getIdTicket = lista.first;

        List<GetPlateByCupom> getPlateList = await ticketHistoricDao
            .getPlatebyTicket(id_cupom, int.parse(ps.id));

        GetPlateByCupom getPlateByCupom = getPlateList.first;

        List<TicketsOffModel> ticketsList = await ticketsDao
            .getInformationTicket(getIdTicket.id_ticket_app, id_cupom);

        ticketOff = ticketsList.first;

        agreementsList = await agreementDao.getAgreementByPlate(
            int.parse(ps.id), getPlateByCupom.plate);

        if (agreementsList.length > 0) {
          setState(() {
            tipo = 'Mensalista';
            mensalista = 1;
          });
          for (int i = 0; i < agreementsList.length; i++) {
            AgreementsOff agreementsOff = agreementsList[i];

            DateTime now = DateTime.now();
            String formattedDate = DateFormat('kk:mm').format(now);

            List horaAtualListSplit = formattedDate.split(':');
            int horaAtual = int.parse(horaAtualListSplit[0]);
            int minutoAtual = int.parse(horaAtualListSplit[1]);

            List timeOffSplitList = agreementsOff.time_off.split(':');
            int horaSaida = int.parse(timeOffSplitList[0]);
            int minutoSaida = int.parse(timeOffSplitList[1]);

            List<NameTableModel> nameTableList =
                await agreementDao.nameTableAgreements(
                    agreementsOff.id_price_detached, int.parse(ps.id));
            NameTableModel nameModel = nameTableList.first;

            if (horaAtual >= horaSaida) {
              DateFormat dateFormat1 = DateFormat("yyyy-MM-dd");
              String stringw = dateFormat1.format(DateTime.now());
              setState(() {
                botaosaiu = false;
                agreementinvalid = false;
                id_tabela = agreementsOff.id_price_detached;
                id_vehicle = v;
                id_ticket_app = getIdTicket.id_ticket_app;
                entrada = '${stringw} ${agreementsOff.time_off}';
                nometabela = nameModel.name;
                jasaiu = true;
              });

              alertModal(context, "Atenção!!",
                  'Veículo fora do horário contratado, Caso queira dar saida com avulso clique continuar.');
            } else {
              setState(() {
                botaosaiu = true;
                agreementinvalid = false;
                id_ticket_app = getIdTicket.id_ticket_app;
                park = ps;
                userLoad = user;
                mensalista = 0;
              });
            }
          }
        }

        exitJoinList = await ticketsDao.getExitInformation(id_cupom);
        for (int i = 0; i < exitJoinList.length; i++) {
          ExitJoinModel exitJoinModel = exitJoinList[i];
          if (exitJoinModel.id_ticket_historic_status == 11) {
            setState(() {
              cupomexists = true;
              botaosaiu = true;
              jasaiu = true;
              plate = exitJoinModel.plate;
              modelo = exitJoinModel.model;
            });
          } else {
            setState(() {
              cupomexists = true;
              jasaiu = false;
              plate = exitJoinModel.plate;
              modelo = exitJoinModel.model;
            });
          }

          if (exitJoinModel.id_ticket_historic_status == 2) {
            if (mensalista != 1) {
              sharedPref.remove("entrada");
              sharedPref.save("entrada", exitJoinModel.date_time);
            }
            sharedPref.remove("plate");
            sharedPref.save("plate", exitJoinModel.plate);
            sharedPref.remove("model");
            sharedPref.save("model", exitJoinModel.model);
            sharedPref.remove("type");
            sharedPref.save("type", exitJoinModel.type);
            sharedPref.remove("id_ticket_app");
            sharedPref.save("id_ticket_app", exitJoinModel.id_ticket_app);
            setState(() {
              if (ticketOff.id_price_detached_app != null ||
                  ticketOff.id_price_detached_app != 0) {
                id_price_detached = ticketOff.id_price_detached_app;
              } else {
                id_price_detached = 0;
              }
            });
          }
        }
      } else {
        setState(() {
          cupomexists = false;
          botaosaiu = true;
          agreementinvalid = true;
        });
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION',
          now.toString(), 'ERRO CHECK EXIT PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirmação de Dados Saída",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'PLACA: $plate',
                  style: TextStyle(fontSize: 32),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Modelo : $modelo",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Tipo : $tipo",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                cupomexists
                    ? Container()
                    : Text(
                        'Atenção : Cupom não existe!',
                        style: TextStyle(color: Colors.red, fontSize: 22),
                      ),
                jasaiu
                    ? Text(
                        "Historico do Veículo :",
                        style: TextStyle(fontSize: 22),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                jasaiu
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: exitJoinList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                          'Ação: ${exitJoinList[index].name} Horário: ${exitJoinList[index].date_time}'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                botaosaiu
                    ? Container()
                    : ButtonApp2Park(
                        text: 'Continuar',
                        onPressed: () async {
                          if (ticketOff.pay_until == null || ticketOff.pay_until == '') {
                            if (id_price_detached != 0) {
                              sharedPref.remove("saida");
                              sharedPref.save("saida", saida);
                              sharedPref.save(
                                  'id_price_detached_app', id_price_detached);
                              Navigator.of(context)
                                  .pushNamed(ExitServiceViewRoute);
                            } else {
                              Navigator.of(context)
                                  .pushNamed(ExitSelectPriceViewRoute);
                            }
                          } else {
                            pay_until = ticketOff.pay_until;
                            if (!DateTime.parse(pay_until).isAfter(DateTime.now())) {
                              sharedPref.save('entrada', ticketOff.pay_until);
                              sharedPref.save('saida', saida);
                              Navigator.of(context)
                                  .pushNamed(ExitSelectPriceViewRoute);
                            } else {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());

                              TicketHistoricOffModel ticketHistoricOffModel =
                                  TicketHistoricOffModel(
                                      0,
                                      0,
                                      ticketOff.id_ticket_app,
                                      11,
                                      ticketOff.id_user,
                                      0,
                                      0,
                                      saida);

                              int id_ticket_historic = await ticketHistoricDao
                                  .saveTicketHistoric(ticketHistoricOffModel);

                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                TicketHistoricModel ticketHistoric =
                                    TicketHistoricModel();
                                ticketHistoric.id_ticket_historic_status = '11';
                                ticketHistoric.id_ticket_historic_app =
                                    id_ticket_historic.toString();
                                ticketHistoric.id_ticket =
                                    ticketOff.id.toString();
                                ticketHistoric.id_ticket_app =
                                    id_ticket_app.toString();
                                ticketHistoric.id_user =
                                    ticketOff.id_user.toString();
                                ticketHistoric.date_time = saida;

                                TicketHistoricResponse ticketHRes =
                                    await TicketService.createTicketHistoric(
                                        ticketHistoric);

                                if (ticketHRes.status == 'COMPLETED') {
                                  TicketHistoricModel ticketHis =
                                      ticketHRes.data;

                                  bool ok = await ticketHistoricDao
                                      .updateTicketHistoricIdOn(
                                          int.parse(ticketHis.id),
                                          ticketOff.id,
                                          id_ticket_historic);
                                }
                              }
                              Navigator.of(context).pushNamedAndRemoveUntil(HomeParkViewRoute, (route) => false);
                            }
                          }
                        }),
                SizedBox(
                  height: 10,
                ),
                agreementinvalid
                    ? Container()
                    : jasaiu
                        ? Container()
                        : ButtonApp2Park(
                            text: 'Realizar saída (Mensalista)',
                            onPressed: () async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());

                              TicketHistoricOffModel ticketHistoricOffModel =
                                  TicketHistoricOffModel(
                                      0,
                                      0,
                                      id_ticket_app,
                                      11,
                                      int.tryParse(userLoad.id),
                                      0,
                                      0,
                                      saida);

                              int id_ticket_historic = await ticketHistoricDao
                                  .saveTicketHistoric(ticketHistoricOffModel);

                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                List<TicketsOffModel> listTicketOffModel =
                                    await ticketsDao.getTicketInfo(
                                        id_ticket_app, int.tryParse(park.id));

                                TicketsOffModel ticketOffModel =
                                    listTicketOffModel.first;

                                TicketHistoricModel ticketHistoric =
                                    TicketHistoricModel();
                                ticketHistoric.id_ticket_historic_status = '11';
                                ticketHistoric.id_ticket_historic_app =
                                    id_ticket_historic.toString();
                                ticketHistoric.id_ticket =
                                    ticketOffModel.id.toString();
                                ticketHistoric.id_ticket_app =
                                    id_ticket_app.toString();
                                ticketHistoric.id_user = userLoad.id;
                                ticketHistoric.date_time = saida;

                                TicketHistoricResponse ticketHRes =
                                    await TicketService.createTicketHistoric(
                                        ticketHistoric);

                                if (ticketHRes.status == 'COMPLETED') {
                                  TicketHistoricModel ticketHis =
                                      ticketHRes.data;

                                  bool ok = await ticketHistoricDao
                                      .updateTicketHistoricIdOn(
                                          int.parse(ticketHis.id),
                                          ticketOffModel.id,
                                          id_ticket_historic);
                                }
                              }

                              Navigator.of(context)
                                  .pushNamed(HomeParkViewRoute);
                            },
                          ),
                SizedBox(
                  height: 10,
                ),
                ButtonApp2Park(
                  text: 'Digitar cupom novamente',
                  onPressed: () {
                    Navigator.pushNamed(context, ExitViewRoute);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

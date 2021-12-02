import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/sinc/sinc.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park/park_user_dao.dart';
import 'package:app2park/db/dao/subscription/subscription_dao.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/ParkOff.dart';
import 'package:app2park/moduleoff/puser/park_user_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:notification_banner/notification_banner.dart';

class CardParkOff extends StatelessWidget {
  final ParkOff park;
  final User user;
  final int diff;

  SharedPref sharedPref = SharedPref();

  CardParkOff(this.park, this.user, this.diff);

  Sinc sinc = Sinc();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 250,
      margin: EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 220,
              height: 200,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(color: diff > 15 ? Colors.black12 : diff > 1 ? Colors.yellow : Colors.red, blurRadius: 15)
                  ]),
              child: GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      park.name_park,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(park.business_name),
                    Text(
                      park.doc,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Text(
                      '${park.street}, ${park.number} - ${park.complement} -${park.city} - ${park.state}',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  try{

                    ParkUserDao parkUserDao = ParkUserDao();

                    SubscriptionDao subsDao = SubscriptionDao();

                    List<ParkUserOff> parkUserOffList = await parkUserDao.getCargoInformation(int.parse(park.id), int.parse(user.id));

                    ParkUserOff parkuserOff = parkUserOffList.first;


                    sharedPref.remove("park_user");
                    sharedPref.save("park_user", parkuserOff);
                    sharedPref.remove("id_office");
                    sharedPref.save("id_office", parkuserOff.id_office);
                    sharedPref.remove("park");
                    sharedPref.save("park", park);

                    sinc.sincPeriodic(park.id.toString(), user.id);
                    sinc.sincSingle(park.id.toString(), user.id);
                    sinc.start();
                    sinc.start2();

                    DateTime dataSubs = DateTime.parse(park.subscription);
                    DateTime now = DateTime.now();

                    var difference = dataSubs.difference(now).inDays;


                    bool ok = await subsDao.verifyUserHaveSubscription(int.tryParse(user.id));

                    if(difference > 0){
                      if(difference > 15){
                        Navigator.of(context).pushNamed(HomeParkViewRoute);
                      }

                      if(!ok){
                        if(difference <= 15){

                          if(difference <= 5){

                            parkuserOff.id_office < 3 ? alertVoltaProprietario(context, 'Atenção',
                                'O período de teste gratuito termina em ${DateFormat("dd/MM/yyyy").format(DateTime.parse(park.subscription))} .'
                                    ' Importante efetuar o pagamento da Assinatura até 3 dias úteis antes do término do prazo de testes, para que haja tempo do boleto ser compensado, e de não bloquear o'
                                    ' funcionamento.'

                            ) : alertVoltaGerente(context, 'Atenção',
                                'O período de teste gratuito termina em ${DateFormat("dd/MM/yyyy").format(DateTime.parse(park.subscription))} .'
                                    ' Importante efetuar o pagamento da Assinatura até 3 dias úteis antes do término do prazo de testes, para que haja tempo do boleto ser compensado, e de não bloquear o'
                                    ' funcionamento.'
                                    'Por favor, informe o proprietário!'
                            );

                          }else{
                            parkuserOff.id_office < 3 ? alertVoltaProprietario(context, 'Atenção',
                                'Ainda não identificamos seu pagamento.'
                                    ' A entrada de veículos será bloqueada dia ${DateFormat("dd/MM/yyyy").format(DateTime.parse(park.subscription))}'
                                    ' Se o pagamento já foi efetuado, por favor, envie o comprovante para: financeiro@app2park.com.br'
                            ) : alertVoltaGerente(context, 'Atenção',
                                'Ainda não identificamos seu pagamento.'
                                    'A entrada de veículos será bloqueada dia ${DateFormat("dd/MM/yyyy").format(DateTime.parse(park.subscription))}'
                                    ' Se o pagamento já foi efetuado, por favor, envie o comprovante para: financeiro@app2park.com.br'
                                    ' Por favor, informe o proprietário!'
                            );

                          }
                        }
                      }else{
                        if(difference <= 5 ){

                          parkuserOff.id_office < 3 ? alertVoltaProprietario(context, 'Atenção',
                              'Ainda não identificamos seu pagamento.'
                                  'A entrada de veículos será bloqueada dia ${DateFormat("dd/MM/yyyy").format(DateTime.parse(park.subscription))}'
                                  'Se o pagamento já foi efetuado, por favor, envie o comprovante para: financeiro@app2park.com.br'
                          ) : alertVoltaGerente(context, 'Atenção',
                              'Ainda não identificamos seu pagamento.'
                                  ' A entrada de veículos será bloqueada dia ${DateFormat("dd/MM/yyyy").format(DateTime.parse(park.subscription))}'
                                  ' Se o pagamento já foi efetuado, por favor, envie o comprovante para: financeiro@app2park.com.br'
                                  ' Por favor, informe o proprietário!'
                          );

                        }
                      }
                    }else{
                      parkuserOff.id_office < 3 ? alertVoltaProprietario(context, 'Atenção',
                          'Entrada de veículos está bloqueada por falta de pagamento.'
                          ' Se o pagamento já foi efetuado, por favor, envie o comprovante para: financeiro@app2park.com.br'
                      ) : alertVoltaGerente(context, 'Atenção',
                          'Entrada de veículos está bloqueada por falta de pagamento.'
                          ' Se o pagamento já foi efetuado, por favor, envie o comprovante para: financeiro@app2park.com.br'
                          ' Por favor, informe o proprietário!'
                      );
                    }

                  }catch(e){
                    DateTime now = DateTime.now();
                    LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO CARD PARK', 'APP');
                    LogDao logDao = LogDao();
                    logDao.saveLog(logOff);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  alertVoltaProprietario(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text('Assinatura'),
      onPressed: () {
        Navigator.of(context).pushNamed(SignaturePageViewRoute);
      },
    );
    Widget backButton = FlatButton(
      child: Text('Mais tarde'),
      onPressed: () async {
        Navigator.of(context).pushNamed(HomeParkViewRoute);
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
  alertVoltaGerente(BuildContext context, String textTitle, String textCenter) {
    Widget backButton = FlatButton(
      child: Text('Continuar'),
      onPressed: () async {
        Navigator.of(context).pushNamed(HomeParkViewRoute);
      },
    );


    AlertDialog alerta = AlertDialog(
      title: Text(textTitle),
      content: Text(textCenter),
      actions: [
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
}

import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/views/cashier/select/select_cashier_page.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/puser/park_user_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class DrawerPark extends StatefulWidget {
  @override
  _DrawerParkState createState() => _DrawerParkState();
}

class _DrawerParkState extends State<DrawerPark> {
  Park p = new Park();
  SharedPref sharedPref = SharedPref();
  int id_office = 0;

  loadSharedPrefs() async {
    try {
      Park pk = Park.fromJson(await sharedPref.read("park"));
      int id_o = await sharedPref.read("id_office");
      setState(() {
        p = pk;
        id_office = id_o;
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO DRAWER PARK', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  _header(BuildContext context, park) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color.fromRGBO(41, 202, 168, 3),
      ),
      accountName: new Text(park.name_park ?? " "),
      accountEmail: null,
      currentAccountPicture: CircleAvatar(
        backgroundImage: new NetworkImage(park.photo ??
            "https://app2parkstorage.s3.amazonaws.com/no-photo.png"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _header(context, p),
            ListTile(
                leading: Icon(Icons.home),
                title: Text("Início"),
                subtitle: Text("Voltar ao Início"),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeParkViewRoute, (Route<dynamic> route) => false);
                }),
            id_office <= 4
                ? ExpansionTile(
                    leading: Icon(Icons.attach_money),
                    title: Text("Caixa"),
                    subtitle: Text('Abertura e Fechamento de Caixa'),
                    children: <Widget>[
                      ListTile(
                          leading: Icon(Icons.add),
                          title: Text("Abrir um novo Caixa"),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(OpenCashierPageViewRoute);
                          }),
                      ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: Text("Fechamento de Caixa"),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(CloseCashierPageViewRoute);
                          }),
                      ListTile(
                          leading: Icon(Icons.payment),
                          title: Text("Pagamento de Despesa"),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(PaymentCashierPageViewRoute);
                          }),
                      ListTile(
                          leading: Icon(Icons.help_outline),
                          title: Text("Reforço de Caixa (Suprimento)"),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(SupplyCashierPageViewRoute);
                          }),
                      ListTile(
                          leading: Icon(Icons.security),
                          title: Text("Sangria"),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(SecurityCashierPageViewRoute);
                          }),
                      ListTile(
                          leading: Icon(Icons.payment),
                          title: Text("Pagamento Mensalista"),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(CashierAgreementViewRoute);
                          }),
                      id_office <= 4
                          ? ListTile(
                              leading: Icon(Icons.message),
                              title: Text("Resumo"),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(SelectCashierPageViewRoute);
                              })
                          : Container(),
                    ],
                  )
                : Container(),
            id_office <= 3
                ? ExpansionTile(
                    leading: Icon(Icons.settings),
                    title: Text("Configurações do Estacionamento "),
                    children: <Widget>[
                      id_office <= 2
                          ? ListTile(
                              leading: Icon(Icons.directions_car),
                              title: Text("Dados Estacionamento"),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ChangeDataParkViewRoute);
                              })
                          : Container(),
                      id_office <= 2
                          ? ListTile(
                              leading: Icon(Icons.camera_alt),
                              title: Text("Logo do Estacionamento"),
                              subtitle: Text("Alterar Logo"),
                              onTap: () async {
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());

                                if (connectivityResult ==
                                        ConnectivityResult.mobile ||
                                    connectivityResult ==
                                        ConnectivityResult.wifi) {
                                  Navigator.of(context)
                                      .pushNamed(ImageParkViewRoute);
                                } else {
                                  alertModal(context, 'Atenção',
                                      'Para utilizar desse recurso, você precisa está conectado a internet!!');
                                }
                              })
                          : Container(),
                      id_office <= 2
                          ? ListTile(
                          leading: Icon(
                            Icons.attach_money,
                          ),
                          title: Text(
                            "Formas de Pagamentos",
                          ),
                          subtitle: Text(
                            "Escolha formas de pagamento",
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(PaymentFormViewRoute);
                          })
                          : Container(),
                      /*ListTile(
                    leading: Icon(Icons.timer),
                    title: Text("Horario de Funcionamento"),
                    onTap: () {
                      Navigator.of(context).pushNamed(SettingsHourViewRoute);
                    }),*/
                      id_office <= 2
                          ? ListTile(
                              leading: Icon(Icons.directions_car),
                              title: Text("Tipo de Veículo"),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(VehicleTypeViewRoute);
                              })
                          : Container(),
                      id_office <= 2
                          ? ListTile(
                              leading: Icon(Icons.monetization_on),
                              title: Text("Tabela de Preços"),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(PriceDetachedPageViewRoute);
                              })
                          : Container(),
                      /*id_office <= 2 ? ListTile(
                    leading: Icon(Icons.format_align_justify),
                    title: Text("Funcionalidades"),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(SettingsfunctionalitiesViewRoute);
                    }) : Container(),*/
                      id_office <= 2
                          ? ListTile(
                              leading: Icon(Icons.work),
                              title: Text("Serviços Adicionais"),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ServiceAddViewRoute);
                              })
                          : Container(),
                    ],
                  )
                : Container(),
            id_office <= 3
                ? ExpansionTile(
                    leading: Icon(Icons.people),
                    title: Text("Colaboradores"),
                    children: <Widget>[
                      ListTile(
                          leading: Icon(Icons.person),
                          title: Text("Administrar Colaboradores"),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(EmployeesViewRoute);
                          }),
                      ListTile(
                          leading: Icon(Icons.add),
                          title: Text("Convidar Colaborador"),
                          onTap: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());

                            if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {
                              Navigator.of(context)
                                  .pushNamed(InfInviteEmployeesViewRoute);
                            }else{
                              alertModal(context, 'Atenção', 'Para utilizar desse recurso, você precisa está conectado a internet!!');
                            }
                          }),
                    ],
                  )
                : Container(),
            id_office <= 3
                ? ExpansionTile(
                    leading: Icon(Icons.receipt),
                    title: Text("Mensalistas / Contratos"),
                    children: <Widget>[
                      ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text("Mensalistas"),
                          subtitle: Text('Varios Meses'),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(MonthlyListViewRoute);
                          }),
                      ListTile(
                          leading: Icon(Icons.date_range),
                          title: Text("Pacotes de Diárias"),
                          subtitle: Text("Algumas diárias"),
                          onTap: () {
                            Navigator.of(context).pushNamed(DailyListViewRoute);
                          }),
                      ListTile(
                          leading: Icon(Icons.timelapse),
                          title: Text("Permanências Longas"),
                          subtitle: Text('Permanece no pátio por dias'),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(PermanenceListViewRoute);
                          }),
                    ],
                  )
                : Container(),
            Divider(),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Sair do Estacionamento"),
                subtitle: Text("Mudar de Estacionamento"),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(HomeViewRoute);
                }),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/layout/isLoadingLogin.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormValidate.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/helpers/sinc/sinc.dart';
import 'package:app2park/db/dao/cashier/type/cash_type_movement_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/objects_dao.dart';
import 'package:app2park/db/dao/office/offices_dao.dart';
import 'package:app2park/db/dao/park/ParkDao.dart';
import 'package:app2park/db/dao/park/park_user_dao.dart';
import 'package:app2park/db/dao/park_service_additional_dao.dart';
import 'package:app2park/db/dao/payment/payment_method_dao.dart';
import 'package:app2park/db/dao/payment/payment_method_park_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_item_base_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_item_dao.dart';
import 'package:app2park/db/dao/service_additional_dao.dart';
import 'package:app2park/db/dao/status/status_dao.dart';
import 'package:app2park/db/dao/ticket_historic_status_dao.dart';
import 'package:app2park/db/dao/user/user_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_park_dao.dart';
import 'package:app2park/db/dao/version_dao.dart';
import 'package:app2park/module/cashier/service/cash_service.dart';
import 'package:app2park/module/cashier/type/cash_type_movement_model.dart';
import 'package:app2park/module/config/ParkResponseGet.dart';
import 'package:app2park/module/config/ParkUserResponse.dart';
import 'package:app2park/module/config/UserResponse.dart';
import 'package:app2park/module/config/cash_type_response.dart';
import 'package:app2park/module/config/get_parkuser_response.dart';
import 'package:app2park/module/config/objects_response.dart';
import 'package:app2park/module/config/office_response.dart';
import 'package:app2park/module/config/park_service_additional_response.dart';
import 'package:app2park/module/config/payment_method_park_response.dart';
import 'package:app2park/module/config/payment_method_response.dart';
import 'package:app2park/module/config/price_detached_item_response.dart';
import 'package:app2park/module/config/price_detached_response.dart';
import 'package:app2park/module/config/price_item_base_response.dart';
import 'package:app2park/module/config/service_additional_response.dart';
import 'package:app2park/module/config/status_response.dart';
import 'package:app2park/module/config/ticket_historic_status_response.dart';
import 'package:app2park/module/config/user_list_response.dart';
import 'package:app2park/module/config/vehicle_type_park_response.dart';
import 'package:app2park/module/config/vehicle_type_response.dart';
import 'package:app2park/module/config/version_response.dart';
import 'package:app2park/module/object_service.dart';
import 'package:app2park/module/objects_model.dart';
import 'package:app2park/module/office/office_model.dart';
import 'package:app2park/module/office/service/office_service.dart';
import 'package:app2park/module/park/payments/payment_method_model.dart';
import 'package:app2park/module/park/payments/payment_method_park_model.dart';
import 'package:app2park/module/park/payments/services/payments_service.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_historic_status_model.dart';
import 'package:app2park/module/park/vehicle/service/VehicleService.dart';
import 'package:app2park/module/park/vehicle/vehicle_type_model.dart';
import 'package:app2park/module/park/vehicle/vehicle_type_park_model.dart';
import 'package:app2park/module/park_service_additional.dart';
import 'package:app2park/module/payment/price/price_detached_model.dart';
import 'package:app2park/module/payment/priceitem/price_detached_item_model.dart';
import 'package:app2park/module/payment/priceitembase/price_detached_item_base_model.dart';
import 'package:app2park/module/payment/service/price_service.dart';
import 'package:app2park/module/puser/park_user_model.dart';
import 'package:app2park/module/puser/service/park_user_service.dart';
import 'package:app2park/module/service_additional_model.dart';
import 'package:app2park/module/service_additional_service.dart';
import 'package:app2park/module/status/service/status_service.dart';
import 'package:app2park/module/status/status_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/module/user/services/UserService.dart';
import 'package:app2park/module/version.dart';
import 'package:app2park/moduleoff/cashier/type/cash_type_movement_off_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/objects_off_model.dart';
import 'package:app2park/moduleoff/office/office_off_model.dart';
import 'package:app2park/moduleoff/park/ParkOff.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_off_model.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_park_off_model.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_off_model.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_park_off_model.dart';
import 'package:app2park/moduleoff/park_service_additional_off_model.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_model.dart';
import 'package:app2park/moduleoff/payment/priceitem/price_detached_item_off_model.dart';
import 'package:app2park/moduleoff/payment/priceitembase/price_detached_item_base_off_model.dart';
import 'package:app2park/moduleoff/puser/park_user_off_model.dart';
import 'package:app2park/moduleoff/service_additional_off_model.dart';
import 'package:app2park/moduleoff/status/status_off_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_status_off_model.dart';
import 'package:app2park/moduleoff/user/user_off_model.dart';
import 'package:app2park/moduleoff/version_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User userLoad = User();
  final _formKey = GlobalKey<FormState>();
  final _email = new TextEditingController();
  final _pass = new TextEditingController();
  SharedPref sharedPref = SharedPref();
  String email = '';
  bool isLoading = false;
  bool enableEmail = true;
  bool enablePassword = true;
  bool active = false;
  bool _validateEmail = false;
  bool _validateSenha = false;
  Sinc sinc = Sinc();
  String vers;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPrefs();
  }

  abrirUrlSite() async {
    const url = 'https://www.app2park.com.br';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sharedPref.read("user"));
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      email = await sharedPref.read("email");
      setState(() {
        userLoad = user;
        active = false;
        vers = packageInfo.version;
        if (userLoad.email == '') {
          _email.text = email;
        } else {
          sinc.sincPeriodicPark(context, user.id);
          sinc.start3();
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomeViewRoute, (Route<dynamic> route) => false);
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(context),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
    );
  }

  _body(BuildContext context) {
    return isLoading
        ? isLoadingLoginPage()
        : Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/img/logo-app2park.png",
                    width: 250,
                    height: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Email : ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _email,
                    enabled: enableEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Digite seu Email',
                      errorText: _validateEmail ? 'Digite um email' : null,
                      suffixIcon: Icon(Icons.mail),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Senha : ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _pass,
                    enabled: enablePassword,
                    obscureText: true,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Digite sua senha',
                      errorText: _validateSenha ? 'Digite uma senha' : null,
                      suffixIcon: Icon(Icons.vpn_key),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  AbsorbPointer(
                    absorbing: active,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: InkWell(
                            child: SizedBox(
                              child: Text(
                                "Esqueceu a Senha",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onTap: () async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());

                              if (connectivityResult ==
                                      ConnectivityResult.mobile ||
                                  connectivityResult ==
                                      ConnectivityResult.wifi) {
                                Navigator.of(context)
                                    .pushNamed(ForgotPasswordViewRoute);
                              } else {
                                alertModal(context, 'Atenção',
                                    'Para utilizar desse recurso, você precisa está conectado a internet!!');
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 12,
                          child: Text(' | '),
                        ),
                        Platform.isAndroid ? InkWell(
                          child: Text(
                            "Novo Usuario",
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());

                            if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {
                              Navigator.of(context)
                                  .pushNamed(InfRegisterPersonViewRoute);
                            } else {
                              alertModal(context, 'Atenção',
                                  'Para utilizar desse recurso, você precisa está conectado a internet!!');
                            }
                          },
                        ) : InkWell(
                          child: Text('Visite nosso Site',style: TextStyle(color: Colors.blue, fontSize: 18),),
                          onTap: ()async{
                            var connectivityResult =
                            await (Connectivity().checkConnectivity());

                            if (connectivityResult ==
                                ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {
                              abrirUrlSite();
                            } else {
                              alertModal(context, 'Atenção',
                                  'Para utilizar desse recurso, você precisa está conectado a internet!!');
                            }

                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonApp2Park(
                    text: "Entrar",
                    onPressed: () async {
                      try {
                        if (_email.text.isEmpty) {
                          setState(() {
                            _email.text.isEmpty
                                ? _validateEmail = true
                                : _validateEmail = false;
                          });
                        } else if (_pass.text.isEmpty) {
                          setState(() {
                            _pass.text.isEmpty
                                ? _validateSenha = true
                                : _validateSenha = false;
                          });
                        } else {
                          setState(() {
                            active = true;
                          });
                          User user = User();
                          user.email = _email.text.toLowerCase();
                          user.pass = _pass.text;
                          setState(() {
                            isLoading = true;
                          });
                          UserResponse r = await UserService.login(user);

                          if (r.status == "COMPLETED") {
                            user = r.data;
                            sharedPref.remove('user');
                            sharedPref.remove('jwt');
                            sharedPref.save("user", user);
                            sharedPref.save("email", _email.text.toLowerCase());

                            setState(() {
                              enableEmail = false;
                              enablePassword = false;
                            });

                            sharedPref.save("jwt", r.jwt);
                            StatusResponse statusRes =
                                await StatusService.getStatus();
                            if (statusRes.status == 'COMPLETED') {
                              List<Status> lStatus = statusRes.data;
                              for (var i = 0; i < lStatus.length; i++) {
                                Status status = lStatus[i];
                                StatusDao _daoS = StatusDao();
                                int id = int.parse(status.id);
                                bool ok = await _daoS.verifyStatus(id);
                                if (!ok) {
                                  StatusOff statusOff =
                                      StatusOff(id, status.status);
                                  _daoS.saveStatus(statusOff);
                                }
                              }
                            }

                            VersionResponse versionRes =
                                await ParkService.Version();

                            if (versionRes.status == 'COMPLETED') {
                              if (versionRes.data != null) {
                                List<Version> listVersion = versionRes.data;

                                VersionDao versionDao = VersionDao();

                                for (int i = 0; i < listVersion.length; i++) {
                                  Version version = listVersion[i];

                                  bool ok = await versionDao
                                      .verifyVersion(int.tryParse(version.id));

                                  if (!ok) {
                                    VersionOff versionOff = VersionOff(
                                        int.tryParse(version.id),
                                        version.name,
                                        int.tryParse(version.id_status));

                                    versionDao.saveVersion(versionOff);
                                  }
                                }
                              }
                            }

                            OfficeResponse officeRes =
                                await OfficeService.getOffice();
                            if (officeRes.status == 'COMPLETED') {
                              List<Office> lOffice = officeRes.data;
                              for (var i = 0; i < lOffice.length; i++) {
                                Office office = lOffice[i];
                                OfficeDao officeDao = OfficeDao();
                                int id = int.parse(office.id);
                                bool ok = await officeDao.verifyOffice(id);
                                if (!ok) {
                                  OfficeOff officeOff =
                                      OfficeOff(id, office.office);
                                  officeDao.saveOffice(officeOff);
                                }
                              }
                            }

                            PriceItemBaseResponse priceItemBaseResponse =
                                await PriceService.getAllPriceItemBase();
                            List<PriceDetachedBase> priceItemBaseModelList =
                                priceItemBaseResponse.data;
                            for (int i = 0;
                                i < priceItemBaseModelList.length;
                                i++) {
                              PriceDetachedBase priceDetachedBase =
                                  priceItemBaseModelList[i];
                              PriceDetachedItemBaseDao priceDetachedItemDao =
                                  new PriceDetachedItemBaseDao();
                              int idPrice = int.parse(priceDetachedBase.id);
                              bool ok = await priceDetachedItemDao
                                  .verifyPriceItemBaseById(idPrice);
                              if (!ok) {
                                int id = int.parse(priceDetachedBase.id);
                                String name = priceDetachedBase.name;
                                String time = priceDetachedBase.time;
                                String type = priceDetachedBase.type;
                                int level = int.parse(priceDetachedBase.level);
                                int idStatus =
                                    int.parse(priceDetachedBase.id_status);
                                PriceDetachedItemBaseOff priceItemOff =
                                    PriceDetachedItemBaseOff(
                                        id, name, time, type, level, idStatus);
                                priceDetachedItemDao
                                    .savePriceDetachedItem(priceItemOff);
                              }
                            }

                            PaymentMethodResponse paymentMethodResponse =
                                await PaymentService.getPaymentMethod();
                            List<PaymentMethodModel> paymentMethodModelList =
                                paymentMethodResponse.data;
                            for (int i = 0;
                                i < paymentMethodModelList.length;
                                i++) {
                              PaymentMethodModel paymentMethodModel =
                                  paymentMethodModelList[i];
                              PaymentMethodDao paymentMethodDao =
                                  new PaymentMethodDao();
                              int id = int.parse(paymentMethodModel.id);
                              String name = paymentMethodModel.name;
                              double flat_rate =
                                  double.parse(paymentMethodModel.flat_rate);
                              double variable_rate = double.parse(
                                  paymentMethodModel.variable_rate);
                              double min_value =
                                  double.parse(paymentMethodModel.min_value);
                              int status = int.parse(paymentMethodModel.status);
                              int sort_order =
                                  int.parse(paymentMethodModel.sort_order);
                              bool ok = await paymentMethodDao
                                  .verifyPaymentMethod(id);
                              if (!ok) {
                                PaymentMethodOffModel paymentMethodOffModel =
                                    PaymentMethodOffModel(
                                        id,
                                        name,
                                        flat_rate,
                                        variable_rate,
                                        min_value,
                                        status,
                                        sort_order);

                                paymentMethodDao
                                    .savePaymentMethod(paymentMethodOffModel);
                              }
                            }

                            ObjectsResponse objectRes =
                                await ObjectService.getObjects();
                            if (objectRes.status == "COMPLETED") {
                              List<ObjectsModel> objectModelList =
                                  objectRes.data;
                              for (int i = 0; i < objectModelList.length; i++) {
                                ObjectsModel objectModel = objectModelList[i];
                                ObjectsDao objectsDao = ObjectsDao();
                                int id = int.parse(objectModel.id);
                                String name = objectModel.name;
                                int sort_order =
                                    int.parse(objectModel.sort_order);
                                bool ok = await objectsDao.verifyObjects(id);
                                if (!ok) {
                                  ObjectsOffModel objectOffModel =
                                      ObjectsOffModel(id, name, sort_order);
                                  objectsDao.saveObjects(objectOffModel);
                                }
                              }
                            }

                            VehicleTypeResponse vehicleTypeResponse =
                                await VehicleService.getVehicleType();
                            List<VehicleTypeModel> vehicleTypeModelList =
                                vehicleTypeResponse.data;
                            for (int i = 0;
                                i < vehicleTypeModelList.length;
                                i++) {
                              VehicleTypeModel vehicleTypeModel =
                                  vehicleTypeModelList[i];
                              VehicleTypeDao vehicleTypeDao =
                                  new VehicleTypeDao();
                              int verify = int.parse(vehicleTypeModel.id);
                              bool ok = await vehicleTypeDao
                                  .verifyVehicleTypeOffModelById(verify);
                              if (!ok) {
                                int id = int.parse(vehicleTypeModel.id);
                                String type = vehicleTypeModel.type;
                                VehicleTypeOffModel vehicleTypeOffModel =
                                    new VehicleTypeOffModel(id, type);
                                vehicleTypeDao.saveVehicleTypeOffModel(
                                    vehicleTypeOffModel);
                              }
                            }
                            CashTypeResponse cashTypeResponse =
                                await CashTypeService.getCashs();
                            List<CashTypeMovement> cashTypeMovementList =
                                cashTypeResponse.data;
                            for (int i = 0;
                                i < cashTypeMovementList.length;
                                i++) {
                              CashTypeMovement cashType =
                                  cashTypeMovementList[i];
                              CashTypeMovementDao cashDao =
                                  CashTypeMovementDao();
                              int IdCash = int.parse(cashType.id);
                              bool ok =
                                  await cashDao.verifyCashTypeById(IdCash);
                              if (!ok) {
                                int id = int.parse(cashType.id);
                                String type = cashType.name;
                                CashTypeMovementOff cashTypeOff =
                                    CashTypeMovementOff(id, type);
                                cashDao.saveCashType(cashTypeOff);
                              }
                            }

                            ServiceAdditionalResponse serviceAdditionalRes =
                                await ServiceAdditionalService
                                    .getServiceAdditional();
                            if (serviceAdditionalRes.status == "COMPLETED") {
                              List<ServiceAdditionalModel>
                                  serviceAdditionalList =
                                  serviceAdditionalRes.data;
                              for (int i = 0;
                                  i < serviceAdditionalList.length;
                                  i++) {
                                ServiceAdditionalModel serviceAdditionalModel =
                                    serviceAdditionalList[i];
                                ServiceAdditionalDao serviceAdditionalDao =
                                    ServiceAdditionalDao();
                                int id = int.parse(serviceAdditionalModel.id);
                                String name = serviceAdditionalModel.name;
                                int id_vehicle_type = int.parse(
                                    serviceAdditionalModel.id_vehicle_type);
                                int sort_order = int.parse(
                                    serviceAdditionalModel.sort_order);
                                bool ok = await serviceAdditionalDao
                                    .verifyServiceAdditional(id);
                                if (!ok) {
                                  ServiceAdditionalOffModel
                                      serviceAdditionalOffModel =
                                      ServiceAdditionalOffModel(id, name,
                                          id_vehicle_type, sort_order);
                                  serviceAdditionalDao.saveServiceAdditional(
                                      serviceAdditionalOffModel);
                                }
                              }
                            }

                            TicketHistoricStatusResponse
                                ticketHistoricStatusResponse =
                                await TicketService.getTicketHistoricStatus();
                            if (ticketHistoricStatusResponse.status ==
                                "COMPLETED") {
                              List<TicketHistoricStatusModel>
                                  ticketHistoricStatusList =
                                  ticketHistoricStatusResponse.data;
                              for (int i = 0;
                                  i < ticketHistoricStatusList.length;
                                  i++) {
                                TicketHistoricStatusModel ticketHistoricStatus =
                                    ticketHistoricStatusList[i];
                                TicketHistoricStatusDao
                                    ticketHistoricStatusDao =
                                    TicketHistoricStatusDao();
                                int id = int.parse(ticketHistoricStatus.id);
                                String name = ticketHistoricStatus.name;
                                bool ok = await ticketHistoricStatusDao
                                    .verifyTicketHistoricStatus(id);
                                if (!ok) {
                                  TicketHistoricStatusOffModel
                                      ticketHistoricStatusOffModel =
                                      TicketHistoricStatusOffModel(id, name);
                                  ticketHistoricStatusDao
                                      .saveTicketHistoricStatus(
                                          ticketHistoricStatusOffModel);
                                }
                              }
                            }

                            ParkUserResponse parkUserResponse =
                                await ParkUserService.getParks(
                                    user.id ?? '1', r.jwt);

                            if (parkUserResponse.status == 'COMPLETED') {
                              if (parkUserResponse.data != null) {
                                List<ParkUser> listParkUser =
                                    parkUserResponse.data;

                                ParkDao parkDao = ParkDao();

                                for (var i = 0; i < listParkUser.length; i++) {
                                  ParkUser parkUser = listParkUser[i];

                                  ParkUser parkUser10 = ParkUser();
                                  parkUser10.id_park = parkUser.id_park;
                                  UserListResponse userListRes =
                                      await ParkService
                                          .sincUserParkUserByIdPark(parkUser10);

                                  if (userListRes.status == 'COMPLETED') {
                                    if (userListRes.data != null) {
                                      UserDao userDao = UserDao();

                                      List<User> listUser = userListRes.data;

                                      for (int i = 0;
                                          i < listUser.length;
                                          i++) {
                                        User user = listUser[i];

                                        bool ok = await userDao
                                            .verifyUser(int.tryParse(user.id));

                                        if (!ok) {
                                          UserOff userOff = UserOff(
                                              user.id,
                                              user.first_name,
                                              user.last_name,
                                              user.cell,
                                              user.doc,
                                              user.email.toLowerCase(),
                                              user.pass,
                                              user.id_status);

                                          userDao.saveUser(userOff);
                                        }
                                      }
                                    }
                                  }

                                  bool parkOff = await parkDao
                                      .getParkById(int.parse(parkUser.id_park));
                                  if (!parkOff) {

                                    ParkResponseGet res =
                                        await ParkService.getPark(
                                            parkUser.id_park ?? '0', r.jwt);
                                    ParkOff parkOff2 = ParkOff(
                                        res.data.id,
                                        res.data.type,
                                        res.data.doc,
                                        res.data.name_park,
                                        res.data.business_name,
                                        res.data.cell,
                                        res.data.photo,
                                        res.data.postal_code,
                                        res.data.street,
                                        res.data.number,
                                        res.data.complement,
                                        res.data.neighborhood,
                                        res.data.city,
                                        res.data.state,
                                        res.data.country,
                                        res.data.vacancy,
                                        res.data.subscription,
                                        res.data.id_status,
                                        res.data.date_added,
                                        res.data.date_added);
                                    parkDao.savePark(parkOff2);
                                    ParkUserDao puserDao = ParkUserDao();
                                    int id = int.parse(parkUser.id);
                                    int id_park = int.parse(parkUser.id_park);
                                    int id_user = int.parse(parkUser.id_user);
                                    int id_office =
                                        int.parse(parkUser.id_office);
                                    int id_status =
                                        int.parse(parkUser.id_status);
                                    ParkUserOff puserOff = ParkUserOff(
                                        id,
                                        id_park,
                                        id_user,
                                        id_office,
                                        id_status,
                                        parkUser.keyval,
                                        parkUser.date_added,
                                        parkUser.date_edited);
                                    puserDao.saveParkUser(puserOff);
                                  } else {
                                    ParkUserDao puserDao = ParkUserDao();
                                    int id = int.parse(parkUser.id);
                                    int id_park = int.parse(parkUser.id_park);
                                    int id_user = int.parse(parkUser.id_user);
                                    int id_office =
                                        int.parse(parkUser.id_office);
                                    int id_status =
                                        int.parse(parkUser.id_status);
                                    bool ok = await puserDao.verifyPuser(id);
                                    if (!ok) {
                                      ParkUserOff puserOff = ParkUserOff(
                                          id,
                                          id_park,
                                          id_user,
                                          id_office,
                                          id_status,
                                          parkUser.keyval,
                                          parkUser.date_added,
                                          parkUser.date_edited);
                                      puserDao.saveParkUser(puserOff);
                                    }
                                  }

                                  GetParkUserResponse getParkUserRes =
                                      await ParkUserService.getallPuser(
                                          parkUser.id_park);

                                  if (getParkUserRes.status == 'COMPLETED') {
                                    if (getParkUserRes.data != null) {
                                      ParkUserDao parkUserDao = ParkUserDao();

                                      List<ParkUser> listParkUser =
                                          getParkUserRes.data;

                                      for (int i = 0;
                                          i < listParkUser.length;
                                          i++) {
                                        ParkUser parkUser = listParkUser[i];

                                        bool ok = await parkUserDao.verifyPuser(
                                            int.tryParse(parkUser.id));

                                        if (!ok) {
                                          ParkUserOff parkuserOff = ParkUserOff(
                                              int.tryParse(parkUser.id),
                                              int.tryParse(parkUser.id_park),
                                              int.tryParse(parkUser.id_user),
                                              int.tryParse(parkUser.id_office),
                                              int.tryParse(parkUser.id_status),
                                              parkUser.keyval,
                                              parkUser.date_added,
                                              parkUser.date_edited);

                                          parkUserDao.saveParkUser(parkuserOff);
                                        }
                                      }
                                    }
                                  }

                                  PaymentMethodParkResponse
                                      paymentMethodParkResponse =
                                      await PaymentService.getPaymentMethodPark(
                                          parkUser.id_park);
                                  List<PaymentMethodParkModel>
                                      paymentMethodParkModelList =
                                      paymentMethodParkResponse.data;
                                  for (int i = 0;
                                      i < paymentMethodParkModelList.length;
                                      i++) {
                                    PaymentMethodParkModel
                                        paymentMethodParkModel =
                                        paymentMethodParkModelList[i];
                                    PaymentMethodParkDao paymentMethodParkDao =
                                        new PaymentMethodParkDao();
                                    int id =
                                        int.parse(paymentMethodParkModel.id);
                                    int id_park = int.parse(
                                        paymentMethodParkModel.id_park);
                                    int id_payment_method = int.parse(
                                        paymentMethodParkModel
                                            .id_payment_method);
                                    double flat_rate = double.parse(
                                        paymentMethodParkModel.flat_rate);
                                    double variable_rate = double.parse(
                                        paymentMethodParkModel.variable_rate);
                                    double min_value = double.parse(
                                        paymentMethodParkModel.min_value);
                                    int status = int.parse(
                                        paymentMethodParkModel.status);
                                    int sort_order = int.parse(
                                        paymentMethodParkModel.sort_order);
                                    bool ok = await paymentMethodParkDao
                                        .verifyPaymentMethodPark(id);
                                    if (!ok) {
                                      PaymentMethodParkOffModel
                                          paymentMethodParkOffModel =
                                          PaymentMethodParkOffModel(
                                              id,
                                              id_park,
                                              id_payment_method,
                                              flat_rate,
                                              variable_rate,
                                              min_value,
                                              status,
                                              sort_order);

                                      paymentMethodParkDao
                                          .savePaymentMethodPark(
                                              paymentMethodParkOffModel);
                                    }
                                  }

                                  PriceDetachedResponse priceDetachedRes =
                                      await PriceService
                                          .getAllPricesDetachedByPark(
                                              parkUser.id_park);

                                  if (priceDetachedRes.status == 'COMPLETED') {
                                    if (priceDetachedRes.data != null) {
                                      List<PriceDetached> priceDetachedList =
                                          priceDetachedRes.data;
                                      PriceDetachedDao priceDetachedDao =
                                          PriceDetachedDao();
                                      PriceDetachedItemDao
                                          priceDetachedItemDao =
                                          PriceDetachedItemDao();

                                      for (int i = 0;
                                          i < priceDetachedList.length;
                                          i++) {
                                        PriceDetached priceDetached =
                                            priceDetachedList[i];

                                        bool ok = await priceDetachedDao
                                            .verifyPriceDetached(
                                                int.tryParse(priceDetached.id));

                                        if (!ok) {
                                          PriceDetachedOff priceDetachedOff =
                                              PriceDetachedOff(
                                                  int.tryParse(
                                                      priceDetached.id),
                                                  int.tryParse(
                                                      priceDetached.id_park),
                                                  priceDetached.name,
                                                  priceDetached.daily_start,
                                                  int.tryParse(priceDetached
                                                      .id_vehicle_type),
                                                  int.tryParse(
                                                      priceDetached.id_status),
                                                  1,
                                                  int.tryParse(
                                                      priceDetached.sort_order),
                                                  priceDetached.data_sinc);

                                          int id_price_detached_app =
                                              await priceDetachedDao
                                                  .savePriceDetached(
                                                      priceDetachedOff);

                                          PriceDetached priceD =
                                              PriceDetached();
                                          priceD.id_price_detached_app =
                                              id_price_detached_app.toString();

                                          PriceDetachedResponse priceDRes =
                                              await PriceService
                                                  .updatePriceDetached(
                                                      priceDetached.id, priceD);

                                          PriceDetachedItemResponse
                                              priceDetachedItemRes =
                                              await PriceService
                                                  .getAllPricesDetachedByIdDetached(
                                                      priceDetached.id);

                                          if (priceDetachedItemRes.status ==
                                              'COMPLETED') {
                                            if (priceDetachedItemRes.data !=
                                                null) {
                                              List<PriceDetachedItem>
                                                  priceDetachedItemList =
                                                  priceDetachedItemRes.data;

                                              for (int i = 0;
                                                  i <
                                                      priceDetachedItemList
                                                          .length;
                                                  i++) {
                                                PriceDetachedItem
                                                    priceDetachedItem =
                                                    priceDetachedItemList[i];

                                                bool ok =
                                                    await priceDetachedItemDao
                                                        .verifyPriceDetachedItem(
                                                            int.tryParse(
                                                                priceDetachedItem
                                                                    .id));

                                                if (!ok) {
                                                  PriceDetachedItemOff
                                                      priceDetachedItemOff =
                                                      PriceDetachedItemOff(
                                                          int.tryParse(
                                                              priceDetachedItem
                                                                  .id),
                                                          int.tryParse(
                                                              priceDetachedItem
                                                                  .id_price_detached),
                                                          id_price_detached_app,
                                                          int.tryParse(
                                                              priceDetachedItem
                                                                  .id_price_detached_item_base),
                                                          double.parse(
                                                              priceDetachedItem
                                                                  .price),
                                                          priceDetachedItem
                                                              .tolerance);

                                                  int id_price_detached_item_off =
                                                      await priceDetachedItemDao
                                                          .savePriceDetachedItem(
                                                              priceDetachedItemOff);


                                                  PriceDetachedItem priceDI =
                                                      PriceDetachedItem();
                                                  priceDI.id_price_detached_item_app =
                                                      id_price_detached_item_off
                                                          .toString();

                                                  PriceDetachedItemResponse
                                                      priceDIRes =
                                                      await PriceService
                                                          .updatePriceDetachedItem(
                                                              priceDetachedItem
                                                                  .id,
                                                              priceDI);

                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }

                                  VehicleTypeParkResponse
                                      vehicleTypeParkResponse =
                                      await VehicleService.getVehicleTypePark(
                                          parkUser.id_park);
                                  List<VehicleTypeParkModel>
                                      vehicleTypeParkModelList =
                                      vehicleTypeParkResponse.data;
                                  for (int i = 0;
                                      i < vehicleTypeParkModelList.length;
                                      i++) {
                                    VehicleTypeParkModel vehicleTypeParkModel =
                                        vehicleTypeParkModelList[i];
                                    VehicleTypeParkDao vehicleTypeParkDao =
                                        new VehicleTypeParkDao();
                                    int idPark =
                                        int.parse(vehicleTypeParkModel.id);
                                    bool ok = await vehicleTypeParkDao
                                        .verifyVehicleTypeParkOffModelById(
                                            idPark);
                                    if (!ok) {
                                      int id =
                                          int.parse(vehicleTypeParkModel.id);
                                      int id_vehicle_type = int.parse(
                                          vehicleTypeParkModel.id_vehicle_type);
                                      int id_park = int.parse(
                                          vehicleTypeParkModel.id_park);
                                      int status = int.parse(
                                          vehicleTypeParkModel.status);
                                      int sort_order = int.parse(
                                          vehicleTypeParkModel.sort_order);
                                      VehicleTypeParkOffModel
                                          vehicleTypeParkOffModel =
                                          new VehicleTypeParkOffModel(
                                              id,
                                              id_vehicle_type,
                                              id_park,
                                              status,
                                              sort_order);
                                      vehicleTypeParkDao.saveVehicleType(
                                          vehicleTypeParkOffModel);
                                    }
                                  }

                                  ParkServiceAdditionalResponse
                                      parkServiceAdditionalRes =
                                      await ParkService
                                          .getParkServiceAdditional(
                                              parkUser.id_park);
                                  List<ParkServiceAdditional>
                                      parkServiceAdditionalList =
                                      parkServiceAdditionalRes.data;

                                  for (int i = 0;
                                      i < parkServiceAdditionalList.length;
                                      i++) {
                                    ParkServiceAdditional parkServ =
                                        parkServiceAdditionalList[i];

                                    int id = int.parse(parkServ.id);
                                    int id_service_additional = int.parse(
                                        parkServ.id_service_additional);
                                    int id_park = int.parse(parkServ.id_park);
                                    double price = double.parse(parkServ.price);
                                    String tolerance = parkServ.tolerance;
                                    int sort_order =
                                        int.parse(parkServ.sort_order);
                                    int status = int.parse(parkServ.status);
                                    String date_edited = parkServ.date_edited;

                                    ParkServiceAdditionalDao parkServDao =
                                        ParkServiceAdditionalDao();

                                    bool ok = await parkServDao
                                        .verifyParkServiceAdditional(id);

                                    if (!ok) {
                                      ParkServiceAdditionalOffModel
                                          parkServOff =
                                          ParkServiceAdditionalOffModel(
                                              id,
                                              id_service_additional,
                                              id_park,
                                              price,
                                              tolerance,
                                              sort_order,
                                              status,
                                              date_edited);

                                      int id_servic = await parkServDao
                                          .saveParkServiceAdditional(
                                              parkServOff);

                                    }
                                  }
                                }
                              }
                            }
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeViewRoute, (Route<dynamic> route) => false);
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            throw new Exception("Email ou Senha Invalido");
                          }
                        }
                      } catch (e) {
                        DateTime now = DateTime.now();
                        LogOff logOff = LogOff('0', null, null, e.toString(), vers, now.toString(), 'LOGIN - ERRO AO FAZER LOGIN', 'APP');
                        LogDao logDao = LogDao();
                        logDao.saveLog(logOff);

                        setState(() {
                          isLoading = false;
                        });
                        alertModals(context, 'Error', e.toString());
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Text('Sobre',style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 18
                        ),),
                        onTap: (){
                          Navigator.of(context).pushNamed(AboutPageViewRoute);
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

alertModals(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          LoginViewRoute, (Route<dynamic> route) => false);
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

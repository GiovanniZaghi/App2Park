import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormNoValidate.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormValidate.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park/ParkDao.dart';
import 'package:app2park/db/dao/park/park_user_dao.dart';
import 'package:app2park/db/dao/park_service_additional_dao.dart';
import 'package:app2park/db/dao/payment/payment_method_park_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_item_base_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_item_dao.dart';
import 'package:app2park/db/dao/ticket_historic_status_dao.dart';
import 'package:app2park/db/dao/user/user_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_park_dao.dart';
import 'package:app2park/module/config/ParkResponse.dart';
import 'package:app2park/module/config/VehicleResponse.dart';
import 'package:app2park/module/config/get_parkuser_response.dart';
import 'package:app2park/module/config/park_service_additional_response.dart';
import 'package:app2park/module/config/payment_method_park_response.dart';
import 'package:app2park/module/config/price_detached_item_response.dart';
import 'package:app2park/module/config/price_detached_response.dart';
import 'package:app2park/module/config/price_item_base_response.dart';
import 'package:app2park/module/config/ticket_historic_status_response.dart';
import 'package:app2park/module/config/user_list_response.dart';
import 'package:app2park/module/config/vehicle_type_park_response.dart';
import 'package:app2park/module/config/vehicle_type_response.dart';
import 'package:app2park/module/park/cep/Cep.dart';
import 'package:app2park/module/park/cep/services/CepService.dart';
import 'package:app2park/module/park/parkjwt/ParkJwt.dart';
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
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/ParkOff.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_park_off_model.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_off_model.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_park_off_model.dart';
import 'package:app2park/moduleoff/park_service_additional_off_model.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_model.dart';
import 'package:app2park/moduleoff/payment/priceitem/price_detached_item_off_model.dart';
import 'package:app2park/moduleoff/payment/priceitembase/price_detached_item_base_off_model.dart';
import 'package:app2park/moduleoff/puser/park_user_off_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_status_off_model.dart';
import 'package:app2park/moduleoff/user/user_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class RegisterStreetParkArguments {
  String name_park;
  String type;
  String business_name;
  String cell;
  String doc;
  String vagas;

  RegisterStreetParkArguments(this.name_park, this.type, this.business_name,
      this.cell, this.doc, this.vagas);
}

class RegisterStreetPark extends StatefulWidget {
  final String name_park;
  final String type;
  final String business_name;
  final String cell;
  final String doc;
  final String vagas;

  const RegisterStreetPark(
      {Key key,
      this.name_park,
      this.type,
      this.business_name,
      this.cell,
      this.doc,
      this.vagas})
      : super(key: key);

  @override
  _RegisterStreetParkState createState() => _RegisterStreetParkState();
}

class _RegisterStreetParkState extends State<RegisterStreetPark> {
  final _formKey = GlobalKey<FormState>();
  final _postalCode = MaskedTextController(mask: '00000-000');
  final _street = new TextEditingController();
  final _number = MaskedTextController(mask: '00000');
  final _city = new TextEditingController();
  final _state = new TextEditingController();
  final _country = new TextEditingController();
  final _complement = new TextEditingController();
  final _bairro = new TextEditingController();

  bool _validateStreet = false;
  bool _validateNumber = false;
  bool _validateCEP = false;
  bool _validateCity = false;
  bool _validateState = false;
  bool _validateCountry = false;
  bool _validateBairro = false;
  bool _validateComple = false;
  bool active = false;
  bool isLoading = false;

  String rua = '';
  String cidade = '';
  String uf = '';

  User userLoad = User();
  SharedPref sharedPref = SharedPref();
  Cep cep = Cep();
  String jwt = '';

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sharedPref.read("user"));
      setState(() {
        userLoad = user;
      });

      String jwts = await sharedPref.read("jwt");
      setState(() {
        jwt = jwts;
      });
    } catch (Excepetion) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Endereço do Estacionamento",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return isLoading
        ? isLoadingPage()
        : AbsorbPointer(
            absorbing: active,
            child: Center(
              child: Container(
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'CEP : ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: _postalCode,
                                onChanged: (value) async {
                                  if (value.length > 7) {
                                    cep = await CepService.getCEP(
                                        _postalCode.text);
                                    setState(() {
                                      _city.text = cep.localidade;
                                      _street.text = cep.logradouro;
                                      _state.text = cep.uf;
                                      _bairro.text = cep.bairro;
                                      _country.text = "Brasil";
                                    });
                                  }
                                },
                                style: TextStyle(fontSize: 18),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Digite o CEP',
                                  errorText:
                                      _validateCEP ? 'Digite um CEP' : null,
                                  suffixIcon: Icon(Icons.search),
                                ),
                              ),
                              Container(
                                height: 30,
                              ),
                              Text(
                                'Rua : ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: _street,
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: 'Digite o endereço',
                                  errorText: _validateStreet
                                      ? 'Digite um endereço'
                                      : null,
                                  suffixIcon: Icon(Icons.location_on),
                                ),
                              ),
                              Container(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Numero : ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(' '),
                                  Text(
                                    'Complemento : ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(''),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: _number,
                                      style: TextStyle(fontSize: 18),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Digite o numero',
                                        errorText: _validateNumber
                                            ? 'Digite um numero'
                                            : null,
                                        suffixIcon: Icon(Icons.location_on),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _complement,
                                      style: TextStyle(fontSize: 18),
                                      decoration: InputDecoration(
                                        hintText: 'Digite o complemento',
                                        errorText: _validateComple
                                            ? 'Digite um complemento'
                                            : null,
                                        suffixIcon: Icon(Icons.location_on),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Cidade : ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Bairro : ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(''),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: _city,
                                      style: TextStyle(fontSize: 18),
                                      decoration: InputDecoration(
                                        hintText: 'Digite a cidade',
                                        errorText: _validateCity
                                            ? 'Digite uma cidade'
                                            : null,
                                        suffixIcon: Icon(Icons.location_on),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _bairro,
                                      style: TextStyle(fontSize: 18),
                                      decoration: InputDecoration(
                                        hintText: 'Digite o bairro',
                                        errorText: _validateBairro
                                            ? 'Digite um bairro'
                                            : null,
                                        suffixIcon: Icon(Icons.location_on),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                              ),
                              Text(
                                'UF : ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: _state,
                                maxLength: 2,
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(

                                  hintText: 'Digite o estado',
                                  errorText: _validateState
                                      ? 'Digite um estado'
                                      : null,
                                  suffixIcon: Icon(Icons.location_on),
                                ),
                              ),
                              Container(
                                height: 30,
                              ),
                              Text(
                                'Pais : ',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: _country,
                                style: TextStyle(fontSize: 18),
                                decoration: InputDecoration(
                                  hintText: 'Digite o Pais',
                                  errorText: _validateCountry
                                      ? 'Digite um Pais'
                                      : null,
                                  suffixIcon: Icon(Icons.location_on),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                child: ButtonApp2Park(
                                  text: "Continuar",
                                  onPressed: () {
                                    _registerPark(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          );
  }

  _registerPark(BuildContext context) async {
    try {
      setState(() {
        active = true;
        isLoading = true;
      });
      if (_formKey.currentState.validate()) {
        if(_postalCode.text.isEmpty){
          setState(() {
            _postalCode.text.isEmpty
                ? _validateCEP = true
                : _validateCEP = false;
            _number.text.isEmpty
                ? _validateNumber = true
                : _validateNumber = false;
            _city.text.isEmpty
                ? _validateCity = true
                : _validateCity = false;
            _state.text.isEmpty
                ? _validateState = true
                : _validateState = false;
             _country.text.isEmpty
                 ? _validateCountry = true
                 : _validateCountry = false;
             _bairro.text.isEmpty
                 ? _validateBairro = true
                 : _validateBairro = false;
          });
        }else if(_street.text.isEmpty){
          setState(() {
            _postalCode.text.isEmpty
                ? _validateCEP = true
                : _validateCEP = false;
            _street.text.isEmpty
                ? _validateStreet = true
                : _validateStreet = false;
            _number.text.isEmpty
                ? _validateNumber = true
                : _validateNumber = false;
            _city.text.isEmpty
                ? _validateCity = true
                : _validateCity = false;
            _state.text.isEmpty
                ? _validateState = true
                : _validateState = false;
            _country.text.isEmpty
                ? _validateCountry = true
                : _validateCountry = false;
            _bairro.text.isEmpty
                ? _validateBairro = true
                : _validateBairro = false;
          });
        }else if(_number.text.isEmpty){
          setState(() {
            _postalCode.text.isEmpty
                ? _validateCEP = true
                : _validateCEP = false;
            _number.text.isEmpty
                ? _validateNumber = true
                : _validateNumber = false;
            _city.text.isEmpty
                ? _validateCity = true
                : _validateCity = false;
            _state.text.isEmpty
                ? _validateState = true
                : _validateState = false;
            _country.text.isEmpty
                ? _validateCountry = true
                : _validateCountry = false;
            _bairro.text.isEmpty
                ? _validateBairro = true
                : _validateBairro = false;
          });
        }else if(_city.text.isEmpty){
          setState(() {
            _postalCode.text.isEmpty
                ? _validateCEP = true
                : _validateCEP = false;
            _number.text.isEmpty
                ? _validateNumber = true
                : _validateNumber = false;
            _city.text.isEmpty
                ? _validateCity = true
                : _validateCity = false;
            _state.text.isEmpty
                ? _validateState = true
                : _validateState = false;
            _country.text.isEmpty
                ? _validateCountry = true
                : _validateCountry = false;
            _bairro.text.isEmpty
                ? _validateBairro = true
                : _validateBairro = false;
          });
        }else if(_state.text.isEmpty){
          setState(() {
            _postalCode.text.isEmpty
                ? _validateCEP = true
                : _validateCEP = false;
            _number.text.isEmpty
                ? _validateNumber = true
                : _validateNumber = false;
            _city.text.isEmpty
                ? _validateCity = true
                : _validateCity = false;
            _state.text.isEmpty
                ? _validateState = true
                : _validateState = false;
            _country.text.isEmpty
                ? _validateCountry = true
                : _validateCountry = false;
            _bairro.text.isEmpty
                ? _validateBairro = true
                : _validateBairro = false;
          });
        }else if(_country.text.isEmpty){
          setState(() {
            _postalCode.text.isEmpty
                ? _validateCEP = true
                : _validateCEP = false;
            _number.text.isEmpty
                ? _validateNumber = true
                : _validateNumber = false;
            _city.text.isEmpty
                ? _validateCity = true
                : _validateCity = false;
            _state.text.isEmpty
                ? _validateState = true
                : _validateState = false;
            _country.text.isEmpty
                ? _validateCountry = true
                : _validateCountry = false;
            _bairro.text.isEmpty
                ? _validateBairro = true
                : _validateBairro = false;
          });
        }else if(_bairro.text.isEmpty){
          setState(() {
            _postalCode.text.isEmpty
                ? _validateCEP = true
                : _validateCEP = false;
            _number.text.isEmpty
                ? _validateNumber = true
                : _validateNumber = false;
            _city.text.isEmpty
                ? _validateCity = true
                : _validateCity = false;
            _state.text.isEmpty
                ? _validateState = true
                : _validateState = false;
            _country.text.isEmpty
                ? _validateCountry = true
                : _validateCountry = false;
            _bairro.text.isEmpty
                ? _validateBairro = true
                : _validateBairro = false;
          });
        }

        ParkJwt park = ParkJwt();
        park.name_park = widget.name_park;
        park.type = widget.type;
        park.doc = widget.doc;
        park.business_name = widget.business_name;
        park.cell = widget.cell;
        park.postal_code = _postalCode.text;
        park.street = _street.text;
        park.number = _number.text;
        park.complement = _complement.text == '' ? null : _complement.text;
        park.neighborhood = _bairro.text;
        park.city = _city.text;
        park.state = _state.text.toUpperCase();
        park.country = _country.text;
        park.vacancy = widget.vagas;
        park.jwt = jwt;
        park.id_user = userLoad.id ?? '1';

        ParkResponse r = await ParkService.save(park);

        if (r.status == 'COMPLETED') {
          if (r.data != null) {
            ParkDao dao = ParkDao();

            ParkOff p = new ParkOff(
              r.data.id,
              r.data.type,
              r.data.doc,
              r.data.name_park,
              r.data.business_name,
              r.data.cell,
              r.data.photo,
              r.data.postal_code,
              r.data.street,
              r.data.number,
              r.data.complement,
              r.data.neighborhood,
              r.data.city,
              r.data.state,
              r.data.country,
              r.data.vacancy,
              r.data.subscription,
              r.data.id_status,
              r.data.date_added,
              r.data.date_edited,
            );

            int id_park_off = await dao.savePark(p);

            ParkUser parkUser10 = ParkUser();
            parkUser10.id_park = r.data.id;
            UserListResponse userListRes =
            await ParkService.sincUserParkUserByIdPark(parkUser10);

            if (userListRes.status == 'COMPLETED') {
              if (userListRes.data != null) {
                UserDao userDao = UserDao();

                List<User> listUser = userListRes.data;

                for (int i = 0; i < listUser.length; i++) {
                  User user = listUser[i];

                  bool ok = await userDao.verifyUser(int.tryParse(user.id));

                  if (!ok) {
                    UserOff userOff = UserOff(
                        user.id,
                        user.first_name,
                        user.last_name,
                        user.cell,
                        user.doc,
                        user.email,
                        user.pass,
                        user.id_status);

                    userDao.saveUser(userOff);
                  }
                }
              }
            }

            GetParkUserResponse getParkUserRes =
            await ParkUserService.getallPuser(r.data.id);

            if (getParkUserRes.status == 'COMPLETED') {
              if (getParkUserRes.data != null) {
                ParkUserDao parkUserDao = ParkUserDao();

                List<ParkUser> listParkUser = getParkUserRes.data;

                for (int i = 0; i < listParkUser.length; i++) {
                  ParkUser parkUser = listParkUser[i];

                  bool ok =
                  await parkUserDao.verifyPuser(int.tryParse(parkUser.id));

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

            VehicleTypeResponse vehicleTypeResponse =
            await VehicleService.getVehicleType();

            if (vehicleTypeResponse.status == 'COMPLETED') {
              if (vehicleTypeResponse.data != null) {
                List<VehicleTypeModel> vehicleTypeModelList =
                    vehicleTypeResponse.data;
                for (int i = 0; i < vehicleTypeModelList.length; i++) {
                  VehicleTypeModel vehicleTypeModel = vehicleTypeModelList[i];
                  VehicleTypeDao vehicleTypeDao = new VehicleTypeDao();
                  int verify = int.parse(vehicleTypeModel.id);
                  bool ok = await vehicleTypeDao
                      .verifyVehicleTypeOffModelById(verify);
                  if (!ok) {
                    int id = int.parse(vehicleTypeModel.id);
                    String type = vehicleTypeModel.type;
                    VehicleTypeOffModel vehicleTypeOffModel =
                    new VehicleTypeOffModel(id, type);
                    vehicleTypeDao.saveVehicleTypeOffModel(vehicleTypeOffModel);
                  }
                }
              }
            }

            PriceItemBaseResponse priceItemBaseResponse =
            await PriceService.getAllPriceItemBase();

            if (priceItemBaseResponse.status == 'COMPLETED') {
              if (priceItemBaseResponse.data != null) {
                List<PriceDetachedBase> priceItemBaseModelList =
                    priceItemBaseResponse.data;
                for (int i = 0; i < priceItemBaseModelList.length; i++) {
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
                    int idStatus = int.parse(priceDetachedBase.id_status);
                    PriceDetachedItemBaseOff priceItemOff =
                    PriceDetachedItemBaseOff(
                        id, name, time, type, level, idStatus);
                    priceDetachedItemDao.savePriceDetachedItem(priceItemOff);
                  }
                }
              }
            }

            TicketHistoricStatusResponse ticketHistoricStatusResponse =
            await TicketService.getTicketHistoricStatus();
            if (ticketHistoricStatusResponse.status == "COMPLETED") {
              if (ticketHistoricStatusResponse.data != null) {
                List<TicketHistoricStatusModel> ticketHistoricStatusList =
                    ticketHistoricStatusResponse.data;
                for (int i = 0; i < ticketHistoricStatusList.length; i++) {
                  TicketHistoricStatusModel ticketHistoricStatus =
                  ticketHistoricStatusList[i];
                  TicketHistoricStatusDao ticketHistoricStatusDao =
                  TicketHistoricStatusDao();
                  int id = int.parse(ticketHistoricStatus.id);
                  String name = ticketHistoricStatus.name;
                  bool ok = await ticketHistoricStatusDao
                      .verifyTicketHistoricStatus(id);
                  if (!ok) {
                    TicketHistoricStatusOffModel ticketHistoricStatusOffModel =
                    TicketHistoricStatusOffModel(id, name);
                    ticketHistoricStatusDao
                        .saveTicketHistoricStatus(ticketHistoricStatusOffModel);
                  }
                }
              }
            }

            VehicleTypeParkResponse vehicleTypeParkResponse =
            await VehicleService.getVehicleTypePark(r.data.id);

            if (vehicleTypeParkResponse.status == 'COMPLETED') {
              if (vehicleTypeParkResponse.data != null) {
                List<VehicleTypeParkModel> vehicleTypeParkModelList =
                    vehicleTypeParkResponse.data;
                for (int i = 0; i < vehicleTypeParkModelList.length; i++) {
                  VehicleTypeParkModel vehicleTypeParkModel =
                  vehicleTypeParkModelList[i];
                  VehicleTypeParkDao vehicleTypeParkDao =
                  new VehicleTypeParkDao();
                  int idPark = int.parse(vehicleTypeParkModel.id);
                  bool ok = await vehicleTypeParkDao
                      .verifyVehicleTypeParkOffModelById(idPark);
                  if (!ok) {
                    int id = int.parse(vehicleTypeParkModel.id);
                    int id_vehicle_type =
                    int.parse(vehicleTypeParkModel.id_vehicle_type);
                    int id_park = int.parse(vehicleTypeParkModel.id_park);
                    int status = int.parse(vehicleTypeParkModel.status);
                    int sort_order = int.parse(vehicleTypeParkModel.sort_order);
                    VehicleTypeParkOffModel vehicleTypeParkOffModel =
                    new VehicleTypeParkOffModel(
                        id, id_vehicle_type, id_park, status, sort_order);
                    vehicleTypeParkDao.saveVehicleType(vehicleTypeParkOffModel);
                  }
                }
              }
            }

            PriceDetachedResponse priceDetachedRes =
            await PriceService.getAllPricesDetachedByPark(r.data.id);

            if (priceDetachedRes.status == 'COMPLETED') {
              if (priceDetachedRes.data != null) {
                List<PriceDetached> priceDetachedList = priceDetachedRes.data;
                PriceDetachedDao priceDetachedDao = PriceDetachedDao();
                PriceDetachedItemDao priceDetachedItemDao =
                PriceDetachedItemDao();

                for (int i = 0; i < priceDetachedList.length; i++) {
                  PriceDetached priceDetached = priceDetachedList[i];

                  bool ok = await priceDetachedDao
                      .verifyPriceDetached(int.tryParse(priceDetached.id));

                  if (!ok) {
                    PriceDetachedOff priceDetachedOff = PriceDetachedOff(
                        int.tryParse(priceDetached.id),
                        int.tryParse(priceDetached.id_park),
                        priceDetached.name,
                        priceDetached.daily_start,
                        int.tryParse(priceDetached.id_vehicle_type),
                        int.tryParse(priceDetached.id_status),
                        1,
                        int.tryParse(priceDetached.sort_order),
                        priceDetached.data_sinc);

                    int id_price_detached_app = await priceDetachedDao
                        .savePriceDetached(priceDetachedOff);


                    PriceDetached priceD = PriceDetached();
                    priceD.id_price_detached_app =
                        id_price_detached_app.toString();

                    PriceDetachedResponse priceDRes =
                    await PriceService.updatePriceDetached(
                        priceDetached.id, priceD);


                    PriceDetachedItemResponse priceDetachedItemRes =
                    await PriceService.getAllPricesDetachedByIdDetached(
                        priceDetached.id);

                    if (priceDetachedItemRes.status == 'COMPLETED') {
                      if (priceDetachedItemRes.data != null) {
                        List<PriceDetachedItem> priceDetachedItemList =
                            priceDetachedItemRes.data;

                        for (int i = 0; i < priceDetachedItemList.length; i++) {
                          PriceDetachedItem priceDetachedItem =
                          priceDetachedItemList[i];

                          bool ok = await priceDetachedItemDao
                              .verifyPriceDetachedItem(
                              int.tryParse(priceDetachedItem.id));

                          if (!ok) {
                            PriceDetachedItemOff priceDetachedItemOff =
                            PriceDetachedItemOff(
                                int.tryParse(priceDetachedItem.id),
                                int.tryParse(
                                    priceDetachedItem.id_price_detached),
                                id_price_detached_app,
                                int.tryParse(priceDetachedItem
                                    .id_price_detached_item_base),
                                double.parse(priceDetachedItem.price),
                                priceDetachedItem.tolerance);

                            int id_price_detached_item_off =
                            await priceDetachedItemDao
                                .savePriceDetachedItem(
                                priceDetachedItemOff);


                            PriceDetachedItem priceDI = PriceDetachedItem();
                            priceDI.id_price_detached_item_app =
                                id_price_detached_item_off.toString();

                            PriceDetachedItemResponse priceDIRes =
                            await PriceService.updatePriceDetachedItem(
                                priceDetachedItem.id, priceDI);

                          }
                        }
                      }
                    }
                  }
                }
              }
            }

            PaymentMethodParkResponse paymentMethodParkResponse =
            await PaymentService.getPaymentMethodPark(r.data.id);

            if (paymentMethodParkResponse.status == 'COMPLETED') {
              if (paymentMethodParkResponse.data != null) {
                List<PaymentMethodParkModel> paymentMethodParkModelList =
                    paymentMethodParkResponse.data;
                for (int i = 0; i < paymentMethodParkModelList.length; i++) {
                  PaymentMethodParkModel paymentMethodParkModel =
                  paymentMethodParkModelList[i];
                  PaymentMethodParkDao paymentMethodParkDao =
                  new PaymentMethodParkDao();
                  int id = int.parse(paymentMethodParkModel.id);
                  int id_park = int.parse(paymentMethodParkModel.id_park);
                  int id_payment_method =
                  int.parse(paymentMethodParkModel.id_payment_method);
                  double flat_rate =
                  double.parse(paymentMethodParkModel.flat_rate);
                  double variable_rate =
                  double.parse(paymentMethodParkModel.variable_rate);
                  double min_value =
                  double.parse(paymentMethodParkModel.min_value);
                  int status = int.parse(paymentMethodParkModel.status);
                  int sort_order = int.parse(paymentMethodParkModel.sort_order);
                  bool ok =
                  await paymentMethodParkDao.verifyPaymentMethodPark(id);
                  if (!ok) {
                    PaymentMethodParkOffModel paymentMethodParkOffModel =
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
                        .savePaymentMethodPark(paymentMethodParkOffModel);
                  }

                  VehicleTypeParkResponse vehicleTypeParkResponse =
                  await VehicleService.getVehicleTypePark(r.data.id);

                  if (vehicleTypeParkResponse.status == 'COMPLETED') {
                    if (vehicleTypeParkResponse.data != null) {
                      List<VehicleTypeParkModel> vehicleTypeParkModelList =
                          vehicleTypeParkResponse.data;
                      for (int i = 0;
                      i < vehicleTypeParkModelList.length;
                      i++) {
                        VehicleTypeParkModel vehicleTypeParkModel =
                        vehicleTypeParkModelList[i];
                        VehicleTypeParkDao vehicleTypeParkDao =
                        new VehicleTypeParkDao();
                        int idPark = int.parse(vehicleTypeParkModel.id);
                        bool ok = await vehicleTypeParkDao
                            .verifyVehicleTypeParkOffModelById(idPark);
                        if (!ok) {
                          int id = int.parse(vehicleTypeParkModel.id);
                          int id_vehicle_type =
                          int.parse(vehicleTypeParkModel.id_vehicle_type);
                          int id_park = int.parse(vehicleTypeParkModel.id_park);
                          int status = int.parse(vehicleTypeParkModel.status);
                          int sort_order =
                          int.parse(vehicleTypeParkModel.sort_order);
                          VehicleTypeParkOffModel vehicleTypeParkOffModel =
                          new VehicleTypeParkOffModel(id, id_vehicle_type,
                              id_park, status, sort_order);
                          vehicleTypeParkDao
                              .saveVehicleType(vehicleTypeParkOffModel);
                        }
                      }
                    }
                  }

                  ParkServiceAdditionalResponse parkServiceAdditionalRes =
                  await ParkService.getParkServiceAdditional(r.data.id);

                  if (parkServiceAdditionalRes.status == 'COMPLETED') {
                    if (parkServiceAdditionalRes.data != null) {
                      List<ParkServiceAdditional> parkServiceAdditionalList =
                          parkServiceAdditionalRes.data;

                      for (int i = 0;
                      i < parkServiceAdditionalList.length;
                      i++) {
                        ParkServiceAdditional parkServ =
                        parkServiceAdditionalList[i];

                        int id = int.parse(parkServ.id);
                        int id_service_additional =
                        int.parse(parkServ.id_service_additional);
                        int id_park = int.parse(parkServ.id_park);
                        double price = double.parse(parkServ.price);
                        String tolerance = parkServ.tolerance;
                        int sort_order = int.parse(parkServ.sort_order);
                        int status = int.parse(parkServ.status);
                        String date_edited = parkServ.date_edited;

                        ParkServiceAdditionalDao parkServDao =
                        ParkServiceAdditionalDao();

                        bool ok =
                        await parkServDao.verifyParkServiceAdditional(id);

                        if (!ok) {
                          ParkServiceAdditionalOffModel parkServOff =
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
                              .saveParkServiceAdditional(parkServOff);

                        }
                      }
                    }
                  }

                  GetParkUserResponse getRes =
                  await ParkUserService.getallPuser(r.data.id);

                  if (getRes.status == 'COMPLETED') {
                    if (getRes.data != null) {
                      List<ParkUser> parkUserList = getRes.data;
                      for (int i = 0; i < parkUserList.length; i++) {
                        ParkUser parkUser = parkUserList[i];
                        ParkUserDao parkUserDao = ParkUserDao();
                        int id = int.parse(parkUser.id);
                        int id_park = int.parse(parkUser.id_park);
                        int id_user = int.parse(parkUser.id_user);
                        int id_office = int.parse(parkUser.id_office);
                        int id_status = int.parse(parkUser.id_status);
                        String keyval = parkUser.keyval;
                        String date_added = parkUser.date_added;
                        String date_edited = parkUser.date_edited;

                        bool ok = await parkUserDao.verifyPuser(id);
                        if (!ok) {
                          ParkUserOff parkUserOff = ParkUserOff(
                              id,
                              id_park,
                              id_user,
                              id_office,
                              id_status,
                              keyval,
                              date_added,
                              date_edited);
                          parkUserDao.saveParkUser(parkUserOff);
                        }
                      }
                    }
                  }
                }
              }
            }
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeViewRoute, (Route<dynamic> route) => false);
          }
        } else {
          throw new Exception('Erro: ' + r.message);
        }
      } else {
        throw new Exception('Por favor, digite os dados corretamente');
      }
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO REGISTER STREET PARK', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
      setState(() {
        active = false;
        isLoading = false;
      });
      alertModal(context, "Error Register", e.toString());

    }
  }
}

import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/views/park/price/price_store.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_item_base_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_item_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_dao.dart';
import 'package:app2park/module/config/price_detached_item_response.dart';
import 'package:app2park/module/config/price_detached_response.dart';
import 'package:app2park/module/config/simple_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/payment/price/price_detached_model.dart';
import 'package:app2park/module/payment/priceitem/price_detached_item_model.dart';
import 'package:app2park/module/payment/service/price_service.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_off_model.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_model.dart';
import 'package:app2park/moduleoff/payment/price_item_inner_join_item_base.dart';
import 'package:app2park/moduleoff/payment/price_item_inner_join_vehicles.dart';
import 'package:app2park/moduleoff/payment/priceitem/price_detached_item_off_model.dart';
import 'package:app2park/moduleoff/payment/priceitembase/price_detached_item_base_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TableCarEditPage extends StatefulWidget {
  @override
  _TableCarEditPageState createState() => _TableCarEditPageState();
}

class _TableCarEditPageState extends State<TableCarEditPage> {
  SharedPref sharedPref = SharedPref();
  bool sim = false;
  bool nao = false;
  int cash = 2;
  final _name = new TextEditingController();
  final _daily_start = new TextEditingController();
  final _price = MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',', precision: 2);
  final _ordem = new TextEditingController();
  final _tolerance = new TextEditingController();
  bool hab = true;
  bool desa = false;
  bool tickado = false;
  String type = "";
  int id_status;
  int id_price_detached = 0;
  PriceItemInnerJoinVehicles priceItemJoinVehiclesmodel;
  VehicleTypeDao vehicleDao = VehicleTypeDao();
  String dates =
  DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();

  List<VehicleTypeOffModel> _dropdownItems = [];

  List<DropdownMenuItem<VehicleTypeOffModel>> _dropdownMenuItems;
  VehicleTypeOffModel _selectedItem;

  int id_park = 0;
  Park park = Park();
  var year = new DateTime.now();
  String _time = "Tolerancia";
  String _tempo = "2020-10-13 00:00:00";
  PriceDetachedDao priceDetachedDao = PriceDetachedDao();
  PriceDetachedItemDao priceDetachedItemDao = PriceDetachedItemDao();
  String ordem = '';
  String hint = '';
  bool autofocus = false;

  FocusNode _focusNode = FocusNode();
  Color color;

  bool _validateName = false;
  bool _validateDaily = false;
  bool _validateOrder = false;

  bool isLoading = false;
  int id_type = 0;
  int tipo = 0;

  PriceStore prices = PriceStore();

  bool vazio = false;

  @override
  void initState() {
    // TODO: implement initState
    loadSharedPrefs();
    super.initState();
  }

  loadSharedPrefs() async {
    try {
      List<VehicleTypeOffModel> listType =
          await vehicleDao.findAllVehicleTypeModelOff();
      for (int i = 0; i < listType.length; i++) {
        VehicleTypeOffModel vehicleType = listType[i];
        _dropdownItems.add(vehicleType);
      }

      Park pa = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        park = pa;
        id_park = int.parse(pa.id);
        ordem = '1';
        _ordem.text = ordem;
      });
      Park ps = Park.fromJson(await sharedPref.read("park"));
      PriceItemInnerJoinVehicles p = PriceItemInnerJoinVehicles.fromJson(
          await sharedPref.read("priceedit"));
      setState(() {
        priceItemJoinVehiclesmodel = p;
        id_type = p.id_vehicle_type - 1;
        if (p == null) {
        } else {
          id_price_detached = p.id_price_detached_app;
        }
        if (p.id_price_detached_app != null) {
          _name.text = p.name;
          _tempo = '2020-10-13 ' + p.daily_start;
          _daily_start.text = p.daily_start;
          sim = p.cash == 1 ? true : false;
          nao = p.cash == 2 ? true : false;
          hab = p.id_status == 1 ? true : false;
          desa = p.id_status == 0 ? true : false;
          _ordem.text = p.sort_order.toString();
        }

      });
      _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
      _selectedItem = _dropdownMenuItems[id_type].value;
      prices.getPricesItemInnerJoinBase(id_price_detached);
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO PRICE DETACHED EDIT PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  abrirUrl() async {
    const url = 'https://www.youtube.com/channel/UCFRXE1XmZobWIjFoh6VuIAA/playlists';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<DropdownMenuItem<VehicleTypeOffModel>> buildDropDownMenuItems(
      List listItems) {
    List<DropdownMenuItem<VehicleTypeOffModel>> items = List();
    for (VehicleTypeOffModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(
            listItem.type,
            style: TextStyle(fontSize: 22),
          ),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(() {
      setState(() {
        color = _focusNode.hasFocus ? Colors.black : Colors.red;
      });
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tabela de preços'),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Resumo",
                icon: Icon(
                  Icons.assignment,
                ),
              ),
              Tab(
                text: "Configurações",
                icon: Icon(
                  Icons.settings,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[_body(context), _config(context)],
        ),
      ),
    );
  }

  Future<Null> _refreshLocalGallery() async {
  }

  _body(BuildContext context) {
    return isLoading
        ? isLoadingPage()
        : RefreshIndicator(
            onRefresh: _refreshLocalGallery,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      Text(
                        'Tabela de Preço para clientes avulsos e convênios com restaurantes, bares, bancos, etc.',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Nome da Tabela : ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        maxLength: 25,
                        decoration: InputDecoration(
                          hintText: 'Digite um nome para tabela',
                          errorText: _validateName
                              ? 'Digite um nome para tabela'
                              : null,
                          labelStyle: TextStyle(
                            fontSize: 22,
                            color: _focusNode.hasFocus
                                ? Colors.blue
                                : Colors.black,
                          ),
                          suffixIcon: Icon(Icons.content_paste),
                        ),
                        controller: _name,
                        autofocus: autofocus,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text('Apenas para hotéis e pousadas!!!'),
                      Text('Digite a data de início da diária : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 4.0,
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true, onConfirm: (time) {
                            var dateFormat =
                                new DateFormat('yyyy-MM-dd HH:mm:ss');
                            _tempo = dateFormat.format(time);
                            _daily_start.text = _tempo;
                            setState(() {});
                          },
                              currentTime: DateTime.parse(_tempo),
                              locale: LocaleType.pt);
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.access_time,
                                          size: 18.0,
                                          color: Colors.teal,
                                        ),
                                        Text(
                                          " ${_tempo.substring(11, 19)}",
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "Escolher",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Tipo de Veículo :  ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            child: DropdownButton(
                                value: _selectedItem,
                                items: _dropdownMenuItems,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedItem = value;
                                  });
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Deseja Exibir no caixa ? ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              new Checkbox(
                                value: sim,
                                onChanged: (bool value) {
                                  setState(() {
                                    sim = value;
                                    nao = false;
                                  });
                                },
                              ),
                              Text('Sim'),
                              new Checkbox(
                                value: nao,
                                onChanged: (bool value) {
                                  setState(() {
                                    nao = value;
                                    sim = false;
                                  });
                                },
                              ),
                              Text('Não')
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Ordem na tela : ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _ordem,
                              maxLength: 5,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  hintText: "Digite um numero para ordem",
                                  errorText: _validateOrder
                                      ? 'Digite um numero para ordem'
                                      : null,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                  suffixIcon: Icon(Icons.list)),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Status da tabela : ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              new Checkbox(
                                value: hab,
                                onChanged: (bool value) {
                                  setState(() {
                                    hab = value;
                                    desa = false;
                                  });
                                },
                              ),
                              Text('Habilitado'),
                              new Checkbox(
                                value: desa,
                                onChanged: (bool value) {
                                  setState(() {
                                    desa = value;
                                    hab = false;
                                  });
                                },
                              ),
                              Text('Desabilitado')
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Itens da tabela : ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Observer(
                        builder: (_) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: prices.listPriceItemInnerJoinBase.length,
                            itemBuilder: (context, index) {
                              tickado = prices.listPriceItemInnerJoinBase[index]
                                          .tickado ==
                                      1
                                  ? true
                                  : false;
                              if (prices.listPriceItemInnerJoinBase[index]
                                      .price ==
                                  null) {
                                prices.listPriceItemInnerJoinBase[index].price =
                                    0.0;
                              }

                              if (prices.listPriceItemInnerJoinBase[index]
                                      .tolerance ==
                                  null) {
                                prices.listPriceItemInnerJoinBase[index]
                                    .tolerance = '00:00:00';
                              }

                              if (tickado) {
                                return Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () async {
                                              if (prices
                                                      .listPriceItemInnerJoinBase[
                                                          index]
                                                      .price ==
                                                  null) {
                                                _price.updateValue(0.0);
                                              } else {
                                                _price.updateValue(prices
                                                    .listPriceItemInnerJoinBase[
                                                        index]
                                                    .price);
                                              }
                                              modalBottomSheetMenu(
                                                  context, index);
                                              _refreshLocalGallery();
                                            },
                                            child: prices
                                                        .listPriceItemInnerJoinBase[
                                                            index]
                                                        .type ==
                                                    '0'
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: ListTile(
                                                      title: Text(
                                                        '${prices.listPriceItemInnerJoinBase[index].name} ',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      subtitle: Text(
                                                          'Preço: ${NumberFormat.currency(name: '').format(prices.listPriceItemInnerJoinBase[index].price)} ' + '  Tolerancia: ${prices.listPriceItemInnerJoinBase[index].tolerance}'),
                                                    ),
                                                  )
                                                : Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 40.0,
                                                              bottom: 5.0),
                                                      child: Container(
                                                        color: Color.fromRGBO(
                                                            41, 202, 168, 3),
                                                        child: ListTile(
                                                          title: Text(
                                                            '${prices.listPriceItemInnerJoinBase[index].name} ',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          subtitle: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              'Preço: ${NumberFormat.currency(name: '').format(prices.listPriceItemInnerJoinBase[index].price)} ' +
                                                                  '  Tolerancia: ${prices.listPriceItemInnerJoinBase[index].tolerance}',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonApp2Park(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());

                            if(prices.listPriceItemInnerJoinBase.where((element) => element.tickado == 1).length > 0){
                              int id_detached_app;
                              int id_detached;
                              int id_park = int.parse(park.id);
                              if (priceItemJoinVehiclesmodel != null) {
                                id_detached = priceItemJoinVehiclesmodel.id;
                                id_detached_app = priceItemJoinVehiclesmodel
                                    .id_price_detached_app;
                                if (sim && !nao) {
                                  cash = 1;
                                } else {
                                  cash = 2;
                                }
                                int status = hab == true ? 1 : 0;


                                await priceDetachedDao.updatePriceDetached(
                                    id_detached_app,
                                    _name.text,
                                    _daily_start.text,
                                    _selectedItem.id,
                                    status,
                                    cash,
                                    int.parse(_ordem.text),
                                    dates);

                                if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                    connectivityResult ==
                                        ConnectivityResult.wifi) {
                                  PriceDetached priceDetached = PriceDetached();
                                  priceDetached.name = _name.text;
                                  if(_daily_start.text != ''){
                                    priceDetached.daily_start = _daily_start.text;
                                  }
                                  priceDetached.id_vehicle_type =
                                      _selectedItem.id.toString();
                                  priceDetached.id_status = '$status';
                                  if(cash == 2){
                                    priceDetached.cash = "2";
                                  }else {
                                    priceDetached.cash = cash.toString();
                                  }
                                  priceDetached.sort_order = _ordem.text;
                                  priceDetached.data_sinc = dates;


                                  PriceDetachedResponse priceDetachedRes =
                                  await PriceService.updatePriceDetached(
                                      id_detached.toString(), priceDetached);

                                  if (priceDetachedRes.status == 'COMPLETED') {
                                    if (priceDetachedRes.data != null) {
                                      PriceDetached priceDRes =
                                          priceDetachedRes.data.first;

                                      bool ok = await priceDetachedDao
                                          .updatePriceDetachedSinc(
                                          int.tryParse(priceDRes.id),
                                          id_detached_app,
                                          priceDRes.name,
                                          priceDRes.daily_start,
                                          int.tryParse(
                                              priceDRes.id_vehicle_type),
                                          int.tryParse(priceDRes.id_status),
                                          int.tryParse(priceDRes.cash),
                                          int.tryParse(priceDRes.sort_order),
                                          dates);

                                    }
                                  }
                                }
                              } else {
                                if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                    connectivityResult ==
                                        ConnectivityResult.wifi) {
                                  int status = hab == true ? 1 : 0;
                                  PriceDetached priceDetached = PriceDetached();
                                  priceDetached.id_status = '$status';
                                  priceDetached.id_vehicle_type =
                                      _selectedItem.id.toString();
                                  priceDetached.sort_order = _ordem.text;
                                  priceDetached.name = _name.text;
                                  if(_daily_start.text != ''){
                                    priceDetached.daily_start = _daily_start.text;
                                  }
                                  if(cash == 2){
                                    priceDetached.cash = '2';
                                  }else {
                                    priceDetached.cash = cash.toString();
                                  }
                                  priceDetached.data_sinc =
                                      dates;

                                  PriceDetachedResponse priceDetachedRes =
                                  await PriceService.updatePriceDetached(
                                      id_detached.toString(), priceDetached);


                                  if (priceDetachedRes.status == 'COMPLETED') {
                                    if (priceDetachedRes.data != null) {
                                      PriceDetached priceDRes =
                                          priceDetachedRes.data.first;

                                      bool ok = await priceDetachedDao
                                          .updatePriceDetachedSinc(
                                          int.tryParse(priceDRes.id),
                                          id_detached_app,
                                          priceDRes.name,
                                          priceDRes.daily_start,
                                          int.tryParse(
                                              priceDRes.id_vehicle_type),
                                          int.tryParse(priceDRes.id_status),
                                          int.tryParse(priceDRes.cash),
                                          int.tryParse(priceDRes.sort_order),
                                          dates);

                                    }
                                  }
                                }
                              }

                              for (int i = 0;
                              i < prices.listPriceItemInnerJoinBase.length;
                              i++) {
                                double price =
                                    prices.listPriceItemInnerJoinBase[i].price;
                                String tolerance = prices
                                    .listPriceItemInnerJoinBase[i].tolerance;

                                if (tolerance == "") {
                                  tolerance = '00:00:00';
                                }


                                if (prices.listPriceItemInnerJoinBase[i]
                                    .id_price_detached_item_app !=
                                    null) {
                                  if (prices.listPriceItemInnerJoinBase[i]
                                      .tickado ==
                                      1) {
                                    priceDetachedDao.updateDateSincP(
                                        prices.listPriceItemInnerJoinBase[i]
                                            .id_price_detached_item_app,
                                        dates);
                                    priceDetachedItemDao.updatePriceDetachedItem(
                                        prices.listPriceItemInnerJoinBase[i]
                                            .id_price_detached_item_app,
                                        price,
                                        tolerance);

                                    if (connectivityResult ==
                                        ConnectivityResult.mobile ||
                                        connectivityResult ==
                                            ConnectivityResult.wifi) {
                                      List<PriceDetachedItemOff>
                                      priceItemOffList =
                                      await priceDetachedItemDao
                                          .getPriceDetachedItemId(prices
                                          .listPriceItemInnerJoinBase[i]
                                          .id_price_detached_item_app);

                                      PriceDetachedItemOff priceDetachedOff =
                                          priceItemOffList.first;

                                      PriceDetachedItem priceDetachedItem =
                                      PriceDetachedItem();
                                      priceDetachedItem.price = price.toString();
                                      priceDetachedItem.tolerance = tolerance;

                                      PriceDetachedItemResponse
                                      priceDetachedItemRes =
                                      await PriceService
                                          .updatePriceDetachedItem(
                                          priceDetachedOff.id.toString(),
                                          priceDetachedItem);

                                      if (priceDetachedItemRes.status ==
                                          'COMPLETED') {
                                        if (priceDetachedItemRes.data != null) {
                                          PriceDetachedItem priceDetacheIRes =
                                              priceDetachedItemRes.data.first;

                                          bool ok = await priceDetachedItemDao
                                              .updatePriceDetachedItem(
                                              priceDetachedOff
                                                  .id_price_detached_item_app,
                                              double.parse(
                                                  priceDetacheIRes.price),
                                              priceDetacheIRes.tolerance);

                                        }
                                      }
                                    }
                                  } else {
                                    if (connectivityResult ==
                                        ConnectivityResult.mobile ||
                                        connectivityResult ==
                                            ConnectivityResult.wifi) {
                                      List<PriceDetachedItemOff>
                                      priceItemOffList =
                                      await priceDetachedItemDao
                                          .getPriceDetachedItemId(prices
                                          .listPriceItemInnerJoinBase[i]
                                          .id_price_detached_item_app);


                                      PriceDetachedItemOff priceDetachedOff =
                                          priceItemOffList.first;


                                      PriceDetachedItem priceDetaItem =
                                      PriceDetachedItem();
                                      priceDetaItem.id =
                                          priceDetachedOff.id.toString();

                                      SimpleResponse simpleRes =
                                      await PriceService
                                          .deletePriceDetachedItem(
                                          priceDetaItem);

                                      if (simpleRes.status == 'COMPLETED') {
                                      }
                                    }
                                    priceDetachedItemDao.deletePriceDetachedItem(
                                        prices.listPriceItemInnerJoinBase[i]
                                            .id_price_detached_item_app);
                                  }
                                } else {
                                  if (prices.listPriceItemInnerJoinBase[i]
                                      .tickado ==
                                      1) {
                                    int id_price_detached_item;
                                    priceDetachedDao.updateDateSincP(
                                        prices.listPriceItemInnerJoinBase[i]
                                            .id_price_detached_item_app,
                                        dates);
                                    PriceDetachedItemOff priceDetachedOff =
                                    PriceDetachedItemOff(
                                        0,
                                        id_detached,
                                        id_detached_app,
                                        prices
                                            .listPriceItemInnerJoinBase[i].id,
                                        price,
                                        tolerance);
                                    id_price_detached_item =
                                    await priceDetachedItemDao
                                        .savePriceDetachedItem(
                                        priceDetachedOff);

                                    if (connectivityResult ==
                                        ConnectivityResult.mobile ||
                                        connectivityResult ==
                                            ConnectivityResult.wifi) {
                                      PriceDetachedItem priceDetachedItem =
                                      PriceDetachedItem();
                                      priceDetachedItem.id_price_detached =
                                          id_detached.toString();
                                      priceDetachedItem
                                          .id_price_detached_item_app =
                                          id_price_detached_item.toString();
                                      priceDetachedItem
                                          .id_price_detached_item_base =
                                          prices.listPriceItemInnerJoinBase[i].id
                                              .toString();
                                      priceDetachedItem.price = price.toString();
                                      priceDetachedItem.tolerance = tolerance;

                                      PriceDetachedItemResponse
                                      priceDetachedItemres =
                                      await PriceService
                                          .insertPriceDetachedItem(
                                          priceDetachedItem);

                                      if (priceDetachedItemres.status ==
                                          'COMPLETED') {
                                        if (priceDetachedItemres.data != null) {
                                          PriceDetachedItem priceDItem =
                                              priceDetachedItemres.data.first;

                                          bool ok = await priceDetachedItemDao
                                              .updatePriceDetachedItemSinc(
                                              int.tryParse(priceDItem.id),
                                              id_price_detached_item);

                                        }
                                      }
                                    }
                                  }
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context)
                                  .pushNamed(PriceDetachedPageViewRoute);
                            }else{
                              setState(() {
                                isLoading = false;

                                alertModalYoutube(context, 'Atenção', 'Sua tabela de preço necessita pelo menos de um item. Para saber mais, veja nosso treinamento no youtube.');
                              });
                            }
                          },
                          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
                          text: 'Salvar',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  _config(BuildContext context) {
    return isLoading
        ? isLoadingPage()
        : Container(
            color: Colors.white,
            child: Center(
              child: Observer(
                builder: (_) {
                  return ListView.builder(
                    itemCount: prices.listPriceItemInnerJoinBase.length,
                    itemBuilder: (context, index) {
                      if (prices.listPriceItemInnerJoinBase[index].tickado ==
                          1) {
                        tickado = true;
                      } else {
                        tickado = false;
                      }
                      return prices.listPriceItemInnerJoinBase[index].type ==
                              '0'
                          ? Container(
                              color: Colors.white,
                              child: CheckboxListTile(
                                  title: Text(
                                    prices
                                        .listPriceItemInnerJoinBase[index].name,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  activeColor: Color.fromRGBO(41, 202, 168, 3),
                                  value: tickado,
                                  onChanged: (val) {
                                    setState(() {
                                      tickado = val;
                                      if (tickado == true) {
                                        prices.listPriceItemInnerJoinBase[index]
                                            .tickado = 1;
                                      } else {
                                        prices.listPriceItemInnerJoinBase[index]
                                            .tickado = 2;
                                      }
                                    });
                                  }),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Container(
                                color: Color.fromRGBO(41, 202, 168, 3),
                                child: CheckboxListTile(
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      prices.listPriceItemInnerJoinBase[index]
                                          .name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: tickado,
                                    onChanged: (val) {
                                      setState(() {
                                        tickado = val;
                                        if (tickado == true) {
                                          prices
                                              .listPriceItemInnerJoinBase[index]
                                              .tickado = 1;
                                        } else {
                                          prices
                                              .listPriceItemInnerJoinBase[index]
                                              .tickado = 2;
                                        }
                                      });
                                    }),
                              ),
                            );
                    },
                  );
                },
              ),
            ),
          );
  }

  modalBottomSheetMenu(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            color: Colors.transparent,
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: new Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              SystemChannels.textInput.invokeMethod('TextInput.hide');
                            },
                            child: TextField(
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              controller: _price,
                              keyboardType: TextInputType.text,
                              autofocus: true,
                              decoration: new InputDecoration(
                                labelText: 'Preço',
                                hintText: '2.0',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 4.0,
                          onPressed: () {
                            DatePicker.showTimePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true, onConfirm: (time) {
                              _tolerance.text =
                                  '${time.toString().substring(11, 19)}';
                              _time = _tolerance.text;
                              setState(() {
                                _time = _tolerance.text;
                              });
                            },
                                currentTime: DateTime.utc(
                                    DateTime.now().year, 00, 00, 00),
                                locale: LocaleType.pt);
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 18.0,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            _time,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "Escolher",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ButtonApp2Park(
                            onPressed: () async {
                              String tolerance = _tolerance.text;
                              if (tolerance == "") {
                                tolerance = '00:00:00';
                              }
                              prices.updatePriceItem(
                                  index,
                                  double.parse('${_price.numberValue}'),
                                  tolerance);
                              Navigator.pop(context);
                            },
                            backgroundColor: Color.fromRGBO(41, 202, 168, 3),
                            text: 'Salvar',
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}

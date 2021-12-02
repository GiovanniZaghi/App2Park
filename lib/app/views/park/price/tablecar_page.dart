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

class TableCarPage extends StatefulWidget {
  @override
  _TableCarPageState createState() => _TableCarPageState();
}

class _TableCarPageState extends State<TableCarPage> {
  SharedPref sharedPref = SharedPref();
  bool sim = true;
  bool nao = false;
  int cash = 2;
  final _name = new TextEditingController();
  final _daily_start = new TextEditingController();
  final _price =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',',precision: 2);
  final _ordem = new TextEditingController();
  final _tolerance = new TextEditingController();
  bool hab = true;
  bool desa = false;
  bool tickado = false;
  String type = "";
  int id_status;
  int id_price_detached = 0;
  PriceItemInnerJoinVehicles priceItemJoinVehiclesmodel;
  Future<List<VehicleTypeOffModel>> _future;
  VehicleTypeDao vehicleDao = VehicleTypeDao();
  VehicleTypeOffModel selectedVehicle;
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
  bool carValida = false;

  FocusNode _focusNode = FocusNode();
  Color color;

  String dates =
  DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();

  bool _validateName = false;
  bool _validateDaily = false;
  bool _validateOrder = false;

  bool isLoading = false;

  int tipo = 0;

  PriceStore prices = PriceStore();

  @override
  void initState() {
    // TODO: implement initState
    loadSharedPrefs();
    _future = vehicleDao.findAllVehicleTypeModelOff();
    if (id_price_detached == 0) {
      prices.getPricesItemInnerJoinBase(0);
    }
    super.initState();
  }

  loadSharedPrefs() async {
    try {
      Park pa = Park.fromJson(await sharedPref.read("park"));
      setState(() {
        park = pa;
        id_park = int.parse(pa.id);
        ordem = '1';
        _ordem.text = ordem;
      });
      Park ps = Park.fromJson(await sharedPref.read("park"));
      setState(() {
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO TABLECAR PAGE', 'APP');
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
    return isLoading ? isLoadingPage() : RefreshIndicator(
        onRefresh: _refreshLocalGallery,
        child: Container(
          color: Colors.white,
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
                      errorText:
                          _validateName ? 'Digite um nome para tabela' : null,
                      labelStyle: TextStyle(
                        fontSize: 22,
                        color: _focusNode.hasFocus ? Colors.blue : Colors.black,
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
                            var dateFormat = new DateFormat('yyyy-MM-dd HH:mm:ss');
                            _tempo = dateFormat.format(time);
                            _daily_start.text = _tempo;
                            setState(() {});
                          }, currentTime: DateTime.parse(_tempo), locale: LocaleType.pt);
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
                                      " ${_tempo.substring(11,19)}",
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Tipo de Veículo :  ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder<List<VehicleTypeOffModel>>(
                          initialData: List<VehicleTypeOffModel>(),
                          future: _future,
                          builder: (context, snapshot) {
                            return DropdownButton<VehicleTypeOffModel>(
                              hint: Text(
                                'Escolha o veiculo',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              value: selectedVehicle,
                              isDense: true,
                              items: snapshot.data
                                  .map((vehicle) =>
                                      DropdownMenuItem<VehicleTypeOffModel>(
                                        child: Text(vehicle.type),
                                        value: vehicle,
                                      ))
                                  .toList(),
                              onChanged: (newValue2) {
                                setState(() {
                                  selectedVehicle = newValue2;
                                  carValida = true;
                                });
                              },
                            );
                          }),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          if(prices.listPriceItemInnerJoinBase[index].price == null)
                          {
                            prices.listPriceItemInnerJoinBase[index].price = 0.0;
                          }

                          if(prices.listPriceItemInnerJoinBase[index].tolerance == null){
                            prices.listPriceItemInnerJoinBase[index].tolerance = '00:00:00';
                          }
                          if (tickado) {
                            return Container(

                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () async {
                                          modalBottomSheetMenu(context, index);
                                          _refreshLocalGallery();
                                        },
                                        child: prices.listPriceItemInnerJoinBase[index].type == '0' ? Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Container(
                                            color: Colors.white,
                                            child:  ListTile(
                                              title: Text(
                                                '${prices.listPriceItemInnerJoinBase[index].name} ',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              subtitle: Text('Preço: ${NumberFormat.currency(name: '').format(prices.listPriceItemInnerJoinBase[index].price)} Tolerancia: ${prices.listPriceItemInnerJoinBase[index].tolerance}'),
                                            ),
                                          ),
                                        ) : Container(

                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 40.0, bottom: 5.0),
                                            child: Container(
                                              color: Color.fromRGBO(41, 202, 168, 3),
                                              child: ListTile(
                                                title: Text(
                                                  '${prices.listPriceItemInnerJoinBase[index].name} ',
                                                  style: TextStyle(fontSize: 16,color: Colors.white),
                                                ),
                                                subtitle: Text('Preço: ${NumberFormat.currency(name: '').format(prices.listPriceItemInnerJoinBase[index].price)} Tolerancia: ${prices.listPriceItemInnerJoinBase[index].tolerance}',style: TextStyle(fontSize: 16,color: Colors.white),),
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
                        bool sucess = true;
                        setState(() {
                          isLoading = true;
                        });

                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if(carValida == false){
                          setState(() {
                            sucess = false;
                            isLoading = false;
                            alertModalsError(context, "Erro", "Selecione um Tipo de Veiculo");
                          });
                        }


                        if(sucess == true){
                          if(prices.listPriceItemInnerJoinBase.where((element) => element.tickado == 1).length > 0){
                            int id_detached_app;
                            int id_detached = 0;
                            int id_park = int.parse(park.id);
                            if (priceItemJoinVehiclesmodel == null) {
                              setState(() {
                                _name.text.isEmpty
                                    ? _validateName = true
                                    : _validateName = false;
                                _ordem.text.isEmpty
                                    ? _validateOrder = true
                                    : _validateOrder = false;
                              });

                              int cash = sim == true ? 1 : 2;
                              int ordem = int.parse(_ordem.text);
                              int status = hab == true ? 1 : 0;
                              int id_vehicle = selectedVehicle.id;
                              PriceDetachedOff priceDetachedOffModel =
                              PriceDetachedOff(id_detached, id_park, _name.text, _daily_start.text,
                                  id_vehicle, status, cash, ordem, dates);
                              id_detached_app = await priceDetachedDao
                                  .savePriceDetached(priceDetachedOffModel);
                              if (connectivityResult == ConnectivityResult.mobile ||
                                  connectivityResult == ConnectivityResult.wifi) {
                                PriceDetached priceDetached = PriceDetached();
                                priceDetached.id_price_detached_app =
                                    id_detached_app.toString();
                                priceDetached.id_park = park.id;
                                priceDetached.name = _name.text;
                                priceDetached.daily_start = _daily_start.text;
                                priceDetached.id_vehicle_type =
                                    id_vehicle.toString();
                                priceDetached.id_status = '$status';
                                priceDetached.cash = cash.toString();
                                priceDetached.sort_order = ordem.toString();
                                priceDetached.data_sinc = dates;

                                PriceDetachedResponse priceRes =
                                await PriceService.insertPriceDetached(
                                    priceDetached);

                                if (priceRes.status == "COMPLETED") {
                                  if (priceRes.data != null) {
                                    PriceDetached priceDetachR =
                                        priceRes.data.first;

                                    bool ok = await priceDetachedDao
                                        .updatePriceDetachedSinc(
                                        int.tryParse(priceDetachR.id),
                                        id_detached_app,
                                        priceDetachR.name,
                                        priceDetachR.daily_start,
                                        int.tryParse(
                                            priceDetachR.id_vehicle_type),
                                        int.tryParse(priceDetachR.id_status),
                                        cash,
                                        int.tryParse(priceDetachR.sort_order), dates);

                                    id_detached = int.tryParse(priceDetachR.id);

                                  }
                                }
                              }
                            }
                            for (int i = 0;
                            i < prices.listPriceItemInnerJoinBase.length;
                            i++) {
                              double price =
                                  prices.listPriceItemInnerJoinBase[i].price;
                              String tolerance =
                                  prices.listPriceItemInnerJoinBase[i].tolerance;

                              if(tolerance == ""){
                                tolerance = '00:00:00';
                              }

                              if (prices.listPriceItemInnerJoinBase[i].tickado ==
                                  1) {
                                int id_price_detached_item;
                                PriceDetachedItemOff priceDetachedOff =
                                PriceDetachedItemOff(
                                    0,
                                    id_detached,
                                    id_detached_app,
                                    prices.listPriceItemInnerJoinBase[i].id,
                                    price,
                                    tolerance);
                                id_price_detached_item = await priceDetachedItemDao
                                    .savePriceDetachedItem(priceDetachedOff);

                                if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                    connectivityResult ==
                                        ConnectivityResult.wifi) {

                                  PriceDetachedItem priceDetachedItem = PriceDetachedItem();
                                  priceDetachedItem.id_price_detached = id_detached.toString();
                                  priceDetachedItem.id_price_detached_item_app = id_price_detached_item.toString();
                                  priceDetachedItem.id_price_detached_item_base = prices.listPriceItemInnerJoinBase[i].id.toString();
                                  priceDetachedItem.price = price.toString();
                                  priceDetachedItem.tolerance = tolerance;

                                  PriceDetachedItemResponse priceDetachedItemres = await PriceService.insertPriceDetachedItem(priceDetachedItem);

                                  if(priceDetachedItemres.status == 'COMPLETED'){
                                    if(priceDetachedItemres.data != null){

                                      PriceDetachedItem priceDItem = priceDetachedItemres.data.first;

                                      bool ok = await priceDetachedItemDao.updatePriceDetachedItemSinc(int.tryParse(priceDItem.id), id_price_detached_item);

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
    return isLoading ? isLoadingPage() : Container(
      color: Colors.white,
      child: Center(
        child: Observer(
          builder: (_) {
            return ListView.builder(
              itemCount: prices.listPriceItemInnerJoinBase.length,
              itemBuilder: (context, index) {
                if (prices.listPriceItemInnerJoinBase[index].tickado == 1) {
                  tickado = true;
                } else {
                  tickado = false;
                }
                return prices.listPriceItemInnerJoinBase[index].type == '0'
                    ? Container(
                        color: Colors.white,
                        child: CheckboxListTile(
                            title: Text(
                              prices.listPriceItemInnerJoinBase[index].name,style: TextStyle(fontSize: 20),),
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
                            }

                            ),

                      )
                    : Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Container(
                          color: Color.fromRGBO(41, 202, 168, 3),
                          child: CheckboxListTile(
                            activeColor: Colors.white,
                              checkColor: Colors.black,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(prices
                                  .listPriceItemInnerJoinBase[index].name,style: TextStyle(
                                color: Colors.white
                              ),),

                              value: tickado,
                              onChanged: (val) {
                                setState(() {
                                  tickado = val;
                                  if (tickado == true) {
                                    prices.listPriceItemInnerJoinBase[index]
                                        .tickado = 1;

                                    prices.listPriceItemInnerJoinBase.firstWhere((element) => element.level == prices.listPriceItemInnerJoinBase[index].level).tickado = 1;

                                  } else {
                                    prices.listPriceItemInnerJoinBase[index].tickado = 2;
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
                        GestureDetector(
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
                              hintText: '2.00',
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
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
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
                        ButtonApp2Park(
                          onPressed: () async {
                            String tolerance = _tolerance.text;
                            if(tolerance == "") {
                              tolerance = '00:00:00';
                            }
                            prices.updatePriceItem(index,
                                double.parse('${_price.numberValue}'), tolerance);
                            Navigator.pop(context);
                          },
                          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
                          text: 'Salvar',
                        ),
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  alertModalsError(BuildContext context, String textTitle, String textCenter) {
    Widget okButton = FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
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
}

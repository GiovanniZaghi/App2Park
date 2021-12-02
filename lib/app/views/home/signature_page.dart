import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/app/views/home/signature_store.dart';
import 'package:app2park/db/dao/cart/cart_dao.dart';
import 'package:app2park/db/dao/cart/cart_item_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/nota_fiscal_assinatura/nota_fiscal_assinatura_dao.dart';
import 'package:app2park/db/dao/park/ParkDao.dart';
import 'package:app2park/db/dao/subscription/subscription_dao.dart';
import 'package:app2park/db/dao/subscription/subscription_item_dao.dart';
import 'package:app2park/module/boleto/boleto.dart';
import 'package:app2park/module/boleto/boleto_get.dart';
import 'package:app2park/module/boleto/send_mail_boleto.dart';
import 'package:app2park/module/boleto/service/boleto_service.dart';
import 'package:app2park/module/cart/cart_item_model.dart';
import 'package:app2park/module/cart/cart_model.dart';
import 'package:app2park/module/cart/service/cart_service.dart';
import 'package:app2park/module/config/boleto_response.dart';
import 'package:app2park/module/config/cart_item_response.dart';
import 'package:app2park/module/config/cart_response.dart';
import 'package:app2park/module/config/nota_fiscal_assinatura_response.dart';
import 'package:app2park/module/config/send_mail_boleto_response.dart';
import 'package:app2park/module/config/subscription_item_response.dart';
import 'package:app2park/module/config/subscription_response.dart';
import 'package:app2park/module/nota_fiscal_assinatura/nota_fiscal_assinatura_model.dart';
import 'package:app2park/module/nota_fiscal_assinatura/service/nota_fiscal_assinatura_service.dart';
import 'package:app2park/module/park/cep/Cep.dart';
import 'package:app2park/module/park/cep/services/CepService.dart';
import 'package:app2park/module/subscription/services/subscription_service.dart';
import 'package:app2park/module/subscription/subscription_item_model.dart';
import 'package:app2park/module/subscription/subscription_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/cart/cart_item_off_model.dart';
import 'package:app2park/moduleoff/cart/cart_off_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/nota_fiscal_assinatura/nota_fiscal_assinatura_off_model.dart';
import 'package:app2park/moduleoff/park/ParkOff.dart';
import 'package:app2park/moduleoff/park/park_off_join.dart';
import 'package:app2park/moduleoff/subscription/subscription_item_off_model.dart';
import 'package:app2park/moduleoff/subscription/subscription_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'dart:io' show Platform;


class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class NumberList {
  String number;
  int lines;
  int index;

  NumberList({this.number, this.lines, this.index});
}

class _SignaturePageState extends State<SignaturePage> {
  bool mensal = false;
  bool anual = false;
  bool cpf = true;
  bool cnpj = false;
  bool pagUni = true;
  bool pagDoc = false;
  bool visiOpt = false;
  bool visiCPF = false;
  bool visiCNPJ = false;

  bool _validateNome = false;
  bool _validateDOC = false;
  bool _validateEmail = false;
  bool _validateCEP = false;
  bool _validateEndereco = false;
  bool _validateNumero = false;
  bool _validateCidade = false;
  bool _validateEstado = false;
  bool _validateTelefone = false;


  bool datatable = false;

  bool isLoading = false;

  final _cep = new MaskedTextController(mask: '00000-000');
  final _telefone = new MaskedTextController(mask: '(00)00000-0000)');
  final _endereco = new TextEditingController();
  final _cidade = new TextEditingController();
  final _estado = new TextEditingController();
  final _email = new TextEditingController();
  final _complemento = new TextEditingController();
  final _numero = new TextEditingController();
  final _nomeRazao = new TextEditingController();

  String nomeRazao = 'Nome Completo';
  String textNome = 'Digite o nome completo';

  String doc = 'CPF';
  String textDOC = 'Digite o CPF';

  Cep cep = Cep();

  String radioItemHolder = 'CPF';
  int id_type = 1;
  String type = '1';
  int lines = 14;
  int qtd = 0;
  List<ParkOffJoin> parkOffList = List<ParkOffJoin>();

  SharedPref sharedPref = SharedPref();
  ParkDao parkDao = ParkDao();
  SubscriptionItemDao _subscriptionItemDao = SubscriptionItemDao();
  SubscriptionDao _subscriptionDao = SubscriptionDao();
  NotaFiscalAssinaturaDao _notaFiscalAssinaturaDao = NotaFiscalAssinaturaDao();
  CartDao _cartDao = CartDao();
  CartItemDao _cartItemDao = CartItemDao();
  bool tickado = false;

  SignatureStore signatureStore = SignatureStore();

  User userLoad = User();

  DateTime agora = DateTime.now();

  DateTime maximo = DateTime.now().add(new Duration(days: 40));

  String dia = "Dia para pagamento";

  var _docCnpj = new MaskedTextController(mask: '000.000.000-00');

  List<NumberList> nList = [
    NumberList(
      index: 1,
      number: "CPF",
      lines: 14,
    ),
    NumberList(
      index: 2,
      number: "CNPJ",
      lines: 18,
    ),
  ];

  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sharedPref.read("user"));

      setState(() {
        userLoad = user;
      });

      signatureStore.getPricesItemInnerJoinBase(int.tryParse(user.id));
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO SIGNATURE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    loadSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assinatura'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: Platform.isAndroid ? _body(context) : Platform.isIOS ? _bodyIOS(context) : Container(),
    );
  }

  _body(BuildContext context) {
    return  isLoading == true ? isLoadingPage() : Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Assinatura',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
              Text(
                'Marque abaixo quais estacionamentos deseja fazer assinatura para utilizar o App2Park',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: <Widget>[
                  Text('Quantidade de \nestacionamentos selecionados: ${signatureStore.listParkOffJoinBase.where((element) => element.tickado == 1).length}'),
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                      )),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    child: Observer(
                      builder: (_) {
                        return DataTable(
                          columns: [
                            DataColumn(label: Text('Check')),
                            DataColumn(label: Text('Estacionamento')),
                            DataColumn(
                                label: Text(
                                  'Assinatura\nvalida até',
                                  style: TextStyle(),
                                )),
                          ],
                          rows: signatureStore
                              .listParkOffJoinBase.distinctBy((selector) => selector.id) // Loops through dataColumnText, each iteration assigning the value to element
                              .map(
                            ((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(SizedBox(
                                  width: 15,
                                  child: Checkbox(
                                      value: element.tickado == 0
                                          ? false
                                          : true,
                                      onChanged: (bool value) {
                                        setState(() {
                                          value == true ? qtd++ : qtd--;

                                          element.tickado =
                                          value == true ? 1 : 0;
                                          signatureStore.updatePriceItem(
                                              element.tickado,
                                              element.tickado);
                                        });
                                        for (int i = 0;
                                        i <
                                            signatureStore
                                                .listParkOffJoinBase
                                                .length;
                                        i++) {

                                        }
                                      }),
                                )),
                                //Extracting from Map element the value
                                DataCell(
                                  Text(
                                    '${element.name_park}',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  onTap: () {},
                                ),
                                DataCell(
                                  Text(
                                    '${element.subscription}',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            )),
                          )
                              .toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              SizedBox(

                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Table(
                      columnWidths: Map.from({
                        0: FixedColumnWidth(20),
                        1: FixedColumnWidth(70),
                        2: FixedColumnWidth(100),
                        3: FixedColumnWidth(100)
                      }),
                      border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          Text(''),
                          Text('Período da Assinatura',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          Text('Preço por Estacionamento',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                          Text('Preço Total',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ]),
                        TableRow(children: [
                          Checkbox(
                              value: mensal,
                              onChanged: (bool value) {
                                setState(() {
                                  mensal = value;
                                  anual = false;
                                });
                              }),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('Mensal',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('100,00',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('${signatureStore.listParkOffJoinBase.where((element) => element.tickado == 1).length*100}',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              ],
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          Checkbox(
                              value: anual,
                              onChanged: (bool value) {
                                setState(() {
                                  anual = value;
                                  mensal = false;
                                });
                              }),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('Anual (10% de desconto)',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('1.080,00',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('${signatureStore.listParkOffJoinBase.where((element) => element.tickado == 1).length*1080}',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                              ],
                            ),
                          ),
                        ]),
                      ]),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonApp2Park(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        var connectivityResult =
                            await (Connectivity().checkConnectivity());

                        if (connectivityResult == ConnectivityResult.mobile ||
                            connectivityResult == ConnectivityResult.wifi) {
                          if (pagUni) {
                            for (int i = 0;
                                i < signatureStore.listParkOffJoinBase.length;
                                i++) {
                              ParkOffJoin parkJoin =
                                  signatureStore.listParkOffJoinBase[i];

                              if (parkJoin.tickado == 1) {
                                var splitcell = userLoad.cell.split(')');


                                String ddd = splitcell[0].substring(1, 3);


                                var splitnumber = splitcell[1].split('-');


                                String celular =
                                    splitnumber[0] + splitnumber[1];


                                int id_subscription;
                                int id_subscription_item;

                                String JURIDICA = 'JURIDICA';
                                String FISICA = 'FISICA';

                                SubscriptionItemOffModel subs =
                                    await _subscriptionItemDao.getSubscription(
                                        int.tryParse(parkJoin.id));

                                if (subs != null) {
                                  id_subscription_item = subs.id;

                                  SubscriptionOffModel subscriptionOffModel =
                                      await _subscriptionDao.getSubscription(
                                          subs.id_subscription);

                                  id_subscription = subscriptionOffModel.id;
                                } else {
                                  SubscriptionModel subscriptionModel =
                                      SubscriptionModel();
                                  subscriptionModel.id_user = userLoad.id;
                                  subscriptionModel.subscription_price =
                                      '100.00';
                                  if (mensal) {
                                    subscriptionModel.id_period = '1';
                                  }
                                  if (anual) {
                                    subscriptionModel.id_period = '12';
                                  }
                                  if (pagUni) {
                                    subscriptionModel.id_send = '0';
                                  }
                                  if (pagDoc) {
                                    subscriptionModel.id_send = '1';
                                  }
                                  subscriptionModel.name =
                                      parkJoin.business_name;
                                  subscriptionModel.email = userLoad.email;


                                  var cepsplit =
                                      parkJoin.postal_code.split("-");


                                  String cepfinal = cepsplit[0] + cepsplit[1];


                                  subscriptionModel.postal_code = cepfinal;
                                  subscriptionModel.street = parkJoin.street;
                                  subscriptionModel.number = parkJoin.number;
                                  subscriptionModel.complement =
                                      parkJoin.complement;
                                  subscriptionModel.neighborhood =
                                      parkJoin.neighborhood;
                                  subscriptionModel.city = parkJoin.city;
                                  subscriptionModel.state = parkJoin.state;
                                  subscriptionModel.ddd = ddd;
                                  subscriptionModel.cell = celular;
                                  if (parkJoin.type == '1') {
                                    subscriptionModel.type = FISICA;

                                    var docsplit = parkJoin.doc.split(".");



                                    var splitfinal = docsplit[2].split('-');


                                    String doccpf = docsplit[0] +
                                        docsplit[1] +
                                        splitfinal[0] +
                                        splitfinal[1];


                                    subscriptionModel.doc = doccpf;
                                  } else {
                                    subscriptionModel.type = JURIDICA;


                                    var docsplit = parkJoin.doc.split(".");


                                    var splitfinal = docsplit[2].split('/');


                                    var splitoutro = splitfinal[1].split('-');

                                    String doccpf = docsplit[0] +
                                        docsplit[1] +
                                        splitfinal[0] +
                                        splitoutro[0] +
                                        splitoutro[1];


                                    subscriptionModel.doc = doccpf;
                                  }

                                  SubscriptionResponse subscriptionRes =
                                      await SubscriptionService
                                          .createSubscription(
                                              subscriptionModel);

                                  if (subscriptionRes.status == 'COMPLETED') {
                                    if (subscriptionRes.data != null) {
                                      for (int i = 0;
                                          i < subscriptionRes.data.length;
                                          i++) {
                                        SubscriptionModel subscriptionModelRes =
                                            subscriptionRes.data[i];

                                        SubscriptionOffModel
                                            subscriptionOffModel =
                                            SubscriptionOffModel(
                                                int.tryParse(
                                                    subscriptionModelRes.id),
                                                int.tryParse(
                                                    subscriptionModelRes
                                                        .id_user),
                                                double
                                                    .tryParse(
                                                        subscriptionModelRes
                                                            .subscription_price),
                                                int.tryParse(
                                                    subscriptionModelRes
                                                        .id_period),
                                                int.tryParse(
                                                    subscriptionModelRes
                                                        .id_send),
                                                subscriptionModelRes.doc,
                                                subscriptionModelRes.name,
                                                subscriptionModelRes.email,
                                                subscriptionModelRes
                                                    .postal_code,
                                                subscriptionModelRes.street,
                                                subscriptionModelRes.number,
                                                subscriptionModelRes.complement,
                                                subscriptionModelRes
                                                    .neighborhood,
                                                subscriptionModelRes.city,
                                                subscriptionModelRes.state,
                                                subscriptionModelRes.ddd,
                                                subscriptionModelRes.cell,
                                                subscriptionModelRes.type);

                                        id_subscription = int.tryParse(
                                            subscriptionModelRes.id);

                                        int id_subscription_app =
                                            await _subscriptionDao
                                                .saveSubscriptionOffModel(
                                                    subscriptionOffModel);

                                        SubscriptionItemModel
                                            subcriptionItemModel =
                                            SubscriptionItemModel();
                                        subcriptionItemModel.id_park =
                                            parkJoin.id;
                                        subcriptionItemModel.id_subscription =
                                            subscriptionModelRes.id;

                                        SubscriptionItemResponse
                                            subscriptionItemRes =
                                            await SubscriptionService
                                                .createSubscriptionItem(
                                                    subcriptionItemModel);

                                        if (subscriptionItemRes.status ==
                                            'COMPLETED') {
                                          if (subscriptionItemRes.data !=
                                              null) {
                                            for (int i = 0;
                                                i <
                                                    subscriptionItemRes
                                                        .data.length;
                                                i++) {
                                              SubscriptionItemModel
                                                  subscriptionItemModelRes =
                                                  subscriptionItemRes.data[i];

                                              SubscriptionItemOffModel
                                                  subcriptionItemOffModel =
                                                  SubscriptionItemOffModel(
                                                      int.tryParse(
                                                          subscriptionItemModelRes
                                                              .id),
                                                      int.tryParse(
                                                          subscriptionItemModelRes
                                                              .id_subscription),
                                                      int.tryParse(
                                                          subscriptionItemModelRes
                                                              .id_park));

                                              id_subscription_item =
                                                  int.tryParse(
                                                      subscriptionItemModelRes
                                                          .id);

                                              int id_subcription_item_off =
                                                  await _subscriptionItemDao
                                                      .saveSubscriptionItemOffModel(
                                                          subcriptionItemOffModel);
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }

                                if (pagUni) {
                                  if (mensal) {
                                    Boleto boleto = Boleto();
                                    boleto.name = parkJoin.business_name;
                                    boleto.email = userLoad.email;
                                    boleto.cell = celular;

                                    var cepsplit =
                                        parkJoin.postal_code.split("-");


                                    String cepfinal = cepsplit[0] + cepsplit[1];


                                    boleto.postal_code = cepfinal;
                                    boleto.number = parkJoin.number;
                                    boleto.complement = parkJoin.complement;
                                    boleto.neighborhood = parkJoin.neighborhood;
                                    boleto.city = parkJoin.city;
                                    boleto.state = parkJoin.state;
                                    boleto.street = parkJoin.street;
                                    boleto.ddd = ddd;
                                    if (parkJoin.type == '1') {
                                      boleto.type = FISICA;

                                      var docsplit = parkJoin.doc.split(".");


                                      var splitfinal = docsplit[2].split('-');


                                      String doccpf = docsplit[0] +
                                          docsplit[1] +
                                          splitfinal[0] +
                                          splitfinal[1];


                                      boleto.doc = doccpf;
                                    } else {
                                      boleto.type = JURIDICA;


                                      var docsplit = parkJoin.doc.split(".");


                                      var splitfinal = docsplit[2].split('/');


                                      var splitoutro = splitfinal[1].split('-');

                                      String doccpf = docsplit[0] +
                                          docsplit[1] +
                                          splitfinal[0] +
                                          splitoutro[0] +
                                          splitoutro[1];


                                      boleto.doc = doccpf;
                                    }
                                    boleto.valor = '100.00';

                                    DateTime now = DateTime.now();

                                    now.add(Duration(days: 30));

                                    var dateFormat = new DateFormat('yyyy-MM-dd');
                                    String vencimento = dateFormat.format(now);


                                    boleto.vencimento = vencimento;

                                    BoletoResponse boletoRes =
                                        await BoletoService.createBoleto(
                                            boleto);

                                    if (boletoRes.status == 'COMPLETED') {
                                      if (boletoRes.data != null) {
                                        BoletoGet boletoGet = boletoRes.data;

                                        NotaFiscalAssinaturaModel
                                            notaFiscalAssinatura =
                                            NotaFiscalAssinaturaModel();
                                        notaFiscalAssinatura.id_user =
                                            userLoad.id;

                                        if (parkJoin.type == '1') {
                                          notaFiscalAssinatura.cpf =
                                              userLoad.doc;
                                          notaFiscalAssinatura.nome =
                                              userLoad.first_name;
                                          notaFiscalAssinatura.cnpj = "";
                                          notaFiscalAssinatura.razao_social =
                                              "";
                                          notaFiscalAssinatura
                                              .inscricao_municipal = "";
                                        } else {
                                          notaFiscalAssinatura.cpf = "";
                                          notaFiscalAssinatura.nome = "";
                                          notaFiscalAssinatura.cnpj =
                                              parkJoin.doc;
                                          notaFiscalAssinatura.razao_social =
                                              parkJoin.business_name;
                                          notaFiscalAssinatura
                                              .inscricao_municipal = "";
                                        }
                                        notaFiscalAssinatura.email =
                                            userLoad.email;
                                        notaFiscalAssinatura.telefone =
                                            parkJoin.cell;
                                        notaFiscalAssinatura.cep =
                                            parkJoin.postal_code;
                                        notaFiscalAssinatura.endereco =
                                            parkJoin.street;
                                        notaFiscalAssinatura.numero =
                                            parkJoin.number;
                                        notaFiscalAssinatura.complemento =
                                            parkJoin.complement;
                                        notaFiscalAssinatura.bairro =
                                            parkJoin.neighborhood;
                                        notaFiscalAssinatura.municipio =
                                            parkJoin.city;
                                        notaFiscalAssinatura.uf =
                                            parkJoin.state;

                                        NotaFiscalAssinaturaResponse
                                            notaFiscalAssinaturaRes =
                                            await NotaFiscalAssinaturaService
                                                .createNotaFiscal(
                                                    notaFiscalAssinatura);

                                        if (notaFiscalAssinaturaRes.status ==
                                            'COMPLETED') {
                                          if (notaFiscalAssinaturaRes.data !=
                                              null) {
                                            NotaFiscalAssinaturaModel
                                                notaFiscalAssinRes =
                                                notaFiscalAssinaturaRes.data;

                                            NotaFiscalAssinaturaOffModel
                                                notaFiscalAssinaturaOffModel =
                                                NotaFiscalAssinaturaOffModel(
                                                    int.tryParse(
                                                        notaFiscalAssinRes.id),
                                                    int.tryParse(
                                                        notaFiscalAssinRes
                                                            .id_user),
                                                    notaFiscalAssinRes.cpf == null
                                                        ? ""
                                                        : notaFiscalAssinRes
                                                            .cpf,
                                                    notaFiscalAssinRes.cnpj == null
                                                        ? ""
                                                        : notaFiscalAssinRes
                                                            .cnpj,
                                                    notaFiscalAssinRes.nome == null
                                                        ? " "
                                                        : notaFiscalAssinRes
                                                            .nome,
                                                    notaFiscalAssinRes
                                                                .razao_social ==
                                                            null
                                                        ? " "
                                                        : notaFiscalAssinRes
                                                            .razao_social,
                                                    notaFiscalAssinRes
                                                                .inscricao_municipal ==
                                                            null
                                                        ? " "
                                                        : notaFiscalAssinRes
                                                            .inscricao_municipal,
                                                    notaFiscalAssinRes.telefone,
                                                    notaFiscalAssinRes.email,
                                                    notaFiscalAssinRes.cep,
                                                    notaFiscalAssinRes.endereco,
                                                    notaFiscalAssinRes.numero,
                                                    notaFiscalAssinRes.complemento ==
                                                            null
                                                        ? " "
                                                        : notaFiscalAssinRes
                                                            .complemento,
                                                    notaFiscalAssinRes.bairro,
                                                    notaFiscalAssinRes.municipio,
                                                    notaFiscalAssinRes.uf,
                                                    notaFiscalAssinRes.data_criacao);

                                            int id_nota_fiscal =
                                                await _notaFiscalAssinaturaDao
                                                    .saveNotaFiscalAssinaturaOffModel(
                                                        notaFiscalAssinaturaOffModel);

                                            CartModel cartModel = CartModel();
                                            cartModel
                                                    .id_nota_fiscal_assinatura =
                                                notaFiscalAssinRes.id;
                                            cartModel.inter_number =
                                                boletoGet.nossoNumero;
                                            cartModel.bank_slip_number =
                                                boletoGet.linhaDigitavel;
                                            cartModel.bank_slip_value =
                                                boletoGet.valor;
                                            cartModel.bank_slip_issue =
                                                boletoGet.criacao;
                                            cartModel.bank_slip_due =
                                                boletoGet.vencimento;
                                            cartModel.status = '0';

                                            CartResponse cartRes =
                                                await CartService.createCart(
                                                    cartModel);

                                            if (cartRes.status == 'COMPLETED') {
                                              if (cartRes.data != null) {
                                                CartModel cartModelRes =
                                                    cartRes.data;


                                                CartOffModel cartOffModel = CartOffModel(
                                                    int.parse(cartModelRes.id),
                                                    int.tryParse(cartModelRes
                                                        .id_nota_fiscal_assinatura),
                                                    cartModelRes.inter_number,
                                                    cartModelRes
                                                        .bank_slip_number,
                                                    double.parse(cartModelRes
                                                        .bank_slip_value),
                                                    cartModelRes
                                                        .bank_slip_issue,
                                                    cartModelRes.bank_slip_due,
                                                    cartModelRes.bank_slip_payment ==
                                                            null
                                                        ? ""
                                                        : cartModelRes
                                                            .bank_slip_payment,
                                                    int.tryParse(
                                                        cartModelRes.status));

                                                int id_cart_off = await _cartDao
                                                    .saveCartOffModel(
                                                        cartOffModel);

                                                CartItemModel cartItemModel =
                                                    CartItemModel();
                                                cartItemModel.id_cart =
                                                    cartModelRes.id;
                                                cartItemModel.id_park =
                                                    parkJoin.id;
                                                cartItemModel.id_period = '1';
                                                cartItemModel.value = '100.00';

                                                CartItemResponse cartItemRes =
                                                    await CartService
                                                        .createCartItem(
                                                            cartItemModel);

                                                if (cartItemRes.status ==
                                                    'COMPLETED') {
                                                  if (cartItemRes.data !=
                                                      null) {
                                                    CartItemModel
                                                        cartItemModelRes =
                                                        cartItemRes.data;

                                                    CartItemOffModel
                                                        cartItemOffModel =
                                                        CartItemOffModel(
                                                            int.tryParse(
                                                                cartItemModelRes
                                                                    .id),
                                                            int.tryParse(
                                                                cartItemModelRes
                                                                    .id_cart),
                                                            int.tryParse(
                                                                cartItemModelRes
                                                                    .id_park),
                                                            int.tryParse(
                                                                cartItemModelRes
                                                                    .id_period),
                                                            double.parse(
                                                                cartItemModelRes
                                                                    .value));

                                                    int id_cart_item_off =
                                                        await _cartItemDao
                                                            .saveCartOffModel(
                                                                cartItemOffModel);

                                                    SendMailBoleto
                                                        sendMailBoleto =
                                                        SendMailBoleto();
                                                    sendMailBoleto.id_park =
                                                        parkJoin.id;
                                                    sendMailBoleto.name =
                                                        parkJoin.name_park;
                                                    sendMailBoleto
                                                            .inter_number =
                                                        boletoGet.nossoNumero;
                                                    sendMailBoleto
                                                            .bank_slip_number =
                                                        boletoGet
                                                            .linhaDigitavel;
                                                    sendMailBoleto
                                                            .bank_slip_value =
                                                        boletoGet.valor;
                                                    sendMailBoleto.email =
                                                        userLoad.email;
                                                    sendMailBoleto.type = '1';

                                                    SendMailBoletoResponse
                                                        sendBoletoRes =
                                                        await BoletoService
                                                            .sendMailBoleto(
                                                                sendMailBoleto);

                                                    if (sendBoletoRes.status ==
                                                        'COMPLETED') {
                                                      alertModal(
                                                          context,
                                                          'SUCESS!',
                                                          "BOLETOS ENVIADOS PARA SEU E-MAIL");
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  } else if (anual) {
                                    Boleto boleto = Boleto();
                                    boleto.name = parkJoin.business_name;
                                    boleto.email = userLoad.email;
                                    boleto.cell = celular;

                                    var cepsplit =
                                        parkJoin.postal_code.split("-");


                                    String cepfinal = cepsplit[0] + cepsplit[1];


                                    boleto.postal_code = cepfinal;
                                    boleto.number = parkJoin.number;
                                    boleto.complement = parkJoin.complement;
                                    boleto.neighborhood = parkJoin.neighborhood;
                                    boleto.city = parkJoin.city;
                                    boleto.state = parkJoin.state;
                                    boleto.street = parkJoin.street;
                                    boleto.ddd = ddd;
                                    if (parkJoin.type == '1') {
                                      boleto.type = FISICA;

                                      var docsplit = parkJoin.doc.split(".");


                                      var splitfinal = docsplit[2].split('-');


                                      String doccpf = docsplit[0] +
                                          docsplit[1] +
                                          splitfinal[0] +
                                          splitfinal[1];


                                      boleto.doc = doccpf;
                                    } else {
                                      boleto.type = JURIDICA;


                                      var docsplit = parkJoin.doc.split(".");


                                      var splitfinal = docsplit[2].split('/');


                                      var splitoutro = splitfinal[1].split('-');

                                      String doccpf = docsplit[0] +
                                          docsplit[1] +
                                          splitfinal[0] +
                                          splitoutro[0] +
                                          splitoutro[1];


                                      boleto.doc = doccpf;
                                    }
                                    boleto.valor = '1080.00';
                                    DateTime now = DateTime.now();

                                    now.add(Duration(days: 30));

                                    var dateFormat = new DateFormat('yyyy-MM-dd');
                                    String vencimento = dateFormat.format(now);


                                    boleto.vencimento = vencimento;

                                    BoletoResponse boletoRes =
                                        await BoletoService.createBoleto(
                                            boleto);

                                    if (boletoRes.status == 'COMPLETED') {
                                      if (boletoRes.data != null) {
                                        BoletoGet boletoGet = boletoRes.data;

                                        NotaFiscalAssinaturaModel
                                            notaFiscalAssinatura =
                                            NotaFiscalAssinaturaModel();
                                        notaFiscalAssinatura.id_user =
                                            userLoad.id;

                                        if (parkJoin.type == '1') {
                                          notaFiscalAssinatura.cpf =
                                              userLoad.doc;
                                          notaFiscalAssinatura.nome =
                                              userLoad.first_name;
                                          notaFiscalAssinatura.cnpj = "";
                                          notaFiscalAssinatura.razao_social =
                                              "";
                                          notaFiscalAssinatura
                                              .inscricao_municipal = "";
                                        } else {
                                          notaFiscalAssinatura.cpf = "";
                                          notaFiscalAssinatura.nome = "";
                                          notaFiscalAssinatura.cnpj =
                                              parkJoin.doc;
                                          notaFiscalAssinatura.razao_social =
                                              parkJoin.business_name;
                                          notaFiscalAssinatura
                                              .inscricao_municipal = "";
                                        }
                                        notaFiscalAssinatura.email =
                                            userLoad.email;
                                        notaFiscalAssinatura.telefone =
                                            parkJoin.cell;
                                        notaFiscalAssinatura.cep =
                                            parkJoin.postal_code;
                                        notaFiscalAssinatura.endereco =
                                            parkJoin.street;
                                        notaFiscalAssinatura.numero =
                                            parkJoin.number;
                                        notaFiscalAssinatura.complemento =
                                            parkJoin.complement;
                                        notaFiscalAssinatura.bairro =
                                            parkJoin.neighborhood;
                                        notaFiscalAssinatura.municipio =
                                            parkJoin.city;
                                        notaFiscalAssinatura.uf =
                                            parkJoin.state;

                                        NotaFiscalAssinaturaResponse
                                            notaFiscalAssinaturaRes =
                                            await NotaFiscalAssinaturaService
                                                .createNotaFiscal(
                                                    notaFiscalAssinatura);

                                        if (notaFiscalAssinaturaRes.status ==
                                            'COMPLETED') {
                                          if (notaFiscalAssinaturaRes.data !=
                                              null) {
                                            NotaFiscalAssinaturaModel
                                                notaFiscalAssinRes =
                                                notaFiscalAssinaturaRes.data;

                                            NotaFiscalAssinaturaOffModel
                                                notaFiscalAssinaturaOffModel =
                                                NotaFiscalAssinaturaOffModel(
                                                    int.tryParse(
                                                        notaFiscalAssinRes.id),
                                                    int.tryParse(
                                                        notaFiscalAssinRes
                                                            .id_user),
                                                    notaFiscalAssinRes.cpf == null
                                                        ? ""
                                                        : notaFiscalAssinRes
                                                            .cpf,
                                                    notaFiscalAssinRes.cnpj == null
                                                        ? ""
                                                        : notaFiscalAssinRes
                                                            .cnpj,
                                                    notaFiscalAssinRes.nome == null
                                                        ? " "
                                                        : notaFiscalAssinRes
                                                            .nome,
                                                    notaFiscalAssinRes
                                                                .razao_social ==
                                                            null
                                                        ? " "
                                                        : notaFiscalAssinRes
                                                            .razao_social,
                                                    notaFiscalAssinRes
                                                                .inscricao_municipal ==
                                                            null
                                                        ? " "
                                                        : notaFiscalAssinRes
                                                            .inscricao_municipal,
                                                    notaFiscalAssinRes.telefone,
                                                    notaFiscalAssinRes.email,
                                                    notaFiscalAssinRes.cep,
                                                    notaFiscalAssinRes.endereco,
                                                    notaFiscalAssinRes.numero,
                                                    notaFiscalAssinRes.complemento ==
                                                            null
                                                        ? " "
                                                        : notaFiscalAssinRes
                                                            .complemento,
                                                    notaFiscalAssinRes.bairro,
                                                    notaFiscalAssinRes.municipio,
                                                    notaFiscalAssinRes.uf,
                                                    notaFiscalAssinRes.data_criacao);

                                            int id_nota_fiscal =
                                                await _notaFiscalAssinaturaDao
                                                    .saveNotaFiscalAssinaturaOffModel(
                                                        notaFiscalAssinaturaOffModel);

                                            CartModel cartModel = CartModel();
                                            cartModel
                                                    .id_nota_fiscal_assinatura =
                                                notaFiscalAssinRes.id;
                                            cartModel.inter_number =
                                                boletoGet.nossoNumero;
                                            cartModel.bank_slip_number =
                                                boletoGet.linhaDigitavel;
                                            cartModel.bank_slip_value =
                                                boletoGet.valor;
                                            cartModel.bank_slip_issue =
                                                boletoGet.criacao;
                                            cartModel.bank_slip_due =
                                                boletoGet.vencimento;
                                            cartModel.status = '0';

                                            CartResponse cartRes =
                                                await CartService.createCart(
                                                    cartModel);

                                            if (cartRes.status == 'COMPLETED') {
                                              if (cartRes.data != null) {
                                                CartModel cartModelRes =
                                                    cartRes.data;


                                                CartOffModel cartOffModel = CartOffModel(
                                                    int.parse(cartModelRes.id),
                                                    int.tryParse(cartModelRes
                                                        .id_nota_fiscal_assinatura),
                                                    cartModelRes.inter_number,
                                                    cartModelRes
                                                        .bank_slip_number,
                                                    double.parse(cartModelRes
                                                        .bank_slip_value),
                                                    cartModelRes
                                                        .bank_slip_issue,
                                                    cartModelRes.bank_slip_due,
                                                    cartModelRes.bank_slip_payment ==
                                                            null
                                                        ? ""
                                                        : cartModelRes
                                                            .bank_slip_payment,
                                                    int.tryParse(
                                                        cartModelRes.status));

                                                int id_cart_off = await _cartDao
                                                    .saveCartOffModel(
                                                        cartOffModel);

                                                CartItemModel cartItemModel =
                                                    CartItemModel();
                                                cartItemModel.id_cart =
                                                    cartModelRes.id;
                                                cartItemModel.id_park =
                                                    parkJoin.id;
                                                cartItemModel.id_period = '12';
                                                cartItemModel.value = '1080.00';

                                                CartItemResponse cartItemRes =
                                                    await CartService
                                                        .createCartItem(
                                                            cartItemModel);

                                                if (cartItemRes.status ==
                                                    'COMPLETED') {
                                                  if (cartItemRes.data !=
                                                      null) {
                                                    CartItemModel
                                                        cartItemModelRes =
                                                        cartItemRes.data;

                                                    CartItemOffModel
                                                        cartItemOffModel =
                                                        CartItemOffModel(
                                                            int.tryParse(
                                                                cartItemModelRes
                                                                    .id),
                                                            int.tryParse(
                                                                cartItemModelRes
                                                                    .id_cart),
                                                            int.tryParse(
                                                                cartItemModelRes
                                                                    .id_park),
                                                            int.tryParse(
                                                                cartItemModelRes
                                                                    .id_period),
                                                            double.parse(
                                                                cartItemModelRes
                                                                    .value));

                                                    int id_cart_item_off =
                                                        await _cartItemDao
                                                            .saveCartOffModel(
                                                                cartItemOffModel);

                                                    SendMailBoleto
                                                        sendMailBoleto =
                                                        SendMailBoleto();
                                                    sendMailBoleto.id_park =
                                                        parkJoin.id;
                                                    sendMailBoleto.name =
                                                        parkJoin.name_park;
                                                    sendMailBoleto
                                                            .inter_number =
                                                        boletoGet.nossoNumero;
                                                    sendMailBoleto
                                                            .bank_slip_number =
                                                        boletoGet
                                                            .linhaDigitavel;
                                                    sendMailBoleto
                                                            .bank_slip_value =
                                                        boletoGet.valor;
                                                    sendMailBoleto.email =
                                                        userLoad.email;
                                                    sendMailBoleto.type = '12';

                                                    SendMailBoletoResponse
                                                        sendBoletoRes =
                                                        await BoletoService
                                                            .sendMailBoleto(
                                                                sendMailBoleto);

                                                    if (sendBoletoRes.status ==
                                                        'COMPLETED') {
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  } else {
                                    alertModals(context, 'ERROR!',
                                        "SELECIONE UM PERIODO DE PAGAMENTO");
                                  }
                                }
                              }
                            }
                          } else {
                            alertModals(context, 'ERROR!',
                                "SELECIONE UM PERIODO DE PAGAMENTO");
                          }

                          setState(() {
                            isLoading = false;
                          });

                          alertModals(
                              context,
                              'SUCESS!',
                              "BOLETOS ENVIADOS PARA SEU E-MAIL");
                        }
                      },
                      text: 'Salvar',
                    ),
                  ),
                  Expanded(
                    child: ButtonApp2Park(
                      onPressed: () {},
                      text: 'Cancelar',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _bodyIOS(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Entre em contato conosco para a Assinatura.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text('Fone(Whatsapp) : ',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                Text('(11) 93316-5686',style: TextStyle(
                  fontSize: 20,

                ),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Text('Email : ',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                Text('app2park@app2park.com.br',style: TextStyle(
                    fontSize: 20
                ),),
              ],
            ),
            Row(
              children: <Widget>[
                Text('NOVANDI INFORMATICA EIRELI',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),)
              ],
            ),
            Row(
              children: <Widget>[
                Text('CNPJ : ',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                Text('64.656.465/0001-88',style: TextStyle(
                  fontSize: 20,

                ),)
              ],
            ),
            Text('RUA DOS TRES IRMAOS - Num: 201 - CONJ 87',style: TextStyle(
              fontSize: 20,
            ),),
            Text('SÃO PAULO - SP',style: TextStyle(
              fontSize: 20,
            ),),
            SizedBox(
              height: 20,
            ),
            ButtonApp2Park(
              text: 'Voltar',
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(HomeViewRoute, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
alertModals(BuildContext context, String textTitle, String textCenter) {
  Widget okButton = FlatButton(
    child: Text(text),
    onPressed: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeViewRoute, (Route<dynamic> route) => false);
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
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

/*

                                      if(notaFiscalAssinaturaRes.status == 'COMPLETED'){

                                       if(notaFiscalAssinaturaRes.data != null){

                                         NotaFiscalAssinaturaModel notaFiscalAssinRes = notaFiscalAssinaturaRes.data;

                                         NotaFiscalAssinaturaOffModel notaFiscalAssinaturaOffModel = NotaFiscalAssinaturaOffModel(
                                             int.tryParse(notaFiscalAssinRes.id),
                                             int.tryParse(notaFiscalAssinRes.id_user),
                                             notaFiscalAssinRes.cpf == null ? "": notaFiscalAssinRes.cpf,
                                             notaFiscalAssinRes.cnpj == null ? "": notaFiscalAssinRes.cnpj,
                                             notaFiscalAssinRes.nome == null ? " ": notaFiscalAssinRes.nome,
                                             notaFiscalAssinRes.razao_social == null ? " ": notaFiscalAssinRes.razao_social,
                                             notaFiscalAssinRes.inscricao_municipal == null ? " ": notaFiscalAssinRes.inscricao_municipal,
                                             notaFiscalAssinRes.telefone,
                                             notaFiscalAssinRes.email,
                                             notaFiscalAssinRes.cep,
                                             notaFiscalAssinRes.endereco,
                                             notaFiscalAssinRes.numero,
                                             notaFiscalAssinRes.complemento == null ? " " : notaFiscalAssinRes.complemento,
                                             notaFiscalAssinRes.bairro,
                                             notaFiscalAssinRes.municipio,
                                             notaFiscalAssinRes.uf,
                                             notaFiscalAssinRes.data_criacao
                                         );

                                         int id_nota_fiscal = await _notaFiscalAssinaturaDao.saveNotaFiscalAssinaturaOffModel(notaFiscalAssinaturaOffModel);

 */

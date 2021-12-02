import 'package:app2park/app/helpers/alerts/AlertModal.dart';
import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormNoValidate.dart';
import 'package:app2park/app/helpers/layout/textform/TextFormValidate.dart';
import 'package:app2park/app/helpers/validators/Validators.dart';
import 'package:app2park/app/views/home/InfRegisterStreetPark.dart';
import 'package:app2park/app/views/home/RegisterStreetPark.dart';
import 'package:app2park/app/views/park/price/tables/contract_daily_edit_page.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class RegisterPark extends StatefulWidget {
  @override
  _RegisterParkState createState() => _RegisterParkState();
}
class NumberList {
  String number;
  int lines;
  int index;
  NumberList({this.number,this.lines,this.index});

}
class _RegisterParkState extends State<RegisterPark> {

  String radioItemHolder = 'CPF';
  int id_type = 1;
  String type = '1';
  int lines = 14;

  var _doc = new MaskedTextController(mask: '000.000.000-00');

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
  final _formKey = GlobalKey<FormState>();
  final _namePark = new TextEditingController();
  final _businessName = new TextEditingController();
  final _cell = new MaskedTextController(mask: '(00)00000-0000');
  final _vagas = new TextEditingController();
  bool _validateNome = false;
  bool _validateFantasia = false;
  bool _validateTelefone = false;
  bool _validateVagas = false;
  bool _validateDOC = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dados do Estacionamento",
        ),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }


  _body(BuildContext context) {
    return Center(
      child: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            children: <Widget>[
              Text('Nome do Estacionamento : ', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              TextField(
                controller: _namePark,
                style: TextStyle(
                    fontSize: 18
                ),
                decoration: InputDecoration(
                  hintText: 'Digite o nome do estacionamento',
                  errorText: _validateNome ? 'Digite um nome' : null,
                  suffixIcon: Icon(Icons.local_parking),
                ),
              ),

              Container(
                height: 30,
              ),
              Text('Razão Social : ', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              TextField(
                controller: _businessName,
                style: TextStyle(
                    fontSize: 18
                ),
                decoration: InputDecoration(
                  hintText: 'Digite o nome Fantasia',
                  errorText: _validateFantasia ? 'Digite um nome' : null,
                  suffixIcon: Icon(Icons.business),
                ),
              ),
              Container(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: Text("Pessoa física",style: TextStyle(fontSize: 18),),
                  ),
                  SizedBox(
                    child: Row(
                        children:
                        nList.map((data) => Radio(
                          groupValue: id_type,
                          value: data.index,
                          onChanged: (val) {
                            setState(() {
                              radioItemHolder = data.number ;
                              lines = data.lines;
                              id_type = data.index;
                              type = id_type.toString();

                              if(lines >= 15 ){
                                _doc = new MaskedTextController(mask: '00.000.000/0000-00');

                              }else{
                                _doc = new MaskedTextController(mask:'000.000.000-00');
                              }
                            });
                          },
                        )).toList(),
                    ),
                  ),
                  SizedBox(
                    child: Text("Pessoa jurídica ",style: TextStyle(fontSize: 18),),
                  ),
                ],
                ),
              SizedBox(
                height: 20,
              ),
              Text('$radioItemHolder : ', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              TextField(
                controller: _doc,
                style: TextStyle(
                    fontSize: 18
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Digite o ' + radioItemHolder,
                  errorText: _validateDOC ? 'Digite um $radioItemHolder' : null,
                  suffixIcon: Icon(Icons.credit_card),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text('Telefone de Contato : ', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              TextField(
                controller: _cell,
                style: TextStyle(
                    fontSize: 18
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Digite o telefone do estacionamento',
                  errorText: _validateTelefone ? 'Digite um telefone' : null,
                  suffixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('Numero de vagas : ', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
              TextField(
                controller: _vagas,
                style: TextStyle(
                    fontSize: 18
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Digite o numero de vagas do estacionamento',
                  errorText: _validateTelefone ? 'Digite uma quantidade de vagas' : null,
                  suffixIcon: Icon(Icons.directions_car),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                child: ButtonApp2Park(
                  text: "Continuar",
                  onPressed: () async {
                    try {
                      bool valido = true;
                      List<String> errorList = List<String>();

                      if (_namePark.text.isEmpty) {
                        setState(() {
                          _namePark.text.isEmpty
                              ? _validateNome = true
                              : _validateNome = false;
                          _businessName.text.isEmpty
                              ? _validateFantasia = true
                              : _validateFantasia = false;
                          _cell.text.isEmpty
                              ? _validateTelefone = true
                              : _validateTelefone = false;
                          _doc.text.isEmpty
                              ? _validateDOC = true
                              : _validateDOC = false;
                          valido = false;
                          errorList.add('Digite o Nome corretamente');
                        });
                      }
                      if (_businessName.text.isEmpty) {
                        setState(() {
                          _namePark.text.isEmpty
                              ? _validateNome = true
                              : _validateNome = false;
                          _businessName.text.isEmpty
                              ? _validateFantasia = true
                              : _validateFantasia = false;
                          _cell.text.isEmpty
                              ? _validateTelefone = true
                              : _validateTelefone = false;
                          _doc.text.isEmpty
                              ? _validateDOC = true
                              : _validateDOC = false;
                          valido = false;
                          errorList.add('Digite a Razão Social corretamente');
                        });
                      }
                      if(_cell.text.isEmpty){
                        setState(() {
                          _namePark.text.isEmpty
                              ? _validateNome = true
                              : _validateNome = false;
                          _businessName.text.isEmpty
                              ? _validateFantasia = true
                              : _validateFantasia = false;
                          _cell.text.isEmpty
                              ? _validateTelefone = true
                              : _validateTelefone = false;
                          _doc.text.isEmpty
                              ? _validateDOC = true
                              : _validateDOC = false;
                          valido = false;
                          errorList.add('Digite o Telefone corretamente');
                        });
                      }
                      if(_doc.text.isEmpty) {
                        setState(() {
                          _namePark.text.isEmpty
                              ? _validateNome = true
                              : _validateNome = false;
                          _businessName.text.isEmpty
                              ? _validateFantasia = true
                              : _validateFantasia = false;
                          _cell.text.isEmpty
                              ? _validateTelefone = true
                              : _validateTelefone = false;
                          _doc.text.isEmpty
                              ? _validateDOC = true
                              : _validateDOC = false;
                          valido = false;
                          errorList.add('Digite o Documento corretamente');
                        });
                      }
                        if(!validaCpf(_doc.text)){
                          if(!validaCnpj(_doc.text)){
                            setState(() {
                              valido = false;
                              errorList.add('Documento inválido');
                            });
                            

                          }
                        }

                        if(valido){
                          if (_formKey.currentState.validate()) {

                            Navigator.of(context).pushNamed(
                                RegisterStreetParkViewRoute,
                                arguments: RegisterStreetParkArguments(
                                    _namePark.text, type, _businessName.text,_cell.text, _doc.text,_vagas.text));
                          } else {
                            setState(() {
                              errorList.add('Por favor, digite os dados corretamente');
                            });
                          }
                        }else{
                          alertModalsError(context, "Erro", errorList.toString());
                        }
                      

                    } catch (e) {
                      DateTime now = DateTime.now();
                      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO REGISTER PARK', 'APP');
                      LogDao logDao = LogDao();
                      logDao.saveLog(logOff);

                      alertModal(context, "Error", e.toString());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


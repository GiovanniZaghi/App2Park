import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:flutter/material.dart';

class Dados extends StatefulWidget {
  @override
  _DadosState createState() => _DadosState();
}

class _DadosState extends State<Dados> {
  bool table1 = false;
  bool isCheck = false;
  SharedPref sharedPref = SharedPref();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumo de Dados'),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: table1,
                onChanged: (bool value) {
                  setState(() {
                    table1 = value;
                    isCheck = value;
                    if(isCheck == true){
                      sharedPref.remove('dados');
                      sharedPref.save("dados", table1);
                    }else{
                      sharedPref.remove('dados');
                    }
                  });
                },
              ),
              Text(
                'Modo Economia de Dados',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Quando selecionando, não utiliza seu Pacote de Dados do celular!!para enviar grandes volumes de informações. Exemplos:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('- Fotos dos veículos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                    Text('- Registros de entrada e saída dos veículos',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Enviará apenas configurações do APP. Exemplos:',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                Text('- Mudanças na tabela de preços',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                Text('- Mudanças no horário de funcionamento',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                Text('- Mudanças nos dados do estacionamento',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                Text('- Mudanças nos colaboradores',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
                Text(
                  'Apenas envia e recebe informações quando conectado por Wi-Fi.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Importante',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Se não estiver conectado, muitas funcionalidades não estarão disponíveis.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'É muito importante que se conecte pelo menos uma vez por dia, para manter o aplicativo atualizado, e para que seus clientes recebam as fotos e informações sobre a utilização dos serviços do seu estacionamento.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

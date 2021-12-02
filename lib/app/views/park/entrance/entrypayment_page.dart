import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/nav/Nav.dart';
import 'package:app2park/app/views/park/entrance/entrance_exit_time.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:flutter/material.dart';

class EntryPayment extends StatefulWidget {
  @override
  _EntryPaymentState createState() => _EntryPaymentState();
}

class _EntryPaymentState extends State<EntryPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagamento Entrada'),backgroundColor: Color.fromRGBO(41, 202, 168, 3),),

      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonApp2Park(
            text: 'Pagar na Entrada',
            onPressed: (){
              Navigator.of(context).pushNamed(EntranceExitTimeViewRoute);
            },
          ),
          SizedBox(
            height: 35,
          ),
          ButtonApp2Park(
            text: 'Pagar na Saída',
            onPressed: (){
              Navigator.of(context).pushNamed(CheckTicketOffViewRoute);
            },
          )
        ],
      ),
    );
  }
}

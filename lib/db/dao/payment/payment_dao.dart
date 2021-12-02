import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/park/paymentOff/FormPaymenteOff.dart';
import 'package:sqflite/sqlite_api.dart';

class PaymentDao {
  static const String _tablePayment = 'forma_pagamento_estacionamento';
  static const String tablePayment = 'CREATE TABLE $_tablePayment('
      '$_pagamento_id_app INTEGER PRIMARY KEY AUTOINCREMENT , '
      '$_id TEXT, '
      '$_id_park TEXT,'
      '$_taxaf TEXT, '
      '$_taxav TEXT, '
      '$_valor TEXT,'
      '$_ordem TEXT,'
      '$_id_status TEXT);';

  static const String _id = 'forma_pagamento_id';
  static const String _pagamento_id_app = 'forma_pagamento_estacionamento_id';
  static const String _taxaf = 'taxa_fixa';
  static const String _taxav = 'taxa_variavel';
  static const String _valor = 'valor_minimo';
  static const String _ordem = 'ordem';
  static const String _id_park = 'id_park';
  static const String _id_status = 'id_status';

  Future<int> saveFormPayment(FormPaymentOff paymentOff) async {
    final Database db = await getDatabase();
    Map<String, dynamic> formPaymentMap = _toMapFormPayment(paymentOff);
    return db.insert(_tablePayment, formPaymentMap);

  }


  Future<List<FormPaymentOff>> findAllPayment() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablePayment);
    List<FormPaymentOff> formPayments = _toListFormPayment(result);
    return formPayments;
  }

  Map<String, dynamic> _toMapFormPayment(FormPaymentOff paymentOff) {
    final Map<String, dynamic> formPaymentMap = Map();
    formPaymentMap[_id_park] = paymentOff.id_park;
    formPaymentMap[_taxaf] = paymentOff.taxa_fixa;
    formPaymentMap[_taxav] = paymentOff.taxa_variavel;
    formPaymentMap[_valor] = paymentOff.valor_minimo;
    formPaymentMap[_ordem] = paymentOff.ordem;
    formPaymentMap[_id_status] = paymentOff.id_status;

    return formPaymentMap;
  }

  List<FormPaymentOff> _toListFormPayment(List<Map<String, dynamic>> result) {
    final List<FormPaymentOff> formPayments = List();
    for (Map<String, dynamic> row in result) {
      final FormPaymentOff formPayment = FormPaymentOff(
        row[_id_park],
        row[_taxaf],
        row[_taxav],
        row[_valor],
        row[_ordem],
        row[_id_status],
      );
      formPayments.add(formPayment);
    }
    return formPayments;
  }


}

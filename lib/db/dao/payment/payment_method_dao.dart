import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_off_model.dart';
import 'package:sqflite/sqlite_api.dart';

class PaymentMethodDao {
  static const String _tablePaymentsmethod = 'payments_method';
  static const String tablePaymentsMethod = 'CREATE TABLE $_tablePaymentsmethod('
      '$_id INTEGER, '
      '$_name TEXT,'
      '$_flatrate REAL, '
      '$_variablerate REAL, '
      '$_minvalue REAL,'
      '$_status INTEGER,'
      '$_sortorder INTEGER);';

  static const String _id = 'id';
  static const String _name = 'name';
  static const String _flatrate = 'flat_rate';
  static const String _variablerate = 'variable_rate';
  static const String _minvalue = 'min_value';
  static const String _status = 'status';
  static const String _sortorder = 'sort_order';

  Future<int> savePaymentMethod(PaymentMethodOffModel paymentMethodOffModel) async {
    final Database db = await getDatabase();
    Map<String, dynamic> paymentMethodOffMap = _toMapPaymentMethodOff(paymentMethodOffModel);
    return db.insert(_tablePaymentsmethod, paymentMethodOffMap);

  }

  Future<bool> verifyPaymentMethod(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tablePaymentsmethod,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }


  Future<List<PaymentMethodOffModel>> findAllPaymentMethod() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablePaymentsmethod);
    List<PaymentMethodOffModel> PaymentsMethodOffList = _toListPaymentMethodOff(result);
    return PaymentsMethodOffList;
  }

  Map<String, dynamic> _toMapPaymentMethodOff(PaymentMethodOffModel paymentMethodOffModel) {
    final Map<String, dynamic> PaymentMethodOffMap = Map();
    PaymentMethodOffMap[_id] = paymentMethodOffModel.id;
    PaymentMethodOffMap[_name] = paymentMethodOffModel.name;
    PaymentMethodOffMap[_flatrate] = paymentMethodOffModel.flat_rate;
    PaymentMethodOffMap[_variablerate] = paymentMethodOffModel.variable_rate;
    PaymentMethodOffMap[_minvalue] = paymentMethodOffModel.min_value;
    PaymentMethodOffMap[_status] = paymentMethodOffModel.status;
    PaymentMethodOffMap[_sortorder] = paymentMethodOffModel.sort_order;
    return PaymentMethodOffMap;
  }

  List<PaymentMethodOffModel> _toListPaymentMethodOff(List<Map<String, dynamic>> result) {
    final List<PaymentMethodOffModel> PaymentsMethodOffList = List();
    for (Map<String, dynamic> row in result) {
      final PaymentMethodOffModel paymentMethodOffModel = PaymentMethodOffModel(
        row[_id],
        row[_name],
        row[_flatrate],
        row[_variablerate],
        row[_minvalue],
        row[_status],
        row[_sortorder],
      );
      PaymentsMethodOffList.add(paymentMethodOffModel);
    }
    return PaymentsMethodOffList;
  }
}

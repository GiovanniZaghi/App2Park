import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/exit_payment_method_park.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_inner_join_payment_method_park_model.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_park_off_model.dart';
import 'package:app2park/moduleoff/payment/payment_method_park_inner.dart';
import 'package:sqflite/sqlite_api.dart';

class PaymentMethodParkDao {
  static const String _tablePaymentsmethodpark = 'payments_method_park';
  static const String tablePaymentsMethodPark = 'CREATE TABLE $_tablePaymentsmethodpark('
      '$_id INTEGER, '
      '$_idpark INTEGER,'
      '$_idpaymentmethod INTEGER,'
      '$_flatrate REAL, '
      '$_variablerate REAL, '
      '$_minvalue REAL,'
      '$_status INTEGER,'
      '$_sortorder INTEGER);';

  static const String _id = 'id';
  static const String _idpark = 'id_park';
  static const String _idpaymentmethod = 'id_payment_method';
  static const String _flatrate = 'flat_rate';
  static const String _variablerate = 'variable_rate';
  static const String _minvalue = 'min_value';
  static const String _status = 'status';
  static const String _sortorder = 'sort_order';

  Future<int> savePaymentMethodPark(PaymentMethodParkOffModel paymentMethodOffModel) async {
    final Database db = await getDatabase();
    Map<String, dynamic> paymentMethodParkOffMap = _toMapPaymentMethodParkOff(paymentMethodOffModel);
    return db.insert(_tablePaymentsmethodpark, paymentMethodParkOffMap);

  }

  Future<bool> verifyPaymentMethodPark(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tablePaymentsmethodpark,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }


  Future<List<PaymentMethodParkOffModel>> findAllPaymentMethodPark() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablePaymentsmethodpark);
    List<PaymentMethodParkOffModel> PaymentsMethodParkOffList = _toListPaymentMethodParkOff(result);
    return PaymentsMethodParkOffList;
  }
  Future<List<PaymentMethodParkInner>> getPaymentCash(
      int id_park) async {
    final Database db = await getDatabase();
    List<PaymentMethodParkInner> list = new List<PaymentMethodParkInner>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT P.*, N.name FROM payments_method_park AS P INNER JOIN payments_method AS N ON (P.id_payment_method = N.id) WHERE P.id_park = $id_park AND P.status = 1');
    dbList.forEach((itemMap) {
      list.add(PaymentMethodParkInner.fromJson(itemMap));
    });

    return list;
  }

  Map<String, dynamic> _toMapPaymentMethodParkOff(PaymentMethodParkOffModel paymentMethodParkOffModel) {
    final Map<String, dynamic> PaymentMethodParkOffMap = Map();
    PaymentMethodParkOffMap[_id] = paymentMethodParkOffModel.id;
    PaymentMethodParkOffMap[_idpark] = paymentMethodParkOffModel.id_park;
    PaymentMethodParkOffMap[_idpaymentmethod] = paymentMethodParkOffModel.id_payment_method;
    PaymentMethodParkOffMap[_flatrate] = paymentMethodParkOffModel.flat_rate;
    PaymentMethodParkOffMap[_variablerate] = paymentMethodParkOffModel.variable_rate;
    PaymentMethodParkOffMap[_minvalue] = paymentMethodParkOffModel.min_value;
    PaymentMethodParkOffMap[_status] = paymentMethodParkOffModel.status;
    PaymentMethodParkOffMap[_sortorder] = paymentMethodParkOffModel.sort_order;
    return PaymentMethodParkOffMap;
  }

  List<PaymentMethodParkOffModel> _toListPaymentMethodParkOff(List<Map<String, dynamic>> result) {
    final List<PaymentMethodParkOffModel> PaymentsMethodParkOffList = List();
    for (Map<String, dynamic> row in result) {
      final PaymentMethodParkOffModel paymentMethodParkOffModel = PaymentMethodParkOffModel(
        row[_id],
        row[_idpark],
        row[_idpaymentmethod],
        row[_flatrate],
        row[_variablerate],
        row[_minvalue],
        row[_status],
        row[_sortorder],
      );
      PaymentsMethodParkOffList.add(paymentMethodParkOffModel);
    }
    return PaymentsMethodParkOffList;
  }

  Future<List<PaymentMethodInnerJoinPaymentMethodPark>> getMethodParkInnerJoin(int id_park) async {
    final Database db = await getDatabase();
    List<PaymentMethodInnerJoinPaymentMethodPark> list = new List<PaymentMethodInnerJoinPaymentMethodPark>();
    List<Map<String, dynamic>> dbList = await db.rawQuery('SELECT A.name, S.status as st, P.id, P.id_park, P.id_payment_method, P.flat_rate, P.variable_rate, P.min_value, P.status, P.sort_order FROM payments_method_park AS P INNER JOIN payments_method AS A ON(P.id_payment_method = A.id) INNER JOIN status AS S ON(P.status = S.id) WHERE P.id_park = $id_park');
    print(dbList);
    dbList.forEach((itemMap) {
      list.add(PaymentMethodInnerJoinPaymentMethodPark.fromJson(itemMap));
    });
    return list;
  }

  Future<bool> updatePaymentMethodPark(int id, double flat_rate, double variable_rate, double min_value, int status, int sort_order) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE payments_method_park SET flat_rate = $flat_rate, variable_rate = $variable_rate, min_value = $min_value, status = $status, sort_order = $sort_order WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> SincupdatePaymentMethodPark(int id, double flat_rate, double variable_rate, double min_value, int status, int sort_order) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE payments_method_park SET flat_rate = $flat_rate, variable_rate = $variable_rate, min_value = $min_value, status = $status, sort_order = $sort_order WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<List<ExitPaymentMethodPark>> getPaymentsMethodFilter(
      int id_park) async {
    final Database db = await getDatabase();
    List<ExitPaymentMethodPark> list = new List<ExitPaymentMethodPark>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT P.*, M.name FROM payments_method_park AS P INNER JOIN payments_method AS M ON(P.id_payment_method = M.id) WHERE P.status = 1 AND P.id_park = $id_park ORDER BY P.sort_order ASC');
    dbList.forEach((itemMap) {
      list.add(ExitPaymentMethodPark.fromJson(itemMap));
    });
    return list;
  }
}

import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/cashier/movement/cash_movement_off_model.dart';
import 'package:app2park/moduleoff/dashboard_money_graphics.dart';
import 'package:sqflite/sqflite.dart';

class CashMovementDao {
  static const String _tableCashMovement = 'cash_movement';
  static const String tableCashMovement = 'CREATE TABLE $_tableCashMovement('
      '$_id INTEGER NULL, '
      '$_id_cash INTEGER NULL, '
      '$_id_cash_app INTEGER, '
      '$_id_ticket INTEGER, '
      '$_id_agreement INTEGER NULL, '
      '$_id_cash_movement_app INTEGER PRIMARY KEY,'
      '$_id_ticket_app INTEGER, '
      '$_id_agreement_app INTEGER NULL, '
      '$_date_added TEXT, '
      '$_id_cash_type_movement INTEGER ,'
      '$_id_payment_method INTEGER,'
      '$_id_price_detached INTEGER,'
      '$_id_price_detached_app INTEGER,'
      '$_value_initial TEXT,'
      '$_value TEXT, '
      '$_comment TEXT );';

  static const String _id = 'id';
  static const String _id_cash = 'id_cash';
  static const String _id_cash_app = 'id_cash_app';
  static const String _id_ticket = 'id_ticket';
  static const String _id_agreement = 'id_agreement';
  static const String _id_cash_movement_app = 'id_cash_movement_app';
  static const String _id_ticket_app = 'id_ticket_app';
  static const String _id_agreement_app = 'id_agreement_app';
  static const String _date_added = 'date_added';
  static const String _id_cash_type_movement = 'id_cash_type_movement';
  static const String _id_payment_method = 'id_payment_method';
  static const String _id_price_detached = 'id_price_detached';
  static const String _id_price_detached_app = 'id_price_detached_app';
  static const String _value_initial = 'value_initial';
  static const String _value = 'value';
  static const String _comment = 'comment';


  Future<int> saveCashMovement(CashMovementOff cashMovement) async {
    final Database db = await getDatabase();
    Map<String, dynamic> cashMovementMap = _toMapCash(cashMovement);
    return db.insert(_tableCashMovement, cashMovementMap);
  }

  Future<List<CashMovementOff>> findAllCash() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(_tableCashMovement);
    List<CashMovementOff> cashMovements = _toListCashMovement(result);
    return cashMovements;
  }

  Future<bool> verifyCashMovement(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableCashMovement,
        columns: ['id'], where: 'id = ?', whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateCashMovement(int id, int id_cash_movement_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE cash_movement SET id = $id WHERE id_cash_movement_app = $id_cash_movement_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<int> getCashByUser(int id_user, int id_park) async {
    final Database db = await getDatabase();
    return Sqflite.firstIntValue(await db.rawQuery(
        'SELECT id_cash_app FROM (SELECT c.id_park, c.id_user, m.id_cash_app, MAX(m.id_cash_type_movement) AS status FROM cash_movement AS m LEFT JOIN cashs AS c ON c.id_cash_app = m.id_cash_app GROUP BY m.id_cash_app HAVING status <> 6 AND c.id_user = $id_user AND c.id_park = $id_park) AS result'));
  }

  Future<int> getCashByUserON(int id_cash_app) async {
    final Database db = await getDatabase();
    return Sqflite.firstIntValue(await db
        .rawQuery('SELECT id FROM cashs WHERE id_cash_app = $id_cash_app'));
  }

  Future<int> getCashByPark(int id_park) async {
    final Database db = await getDatabase();
    return Sqflite.firstIntValue(await db.rawQuery(
        'SELECT id_cash_app FROM (SELECT c.id_park, c.id_user, m.id_cash_app, MAX(m.id_cash_type_movement) AS status FROM cash_movement AS m LEFT JOIN cashs AS c ON c.id_cash_app = m.id_cash_app GROUP BY m.id_cash_app HAVING status <> 6 AND c.id_park = $id_park) AS result'));
  }

  Future<List<CashMovementOff>> getCashMovementByIdCash(int id_cash) async {
    final Database db = await getDatabase();
    List<CashMovementOff> list = new List<CashMovementOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM cash_movement WHERE id_cash_app = $id_cash ORDER BY id_cash_movement_app DESC LIMIT 1');
    dbList.forEach((itemMap) {
      list.add(CashMovementOff.fromJson(itemMap));
    });
    return list;
  }

  Future<List<CashMovementOff>> getCashMovementOffSincByIdCashApp(
      int id_cash_app) async {
    final Database db = await getDatabase();
    List<CashMovementOff> list = new List<CashMovementOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM cash_movement WHERE id_cash_app = $id_cash_app ORDER BY id_cash_movement_app');
    dbList.forEach((itemMap) {
      list.add(CashMovementOff.fromJson(itemMap));
    });
    return list;
  }

  Future<List<DashboardMoneyGraphics>> dashBoardMovementDay(
      int id_park) async {
    final Database db = await getDatabase();
    List<DashboardMoneyGraphics> list = new List<DashboardMoneyGraphics>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT T.id, T.name AS tipo, M.id_cash_type_movement, P.name as pagamento, SUM(M.value) AS value FROM cash_movement AS M LEFT JOIN cash_type_movement AS T ON (T.id = M.id_cash_type_movement)'
        ' LEFT JOIN payments_method AS P ON (P.id = M.id_payment_method)'
        ' LEFT JOIN cashs AS C ON (C.id_cash_app = M.id_cash_app)'
        ' WHERE DATE(m.date_added) = DATE("now")'
        ' AND C.id_park = $id_park'
        ' AND T.id = 2'
        ' GROUP BY M.id_cash_type_movement, M.id_payment_method');
    dbList.forEach((itemMap) {
      list.add(DashboardMoneyGraphics.fromJson(itemMap));
    });
    return list;
  }

  Map<String, dynamic> _toMapCash(CashMovementOff cashMovement) {
    final Map<String, dynamic> cashMovementMap = Map();
    cashMovementMap['id'] = cashMovement.id;
    cashMovementMap['id_cash'] = cashMovement.id_cash;
    cashMovementMap['id_cash_app'] = cashMovement.id_cash_app;
    cashMovementMap['id_ticket'] = cashMovement.id_ticket;
    cashMovementMap['id_agreement'] = cashMovement.id_agreement;
    cashMovementMap['id_cash_movement_app'] = cashMovement.id_cash_movement_app;
    cashMovementMap['id_ticket_app'] = cashMovement.id_ticket_app;
    cashMovementMap['id_agreement_app'] = cashMovement.id_agreement_app;
    cashMovementMap['date_added'] = cashMovement.date_added;
    cashMovementMap['id_cash_type_movement'] =
        cashMovement.id_cash_type_movement;
    cashMovementMap['id_payment_method'] = cashMovement.id_payment_method;
    cashMovementMap['id_price_detached'] = cashMovement.id_price_detached;
    cashMovementMap['id_price_detached_app'] = cashMovement.id_price_detached_app;
    cashMovementMap['value_initial'] = cashMovement.value_initial;
    cashMovementMap['value'] = cashMovement.value;
    cashMovementMap['comment'] = cashMovement.comment;
    return cashMovementMap;
  }

  List<CashMovementOff> _toListCashMovement(List<Map<String, dynamic>> result) {
    final List<CashMovementOff> cashMovements = List();
    for (Map<String, dynamic> row in result) {
      final CashMovementOff cashMovement = CashMovementOff(
          row['id'],
          row['id_cash'],
          row['id_cash_app'],
          row['id_ticket'],
          row['id_ticket_app'],
          row['id_agreement'],
          row['id_agreement_app'],
          row['date_added'],
          row['id_cash_type_movement'],
          row['id_payment_method'],
          row['id_price_detached'],
          row['id_price_detached_app'],
          row['value_initial'],
          row['value'],
          row['comment']);
      cashMovements.add(cashMovement);
    }
    return cashMovements;
  }
}

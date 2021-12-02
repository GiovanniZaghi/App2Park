import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/cashier/type/cash_type_movement_inner_off_model.dart';
import 'package:app2park/moduleoff/cashier/type/cash_type_movement_off_model.dart';
import 'package:app2park/moduleoff/cashier/type/cash_type_resumo_off_model.dart';
import 'package:app2park/moduleoff/cashier/type/cash_type_relatorio_model.dart';
import 'package:sqflite/sqflite.dart';

class CashTypeMovementDao {
  static const String _tableCashTypeMovement = 'cash_type_movement';
  static const String tableCashTypeMovement = 'CREATE TABLE $_tableCashTypeMovement('
      '$_id INTEGER , '
      '$_name TEXT );';

  static const String _id = 'id';
  static const String _name = 'name';


  Future<int> saveCashType(CashTypeMovementOff cashType) async {
    final Database db = await getDatabase();
    Map<String, dynamic> cashTypeMap = _toMapCashType(cashType);
    return db.insert(_tableCashTypeMovement, cashTypeMap);
  }


  Future<List<CashTypeMovementOff>> findAllCashType() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableCashTypeMovement);
    List<CashTypeMovementOff> cashTypes = _toListCashType(result);
    return cashTypes;
  }

  Future<List<CashTypeMovementInnerOff>> getCashierByIdParkIdUser(
      int id_park, int id_user) async {
    final Database db = await getDatabase();
    List<CashTypeMovementInnerOff> list = new List<CashTypeMovementInnerOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        "SELECT c.id_cash_app, c.id_user, u.first_name, u.last_name, a.date_added AS abertura, f.date_added AS fechamento FROM `cashs` c LEFT JOIN (SELECT * FROM cash_movement WHERE id_cash_type_movement = 1) a ON (a.id_cash_app = c.`id_cash_app`) LEFT JOIN (SELECT * FROM cash_movement WHERE id_cash_type_movement = 6) f ON (f.id_cash_app = c.`id_cash_app`) LEFT JOIN user u ON (u.id = c.id_user) WHERE id_park = $id_park AND c.`id_user` = $id_user ORDER BY abertura DESC");
    dbList.forEach((itemMap) {
      list.add(CashTypeMovementInnerOff.fromJson(itemMap));
    });
    return list;
  }

  Future<List<CashTypeMovementInnerOff>> getCashierByIdUser(int id_park) async {
    final Database db = await getDatabase();
    List<CashTypeMovementInnerOff> list = new List<CashTypeMovementInnerOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        "SELECT c.id_cash_app, c.id_user, u.first_name, u.last_name, a.date_added AS abertura, f.date_added AS fechamento FROM `cashs` c LEFT JOIN (SELECT * FROM cash_movement WHERE id_cash_type_movement = 1) a ON (a.id_cash_app = c.`id_cash_app`) LEFT JOIN (SELECT * FROM cash_movement WHERE id_cash_type_movement = 6) f ON (f.id_cash_app = c.`id_cash_app`) LEFT JOIN user u ON (u.id = c.id_user) WHERE id_park = $id_park ORDER BY abertura DESC");
    dbList.forEach((itemMap) {
      list.add(CashTypeMovementInnerOff.fromJson(itemMap));
    });
    return list;
  }

  Future<List<CashTypeResumoOff>> getCashierResumo(int id_cash_app) async {
    final Database db = await getDatabase();
    List<CashTypeResumoOff> list = new List<CashTypeResumoOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        "SELECT m.id_cash_type_movement, t.name, m.id_payment_method, p.name AS pagamento,  SUM(m.value) AS value FROM cash_movement m LEFT JOIN cash_type_movement t ON t.id = m.id_cash_type_movement LEFT JOIN payments_method p ON p.id = m.id_payment_method WHERE id_cash_app = $id_cash_app GROUP BY m.id_cash_type_movement, m.id_payment_method");
    dbList.forEach((itemMap) {
      list.add(CashTypeResumoOff.fromJson(itemMap));
    });
    return list;
  }

  Future<List<CashTypeRelatorioOff>> getCashierRelatorio(int id_cash_app) async {
    final Database db = await getDatabase();
    List<CashTypeRelatorioOff> list = new List<CashTypeRelatorioOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        "SELECT m.id, m.id_cash_app, m.date_added, m.id_cash_type_movement, t.name, m.comment, m.value, m.id_ticket, m.id_payment_method, p.name AS pagamento FROM cash_movement m LEFT JOIN cash_type_movement t ON t.id = m.id_cash_type_movement LEFT JOIN payments_method p ON p.id = m.id_payment_method WHERE m.id_cash_app = $id_cash_app ORDER BY m.id_cash_movement_app");
    dbList.forEach((itemMap) {
      list.add(CashTypeRelatorioOff.fromJson(itemMap));
    });
    return list;
  }

  Future<bool> verifyCashTypeById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableCashTypeMovement,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }


  Map<String, dynamic> _toMapCashType(CashTypeMovementOff cashType) {
    final Map<String, dynamic> cashTypeMap = Map();
    cashTypeMap['id'] = cashType.id;
    cashTypeMap['name'] = cashType.name;
    return cashTypeMap;
  }

  List<CashTypeMovementOff> _toListCashType(List<Map<String, dynamic>> result) {
    final List<CashTypeMovementOff> cashTypes = List();
    for (Map<String, dynamic> row in result) {
      final CashTypeMovementOff cash = CashTypeMovementOff(
          row['id'],
          row['name']
      );
      cashTypes.add(cash);
    }
    return cashTypes;
  }

}

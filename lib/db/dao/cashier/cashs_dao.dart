import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/cashier/cashs_off_model.dart';
import 'package:sqflite/sqflite.dart';

class CashsDao {
  static const String _tableCashs = 'cashs';
  static const String tableCashs = 'CREATE TABLE $_tableCashs('
      '$_id INTEGER NULL, '
      '$_id_cash_app INTEGER PRIMARY KEY, '
      '$_id_park INTEGER ,'
      '$_id_user INTEGER);';

  static const String _id = 'id';
  static const String _id_cash_app = 'id_cash_app';
  static const String _id_park = 'id_park';
  static const String _id_user = 'id_user';

  Future<int> saveCash(CashsOff cash) async {
    final Database db = await getDatabase();
    Map<String, dynamic> cashsMap = _toMapCash(cash);
    return db.insert(_tableCashs, cashsMap);
  }

  Future<bool> updateCashs(int id, int id_cash_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE cashs SET id = $id WHERE id_cash_app = $id_cash_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> verifyCashs(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableCashs,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<int> getsCashs(int id) async {
    final Database db = await getDatabase();
    return Sqflite.firstIntValue(await db.rawQuery('SELECT id_cash_app FROM cashs WHERE id = "$id"'));
  }


  Future<List<CashsOff>> findAllCash() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableCashs);
    List<CashsOff> cashs = _toListCash(result);
    return cashs;
  }

  Future<List<CashsOff>> getCashInfo(int id_park, int id_user) async {
    final Database db = await getDatabase();
    List<CashsOff> list = new List<CashsOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM cashs WHERE id_park = $id_park AND id_user = $id_user ORDER BY id DESC LIMIT 1');
    dbList.forEach((itemMap) {
      list.add(CashsOff.fromJson(itemMap));
    });
    return list;
  }

  Future<List<CashsOff>> getCashOffSinc() async {
    final Database db = await getDatabase();
    List<CashsOff> list = new List<CashsOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM cashs WHERE id = 0 ORDER BY id_cash_app');
    dbList.forEach((itemMap) {
      list.add(CashsOff.fromJson(itemMap));
    });
    return list;
  }


  Map<String, dynamic> _toMapCash(CashsOff cash) {
    final Map<String, dynamic> cashMap = Map();
    cashMap['id'] = cash.id;
    cashMap['id_cash_app'] = cash.id_cash_app;
    cashMap['id_park'] = cash.id_park;
    cashMap['id_user'] = cash.id_user;
    return cashMap;
  }

  List<CashsOff> _toListCash(List<Map<String, dynamic>> result) {
    final List<CashsOff> cashs = List();
    for (Map<String, dynamic> row in result) {
      final CashsOff cash = CashsOff(
        row['id'],
        row['id_park'],
        row['id_user']
      );
      cashs.add(cash);
    }
    return cashs;
  }

}

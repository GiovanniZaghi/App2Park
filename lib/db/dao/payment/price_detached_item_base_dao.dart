import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/payment/priceitembase/price_detached_item_base_off_model.dart';
import 'package:sqflite/sqlite_api.dart';

class PriceDetachedItemBaseDao {
  static const String _tablePriceDetachedItemBase = 'price_detached_item_base';
  static const String tablePriceDetachedItemBase = 'CREATE TABLE $_tablePriceDetachedItemBase('
      '$_id INTEGER, '
      '$_name TEXT,'
      '$_time TEXT, '
      '$_type TEXT, '
      '$_level INTEGER, '
      '$_id_status INTEGER );';

  static const String _id = 'id';
  static const String _name = 'name';
  static const String _time = 'time';
  static const String _type  = 'type';
  static const String _level  = 'level';
  static const String _id_status = 'id_status';

  Future<int> savePriceDetachedItem(PriceDetachedItemBaseOff priceItemBase) async {
    final Database db = await getDatabase();
    Map<String, dynamic> priceItemBaseMap = _toMapPriceItem(priceItemBase);
    return db.insert(_tablePriceDetachedItemBase, priceItemBaseMap);
  }

  Future<bool> verifyPriceItemBaseById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tablePriceDetachedItemBase,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<List<PriceDetachedItemBaseOff>> findAllPriceDetachedItem() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablePriceDetachedItemBase);
    List<PriceDetachedItemBaseOff> priceItemsBase = _toListPriceItemBase(result);
    return priceItemsBase;
  }

  Map<String, dynamic> _toMapPriceItem(PriceDetachedItemBaseOff priceItemBase) {
    final Map<String, dynamic> priceItemBaseMap = Map();
    priceItemBaseMap['id'] = priceItemBase.id;
    priceItemBaseMap['name'] = priceItemBase.name;
    priceItemBaseMap['time'] = priceItemBase.time;
    priceItemBaseMap['type'] = priceItemBase.type;
    priceItemBaseMap['level'] = priceItemBase.level;
    priceItemBaseMap['id_status'] = priceItemBase.id_status;


    return priceItemBaseMap;
  }

  List<PriceDetachedItemBaseOff> _toListPriceItemBase(List<Map<String, dynamic>> result) {
    final List<PriceDetachedItemBaseOff> priceItemsBase = List();
    for (Map<String, dynamic> row in result) {
      final PriceDetachedItemBaseOff priceItemBase = PriceDetachedItemBaseOff(
        row['id'],
        row['name'],
        row['time'],
        row['type'],
        row['level'],
        row['id_status'],
      );
      priceItemsBase.add(priceItemBase);
    }
    return priceItemsBase;
  }


}

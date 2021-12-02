import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/payment/price_item_inner_join_item_base.dart';
import 'package:app2park/moduleoff/payment/priceitem/price_detached_item_off_model.dart';
import 'package:sqflite/sqlite_api.dart';

class PriceDetachedItemDao {
  static const String _tablePriceDetachedItem = 'price_detached_item';
  static const String tablePriceDetachedItem =
      'CREATE TABLE $_tablePriceDetachedItem('
      '$_id INTEGER NULL, '
      '$_id_price_detached_item_app INTEGER PRIMARY KEY,'
      '$_id_price_detached INTEGER NULL, '
      '$_id_price_detached_app INTEGER NULL, '
      '$_id_price_detached_item_base INTEGER, '
      '$_price REAL,'
      '$_tolerance TEXT);';

  static const String _id = 'id';
  static const String _id_price_detached_item_app =
      'id_price_detached_item_app';
  static const String _id_price_detached = 'id_price_detached';
  static const String _id_price_detached_app = 'id_price_detached_app';
  static const String _id_price_detached_item_base =
      'id_price_detached_item_base';
  static const String _tolerance = 'tolerance ';
  static const String _price = 'price ';

  Future<int> savePriceDetachedItem(PriceDetachedItemOff priceItem) async {
    final Database db = await getDatabase();
    Map<String, dynamic> priceItemMap = _toMapPriceItem(priceItem);
    return db.insert(_tablePriceDetachedItem, priceItemMap);
  }

  Future<List<PriceDetachedItemOff>> findAllPriceDetachedItem() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(_tablePriceDetachedItem);
    List<PriceDetachedItemOff> priceItems = _toListPriceItem(result);
    return priceItems;
  }

  Future<bool> verifyPriceDetachedItem(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tablePriceDetachedItem,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<List<PriceDetachedItemOff>> sincPriceDetachedItemSend(
      int id_price_detached) async {
    final Database db = await getDatabase();
    List<PriceDetachedItemOff> list = new List<PriceDetachedItemOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM price_detached_item WHERE id_price_detached = $id_price_detached');
    dbList.forEach((itemMap) {
      list.add(PriceDetachedItemOff.fromJson(itemMap));
    });
    return list;
  }

  Future<List<PriceDetachedItemOff>> sincPriceDetachedItemSendPriceDetachedApp(
      int id_price_detached_App) async {
    final Database db = await getDatabase();
    List<PriceDetachedItemOff> list = new List<PriceDetachedItemOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM price_detached_item WHERE id_price_detached_app = $id_price_detached_App');
    dbList.forEach((itemMap) {
      list.add(PriceDetachedItemOff.fromJson(itemMap));
    });
    return list;
  }


  Future<List<PriceItemInnerJoinBase>> getPriceInnerJoin(
      int id_price_detached_app) async {
    final Database db = await getDatabase();
    List<PriceItemInnerJoinBase> list = new List<PriceItemInnerJoinBase>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT I.id_price_detached_item_app ,B.id, B.name, I.price, I.tolerance, B.type, B.level, (B.id = I.id_price_detached_item_base)'
            ' AS tickado FROM price_detached_item_base AS B LEFT JOIN '
            '(SELECT * FROM price_detached_item WHERE id_price_detached_app = $id_price_detached_app) AS I ON '
            '(B.id = I.id_price_detached_item_base)');
    dbList.forEach((itemMap) {
      list.add(PriceItemInnerJoinBase.fromJson(itemMap));
    });
    return list;
  }

  Future<List<PriceDetachedItemOff>> getPriceDetachedItemId(
      int id_price_detached_item_app) async {
    final Database db = await getDatabase();
    List<PriceDetachedItemOff> list = new List<PriceDetachedItemOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM price_detached_item WHERE id_price_detached_item_app = $id_price_detached_item_app');
    dbList.forEach((itemMap) {
      list.add(PriceDetachedItemOff.fromJson(itemMap));
    });
    return list;
  }

  Future<bool> updatePriceDetachedItem(int id_price_detached_item_app, double price, String tolerance) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE price_detached_item SET price = $price, tolerance = "$tolerance" WHERE id_price_detached_item_app = $id_price_detached_item_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> updatePriceDetachedItemSincro(int id, double price, String tolerance) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE price_detached_item SET price = $price, tolerance = "$tolerance" WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> updatePriceDetachedItemSinc(int id ,int id_price_detached_item_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE price_detached_item SET id = $id WHERE id_price_detached_item_app = $id_price_detached_item_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<void> deletePriceDetachedItemSinc(int id_price_detached) async {
    final Database db = await getDatabase();
    await db.delete(
      'price_detached_item',
      where: "id_price_detached = ?",
      whereArgs: [id_price_detached],
    );
  }

  Future<void> deletePriceDetachedItem(int id_price_detached_item_app) async {
    final Database db = await getDatabase();
    await db.delete(
      'price_detached_item',
      where: "id_price_detached_item_app = ?",
      whereArgs: [id_price_detached_item_app],
    );
  }

  Map<String, dynamic> _toMapPriceItem(PriceDetachedItemOff priceItem) {
    final Map<String, dynamic> priceItemMap = Map();
    priceItemMap['id'] = priceItem.id;
    priceItemMap['id_price_detached_item_app'] =
        priceItem.id_price_detached_item_app;
    priceItemMap['id_price_detached'] = priceItem.id_price_detached;
    priceItemMap['id_price_detached_app'] = priceItem.id_price_detached_app;
    priceItemMap['id_price_detached_item_base'] =
        priceItem.id_price_detached_item_base;
    priceItemMap['price'] = priceItem.price;
    priceItemMap['tolerance'] = priceItem.tolerance;

    return priceItemMap;
  }

  List<PriceDetachedItemOff> _toListPriceItem(
      List<Map<String, dynamic>> result) {
    final List<PriceDetachedItemOff> priceItems = List();
    for (Map<String, dynamic> row in result) {
      final PriceDetachedItemOff priceItem = PriceDetachedItemOff(
        row['id'],
        row['id_price_detached'],
        row['id_price_detached_app'],
        row['id_price_detached_item_base'],
        row['price'],
        row['tolerance'],
      );
      priceItems.add(priceItem);
    }
    return priceItems;
  }
}

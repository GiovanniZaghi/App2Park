import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_inner_model.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_model.dart';
import 'package:app2park/moduleoff/payment/price_item_inner_join_vehicles.dart';
import 'package:sqflite/sqlite_api.dart';

class PriceDetachedDao {
  static const String _tablePriceDetached = 'price_detached';
  static const String tablePriceDetached = 'CREATE TABLE $_tablePriceDetached('
      '$_id INTEGER NULL, '
      '$_id_price_detached_app INTEGER PRIMARY KEY,'
      '$_id_park INTEGER, '
      '$_name TEXT, '
      '$_daily_start TEXT, '
      '$_id_vehicle_type INTEGER,'
      '$_id_status INTEGER,'
      '$_cash INTEGER,'
      '$_data_sinc TEXT,'
      '$_sort_order INTEGER);';

  static const String _id = 'id';
  static const String _id_park = 'id_park';
  static const String _name = 'name';
  static const String _daily_start = 'daily_start';
  static const String _id_vehicle_type = 'id_vehicle_type';
  static const String _sort_order = 'sort_order';
  static const String _id_price_detached_app = 'id_price_detached_app';
  static const String _id_status = 'id_status';
  static const String _data_sinc = 'data_sinc';
  static const String _cash = 'cash';

  Future<int> savePriceDetached(PriceDetachedOff price) async {
    final Database db = await getDatabase();
    Map<String, dynamic> priceMap = _toMapPrice(price);
    return db.insert(_tablePriceDetached, priceMap);
  }

  Future<List<PriceDetachedOff>> findAllDetached() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(_tablePriceDetached);
    List<PriceDetachedOff> prices = _toListPrice(result);
    return prices;
  }

  Future<List<PriceDetachedOff>> getPriceDetachedSinc(
      int id_price_detached) async {
    final Database db = await getDatabase();
    List<PriceDetachedOff> list =
    new List<PriceDetachedOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM price_detached WHERE id = $id_price_detached');

    dbList.forEach((itemMap) {
      list.add(PriceDetachedOff.fromJson(itemMap));
    });
    return list;
  }

  Future<List<PriceDetachedOff>> getPriceDetachedSincSend() async {
    final Database db = await getDatabase();
    List<PriceDetachedOff> list =
    new List<PriceDetachedOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM price_detached WHERE id = 0');
    print(dbList);
    dbList.forEach((itemMap) {
      list.add(PriceDetachedOff.fromJson(itemMap));
    });
    return list;
  }

  Future<bool> verifyPriceDetached(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tablePriceDetached,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<List<PriceDetachedOff>> getPriceDetached(int id_park) async {
    final Database db = await getDatabase();
    List<PriceDetachedOff> list = new List<PriceDetachedOff>();
    List<Map<String, dynamic>> dbList =
        await db.rawQuery('SELECT *'
            ' FROM price_detached'
            ' WHERE id_park = $id_park');
    dbList.forEach((itemMap) {
      list.add(PriceDetachedOff.fromJson(itemMap));
    });

    return list;
  }
  Future<bool> verifyInsertPrice(String name, int id_park) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tablePriceDetached,
        columns: ['id_price_detached_app'],
        where: 'name = ? AND id_park = ?',
        whereArgs: ['$name', '$id_park']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<List<PriceItemInnerJoinVehicles>> getPriceInnerJoinVehicles(
      int id_park) async {
    final Database db = await getDatabase();
    List<PriceItemInnerJoinVehicles> list =
        new List<PriceItemInnerJoinVehicles>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT V.type, P.id, P.id_price_detached_app, P.id_park, P.name, P.daily_start, P.id_vehicle_type, P.cash, P.id_status, S.status, P.sort_order '
        'FROM price_detached AS P INNER JOIN vehicle_type AS V ON(P.id_vehicle_type =  V.id) '
        'INNER JOIN status AS S ON(P.id_status = S.id) '
        'WHERE P.id_park = $id_park');
    print(dbList);
    dbList.forEach((itemMap) {
      list.add(PriceItemInnerJoinVehicles.fromJson(itemMap));
    });
    return list;
  }

  Future<List<PriceDetachedInnerJoinOff>> getOrderPriceInnerJoin(int id_vehicle_type, int id_park) async {
    final Database db = await getDatabase();
    List<PriceDetachedInnerJoinOff> list =
        new List<PriceDetachedInnerJoinOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery('SELECT * FROM '
        '(SELECT p.*, t.type FROM price_detached p '
        'LEFT JOIN vehicle_type t ON p.id_vehicle_type = t.id '
        'WHERE id_vehicle_type = $id_vehicle_type '
        'AND id_status = 1 '
        'AND cash = 1 '
        'AND id_park = $id_park '
        'ORDER BY sort_order, id_vehicle_type,name) AS a '
        'UNION ALL '
        'SELECT * FROM '
        '(SELECT p.*, t.type FROM price_detached p '
        'LEFT JOIN vehicle_type t ON p.id_vehicle_type = t.id '
        'WHERE id_vehicle_type != $id_vehicle_type '
        'AND id_status = 1 '
        'AND cash = 1 '
        'AND id_park = $id_park '
        'ORDER BY sort_order, id_vehicle_type,name) AS b');
    print(dbList);
    dbList.forEach((itemMap) {
      list.add(PriceDetachedInnerJoinOff.fromJson(itemMap));
    });
    return list;
  }

  Future<bool> updatePriceDetached(int id_price_detached_app, String name, String daily_start,
      int id_vehicle_type, int id_status, int cash, int sort_order, String data_sinc) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE price_detached SET name = "$name", daily_start = "$daily_start", id_vehicle_type = "$id_vehicle_type", id_status = "$id_status", cash = "$cash", sort_order = "$sort_order", data_sinc = "$data_sinc"  WHERE id_price_detached_app = $id_price_detached_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateDateSincP(int id_price_detached_app, String data_sinc) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE price_detached SET data_sinc = "$data_sinc"  WHERE id_price_detached_app = $id_price_detached_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }


  Future<bool> updatePriceDetachedSincro(int id, String name, String daily_start,
      int id_vehicle_type, int id_status, int cash, int sort_order, String data_sinc) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE price_detached SET name = "$name", daily_start = "$daily_start", id_vehicle_type = "$id_vehicle_type", id_status = "$id_status", cash = "$cash", sort_order = "$sort_order", data_sinc = "$data_sinc"  WHERE id = $id');
    if (ids > 0) {
      return true;
    }
    return false;
  }


  Future<bool> updatePriceDetachedSinc(int id, int id_price_detached_app, String name, String daily_start,
      int id_vehicle_type, int id_status, int cash, int sort_order, String data_sinc) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE price_detached SET id = $id, name = "$name", daily_start = "$daily_start", id_vehicle_type = "$id_vehicle_type", id_status = "$id_status", cash = "$cash", sort_order = "$sort_order", data_sinc = "$data_sinc" WHERE id_price_detached_app = $id_price_detached_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updatePriceDetachedSincSend(int id, int id_price_detached_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE price_detached SET id = $id WHERE id_price_detached_app = $id_price_detached_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updatePriceDetachedItemSincSend(int id_price_detached, int id_price_detached_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE price_detached_item SET id_price_detached = $id_price_detached WHERE id_price_detached_app = $id_price_detached_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapPrice(PriceDetachedOff price) {
    final Map<String, dynamic> priceMap = Map();
    priceMap['id'] = price.id;
    priceMap['id_price_detached_app'] = price.id_price_detached_app;
    priceMap['id_park'] = price.id_park;
    priceMap['name'] = price.name;
    priceMap['daily_start'] = price.daily_start;
    priceMap['id_vehicle_type'] = price.id_vehicle_type;
    priceMap['id_status'] = price.id_status;
    priceMap['cash'] = price.cash;
    priceMap['sort_order'] = price.sort_order;
    priceMap['data_sinc'] = price.data_sinc;
    return priceMap;
  }

  List<PriceDetachedOff> _toListPrice(List<Map<String, dynamic>> result) {
    final List<PriceDetachedOff> prices = List();
    for (Map<String, dynamic> row in result) {
      final PriceDetachedOff price = PriceDetachedOff(
        row['id'],
        row['id_park'],
        row['name'],
        row['daily_start'],
        row['id_vehicle_type'],
        row['id_status'],
        row['cash'],
        row['sort_order'],
        row['data_sinc']
      );
      prices.add(price);
    }
    return prices;
  }
}

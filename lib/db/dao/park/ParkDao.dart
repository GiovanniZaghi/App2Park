import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/park/ParkOff.dart';
import 'package:app2park/moduleoff/park/park_off_join.dart';
import 'package:sqflite/sqflite.dart';

class ParkDao {
  static const String _tablePark = 'park';
  static const String tablePark = 'CREATE TABLE $_tablePark('
      'id TEXT, '
      'type TEXT,'
      'doc TEXT, '
      'name_park TEXT, '
      'business_name TEXT, '
      'cell TEXT, '
      'photo TEXT NULL, '
      'postal_code TEXT, '
      'street TEXT, '
      'number TEXT, '
      'complement TEXT NULL, '
      'neighborhood TEXT, '
      'city TEXT, '
      'state TEXT,'
      'country TEXT,'
      'vacancy TEXT, '
      'subscription TEXT,'
      'id_status TEXT,'
      'date_added TEXT,'
      'date_edited TEXT NULL );';

  Future<int> savePark(ParkOff park) async {
    final Database db = await getDatabase();
    Map<String, dynamic> parkMap = _toMapPark(park);
    return db.insert(_tablePark, parkMap);
  }

  Future<bool> verifyPark(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tablePark,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }


  Future<List<ParkOff>> findAllPark() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tablePark);
    List<ParkOff> parks = _toListPark(result);
    return parks;
  }

  Future<List<ParkOff>> findAllParksByUserId(
      int id_user) async {
    final Database db = await getDatabase();
    List<ParkOff> list = new List<ParkOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT P.* FROM park_user AS U INNER JOIN park AS P ON(U.id_park = P.id) WHERE U.id_user = $id_user AND U.id_status = 1');
    dbList.forEach((itemMap) {
      list.add(ParkOff.fromJson(itemMap));
    });
    return list;
  }


  Future<List<ParkOffJoin>> findAllParksbyCart(
      int id_user) async {
    final Database db = await getDatabase();
    List<ParkOffJoin> list = new List<ParkOffJoin>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT P.*, 0 as tickado FROM park_user AS U INNER JOIN park AS P ON(U.id_park = P.id) WHERE U.id_user = $id_user AND U.id_office < 3 AND U.id_status = 1');
    dbList.forEach((itemMap) {
      list.add(ParkOffJoin.fromJson(itemMap));
    });
    return list;
  }


  Future<bool> getParkById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tablePark,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<ParkOff> getParksByIdPark(int id_park) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tablePark,
        columns: ['id, name_park, doc, business_name, postal_code, street, number, city, state, country, photo, date_added, id_status'],
        where: 'id = ?',
        whereArgs: [id_park]);

    if (result.length > 0) {
      return new ParkOff.fromJson(result.first);
    }
    return null;
  }

  Future<bool> updateSubscriptionPark(String id, String subscription) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE park SET subscription = "$subscription" WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapPark(ParkOff park) {
    final Map<String, dynamic> parkMap = Map();
    parkMap['id'] = park.id;
    parkMap['type'] = park.type;
    parkMap['doc'] = park.doc;
    parkMap['name_park'] = park.name_park;
    parkMap['business_name'] = park.business_name;
    parkMap['cell'] = park.cell;
    parkMap['photo'] = park.photo;
    parkMap['postal_code'] = park.postal_code;
    parkMap['street'] = park.street;
    parkMap['number'] = park.number;
    parkMap['complement'] = park.complement;
    parkMap['neighborhood'] = park.neighborhood;
    parkMap['city'] = park.city;
    parkMap['state'] = park.state;
    parkMap['country'] = park.country;
    parkMap['vacancy'] = park.vacancy;
    parkMap['subscription'] = park.subscription;
    parkMap['id_status'] = park.id_status;
    parkMap['date_added'] = park.date_added;
    parkMap['date_edited'] = park.date_edited;
    return parkMap;
  }


  List<ParkOff> _toListPark(List<Map<String, dynamic>> result) {
    final List<ParkOff> parks = List();
    for (Map<String, dynamic> row in result) {
      final ParkOff park = ParkOff(
        row['id'],
        row['type'],
        row['doc'],
        row['name_park'],
        row['business_name'],
        row['cell'],
        row['photo'],
        row['postal_code'],
        row['street'],
        row['number'],
        row['complement'],
        row['neighborhood'],
        row['city'],
        row['state'],
        row['country'],
        row['vacancy'],
        row['subscription'],
        row['id_status'],
        row['data_added'],
        row['data_edited'],

      );
      parks.add(park);
    }
    return parks;
  }

}

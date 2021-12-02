import 'package:app2park/db/database.dart';
import 'package:app2park/module/puser/invite_object_select.dart';
import 'package:app2park/moduleoff/puser/park_user_off_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ParkUserDao{
  static const String _tableParkUser = 'park_user';
  static const String tableParkUser = 'CREATE TABLE $_tableParkUser('
      '$_id INTEGER, '
      '$_id_park INTEGER,'
      '$_id_user INTEGER, '
      '$_id_office INTEGER,'
      '$_id_status INTEGER,'
      '$_keyval TEXT NULL,'
      '$_date_added TEXT,'
      '$_date_edited TEXT NULL);';

  static const String _id = 'id';
  static const String _id_park = 'id_park';
  static const String _id_user = 'id_user';
  static const String _id_office = 'id_office';
  static const String _id_status = 'id_status';
  static const String _keyval = 'keyval';
  static const String _date_added = 'date_added';
  static const String _date_edited = 'date_edited';

  Future<int> saveParkUser(ParkUserOff pUser) async {
    final Database db = await getDatabase();
    Map<String, dynamic> parkUserMap = _toMapParkUser(pUser);
    return db.insert(_tableParkUser, parkUserMap);

  }

  Future<bool> verifyPuser(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableParkUser,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateParkUser(int id, int id_status, int id_office) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE park_user SET id_status = $id_status, id_office = $id_office WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> SincupdateParkUser(int id, int id_status, int id_office) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE park_user SET id_status = $id_status, id_office = $id_office WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<List<ParkUserOff>> getCargoInformation(
      int id_park, int id_user) async {
    final Database db = await getDatabase();
    List<ParkUserOff> list = new List<ParkUserOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM park_user WHERE id_park = $id_park AND id_user = $id_user');
    dbList.forEach((itemMap) {
      list.add(ParkUserOff.fromJson(itemMap));
    });
    return list;
  }

  Future<List<InviteObjectSelect>> getAllsInvite(
      int id_park, int id_status) async {
    final Database db = await getDatabase();
    List<InviteObjectSelect> list = new List<InviteObjectSelect>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT P.id, P.id_office, P.id_user, P.id_park, P.id_status, U.first_name, U.cell, U.email, U.last_name, O.office FROM park_user AS P INNER JOIN user AS U ON(P.id_user = U.id) INNER JOIN offices AS O ON(P.id_office = O.id) WHERE P.id_park = $id_park AND P.id_status = $id_status');
    dbList.forEach((itemMap) {
      list.add(InviteObjectSelect.fromJson(itemMap));

    });
    return list;
  }


  Future<List<ParkUserOff>> findAllParkUser() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableParkUser);
    List<ParkUserOff> parkUsers = _toListParkUser(result);
    return parkUsers;
  }
  Map<String, dynamic> _toMapParkUser(ParkUserOff pUser) {
    final Map<String, dynamic> parkUserMap = Map();
    parkUserMap['id'] = pUser.id;
    parkUserMap['id_park'] = pUser.id_park;
    parkUserMap['id_user'] = pUser.id_user;
    parkUserMap['id_office'] = pUser.id_office;
    parkUserMap['id_status'] = pUser.id_status;
    parkUserMap['keyval'] = pUser.keyval;
    parkUserMap['date_added'] = pUser.date_added;
    parkUserMap['date_edited'] = pUser.date_edited;

    return parkUserMap;
  }

  List<ParkUserOff> _toListParkUser(List<Map<String, dynamic>> result) {
    final List<ParkUserOff> pUsers = List();
    for (Map<String, dynamic> row in result) {
      final ParkUserOff pUser = ParkUserOff(
        row['id'],
        row['id_park'],
        row['id_user'],
        row['id_office'],
        row['id_status'],
        row['keyval'],
        row['date_added'],
        row['date_edited'],
      );
      pUsers.add(pUser);
    }
    return pUsers;
  }
}
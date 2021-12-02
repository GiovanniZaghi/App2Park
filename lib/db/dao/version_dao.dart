import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/version_off.dart';
import 'package:sqflite/sqflite.dart';

class VersionDao {
  static const String _tableVersion = 'version';
  static const String tableVersion = 'CREATE TABLE $_tableVersion('
      '$_id INTEGER, '
      '$_name TEXT ,'
      '$_id_status INTEGER);';

  static const String _id = 'id';
  static const String _name = 'name';
  static const String _id_status = 'id_status';

  Future<int> saveVersion(VersionOff version) async {
    final Database db = await getDatabase();
    Map<String, dynamic> versionMap = _toMapVersion(version);
    return db.insert(_tableVersion, versionMap);
  }

  Future<bool> updateVersion(int id, int id_status) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE version SET id_status = $id_status WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> verifyVersion(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableVersion,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }


  Future<List<VersionOff>> getVersionInfo() async {
    final Database db = await getDatabase();
    List<VersionOff> list = new List<VersionOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM version WHERE id_status = 1');
    dbList.forEach((itemMap) {
      list.add(VersionOff.fromJson(itemMap));
    });
    return list;
  }

  Map<String, dynamic> _toMapVersion(VersionOff version) {
    final Map<String, dynamic> versionMap = Map();
    versionMap['id'] = version.id;
    versionMap['name'] = version.name;
    versionMap['id_status'] = version.id_status;
    return versionMap;
  }

  List<VersionOff> _toListVersion(List<Map<String, dynamic>> result) {
    final List<VersionOff> versionList = List();
    for (Map<String, dynamic> row in result) {
      final VersionOff version = VersionOff(
          row['id'],
          row['name'],
          row['id_status']
      );
      versionList.add(version);
    }
    return versionList;
  }
}

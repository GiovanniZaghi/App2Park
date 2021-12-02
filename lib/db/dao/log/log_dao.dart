import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:sqflite/sqlite_api.dart';

class LogDao{
  static const String _tableLogs = 'log';
  static const String tableLogs = 'CREATE TABLE $_tableLogs('
      '$_id_mob INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_id TEXT NULL, '
      '$_id_user TEXT NULL,'
      '$_id_park TEXT NULL,'
      '$_error TEXT NULL,'
      '$_version TEXT NULL,'
      '$_created TEXT NULL,'
      '$_screen_error TEXT NULL,'
      '$_platform INTEGER NULL);';

  static const String _id_mob = 'id_mob';
  static const String _id = 'id';
  static const String _id_user = 'id_user';
  static const String _id_park = 'id_park';
  static const String _error = 'error';
  static const String _version = 'version';
  static const String _created = 'created';
  static const String _screen_error = 'screen_error';
  static const String _platform = 'platform';

  Future<int> saveLog(LogOff log) async {
    final Database db = await getDatabase();
    Map<String, dynamic> logMap = _toMapLog(log);
    return db.insert(_tableLogs, logMap);

  }

  Future<List<LogOff>> findAllLog() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableLogs);
    List<LogOff> logs = _toListLog(result);
    return logs;
  }
  Future<bool> verifyLog(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableLogs,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<void> deleteLog(int id_mob) async {
    final Database db = await getDatabase();
    await db.delete(
      'log',
      where: "id_mob = ?",
      whereArgs: [id_mob],
    );
  }

  Future<List<LogOff>> getLogNoSincronized() async {
    final Database db = await getDatabase();
    List<LogOff> list = new List<LogOff>();
    List<Map<String, dynamic>> dbList = await db
        .rawQuery('SELECT * FROM log WHERE id = 0');
    dbList.forEach((itemMap) {
      list.add(LogOff.fromJson(itemMap));
    });
    return list;
  }

  Map<String, dynamic> _toMapLog(LogOff log) {
    final Map<String, dynamic> logMap = Map();
    logMap['id_mob'] = log.id_mob;
    logMap['id'] = log.id;
    logMap['id_user'] = log.id_user;
    logMap['id_park'] = log.id_park;
    logMap['error'] = log.error;
    logMap['version'] = log.version;
    logMap['created'] = log.created;
    logMap['screen_error'] = log.screen_error;
    logMap['platform'] = log.platform;

    return logMap;
  }

  List<LogOff> _toListLog(List<Map<String, dynamic>> result) {
    final List<LogOff> logs = List();
    for (Map<String, dynamic> row in result) {
      final LogOff log = LogOff(
        row['id'] as String,
        row['id_user'] as String,
        row['id_park'] as String,
        row['error'] as String,
        row['version'] as String,
        row['created'] as String,
        row['screen_error'] as String,
        row['platform'] as String,
      );
      logs.add(log);
    }
    return logs;
  }

}
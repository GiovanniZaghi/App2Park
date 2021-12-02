import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/status/status_off_model.dart';
import 'package:sqflite/sqlite_api.dart';

class StatusDao{
  static const String _tableStatus = 'status';
  static const String tableStatus = 'CREATE TABLE $_tableStatus('
      '$_id INTEGER, '
      '$_status TEXT );';

  static const String _id = 'id';
  static const String _status = 'status';

  Future<int> saveStatus(StatusOff status) async {
    final Database db = await getDatabase();
    Map<String, dynamic> statusMap = _toMapOffice(status);
    return db.insert(_tableStatus, statusMap);

  }

  Future<List<StatusOff>> findAllStatus() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableStatus);
    List<StatusOff> status = _toListStatus(result);
    return status;
  }

  Future<bool> verifyStatus(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableStatus,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }


  Map<String, dynamic> _toMapOffice(StatusOff status) {
    final Map<String, dynamic> statusMap = Map();
    statusMap['id'] = status.id;
    statusMap['status'] = status.status;

    return statusMap;
  }

  List<StatusOff> _toListStatus(List<Map<String, dynamic>> result) {
    final List<StatusOff> status = List();
    for (Map<String, dynamic> row in result) {
      final StatusOff statusOff = StatusOff(
        row['id'],
        row['status'],

      );
      status.add(statusOff);
    }
    return status;
  }

}
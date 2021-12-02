import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/office/office_off_model.dart';
import 'package:sqflite/sqlite_api.dart';

class OfficeDao{
  static const String _tableOffices = 'offices';
  static const String tableOffices = 'CREATE TABLE $_tableOffices('
      '$_id INTEGER, '
      '$_office TEXT );';

  static const String _id = 'id';
  static const String _office = 'office';

  Future<int> saveOffice(OfficeOff office) async {
    final Database db = await getDatabase();
    Map<String, dynamic> officeMap = _toMapOffice(office);
    return db.insert(_tableOffices, officeMap);

  }

  Future<List<OfficeOff>> findAllOffices() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableOffices);
    List<OfficeOff> offices = _toListOffice(result);
    return offices;
  }
  Future<bool> verifyOffice(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableOffices,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapOffice(OfficeOff office) {
    final Map<String, dynamic> officeMap = Map();
    officeMap['id'] = office.id;
    officeMap['office'] = office.office;

    return officeMap;
  }

  List<OfficeOff> _toListOffice(List<Map<String, dynamic>> result) {
    final List<OfficeOff> offices = List();
    for (Map<String, dynamic> row in result) {
      final OfficeOff office = OfficeOff(
        row['id'] as int,
        row['office'] as String,

      );
      offices.add(office);
    }
    return offices;
  }

}
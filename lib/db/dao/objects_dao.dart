import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/objects_off_model.dart';
import 'package:sqflite/sqflite.dart';

class ObjectsDao {

  static const String _tableObjects = 'objects';
  static const String tableObjects = 'CREATE TABLE $_tableObjects('
      '$_id INTEGER, '
      '$_name TEXT, '
      '$_sort_order INTEGER);';

  static const String _id = 'id';
  static const String _name = 'name';
  static const String _sort_order = 'sort_order';

  Future<int> saveObjects(ObjectsOffModel objects) async {
    final Database db = await getDatabase();
    Map<String, dynamic> objectsMap = _toMapObjects(objects);
    return db.insert(_tableObjects, objectsMap);
  }

  Future<List<ObjectsOffModel>> findAllObjects() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableObjects);
    List<ObjectsOffModel> objectsList = _toListObjects(result);
    return objectsList;
  }

  Future<bool> verifyObjects(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableObjects,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapObjects(ObjectsOffModel objects) {
    final Map<String, dynamic> objectsMap = Map();
    objectsMap['id'] = objects.id;
    objectsMap['name'] = objects.name;
    objectsMap['sort_order'] = objects.sort_order;
    return objectsMap;
  }

  List<ObjectsOffModel> _toListObjects(List<Map<String, dynamic>> result) {
    final List<ObjectsOffModel> objectsList = List();
    for (Map<String, dynamic> row in result) {
      final ObjectsOffModel objects = ObjectsOffModel(
          row['id'],
          row['name'],
          row['sort_order'],
      );
      objectsList.add(objects);
    }
    return objectsList;
  }
}
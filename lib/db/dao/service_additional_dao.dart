import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/service_additional_off_model.dart';
import 'package:sqflite/sqflite.dart';

class ServiceAdditionalDao {

  static const String _tableServiceAdditional = 'service_additional';
  static const String tableServiceAdditional = 'CREATE TABLE $_tableServiceAdditional('
      '$_id INTEGER, '
      '$_name TEXT, '
      '$_id_vehicle_type INTEGER, '
      '$_sort_order INTEGER);';

  static const String _id = 'id';
  static const String _name = 'name';
  static const String _id_vehicle_type = 'id_vehicle_type';
  static const String _sort_order = 'sort_order';

  Future<int> saveServiceAdditional(ServiceAdditionalOffModel serviceAdditional) async {
    final Database db = await getDatabase();
    Map<String, dynamic> serviceAdditionalMap = _toMapServiceAdditional(serviceAdditional);
    return db.insert(_tableServiceAdditional, serviceAdditionalMap);
  }

  Future<List<ServiceAdditionalOffModel>> findAllServiceAdditional() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableServiceAdditional);
    List<ServiceAdditionalOffModel> serviceAdditionalList = _toListServiceAdditional(result);
    return serviceAdditionalList;
  }

  Future<bool> verifyServiceAdditional(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableServiceAdditional,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapServiceAdditional(ServiceAdditionalOffModel serviceAdditional) {
    final Map<String, dynamic> serviceAdditionalMap = Map();
    serviceAdditionalMap['id'] = serviceAdditional.id;
    serviceAdditionalMap['name'] = serviceAdditional.name;
    serviceAdditionalMap['id_vehicle_type'] = serviceAdditional.id_vehicle_type;
    serviceAdditionalMap['sort_order'] = serviceAdditional.sort_order;
    return serviceAdditionalMap;
  }

  List<ServiceAdditionalOffModel> _toListServiceAdditional(List<Map<String, dynamic>> result) {
    final List<ServiceAdditionalOffModel> serviceAdditionalList = List();
    for (Map<String, dynamic> row in result) {
      final ServiceAdditionalOffModel serviceAdditional = ServiceAdditionalOffModel(
        row['id'],
        row['name'],
        row['id_vehicle_type'],
        row['sort_order'],
      );
      serviceAdditionalList.add(serviceAdditional);
    }
    return serviceAdditionalList;
  }
}
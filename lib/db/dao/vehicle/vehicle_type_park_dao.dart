import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_innerjoin_typepark.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_park_off_model.dart';
import 'package:sqflite/sqflite.dart';

class VehicleTypeParkDao {
  static const String _tableVehicleParkType = 'vehicle_type_park';
  static const String tableVehicleParkType = 'CREATE TABLE $_tableVehicleParkType('
      '$_id INTEGER, '
      '$_id_vehicle_type INTEGER, '
      '$_id_park INTEGER, '
      '$_status INTEGER, '
      '$_sort_order INTEGER);';

  static const String _id = 'id';
  static const String _id_vehicle_type = 'id_vehicle_type';
  static const String _id_park = 'id_park';
  static const String _status = 'status';
  static const String _sort_order = 'sort_order';

  Future<int> saveVehicleType(VehicleTypeParkOffModel vehicleTypeParkOffModel) async {
    final Database db = await getDatabase();
    Map<String, dynamic> vehicleTypeParkOffModelMap = _toMapVehicleTypeParkOffModel(vehicleTypeParkOffModel);
    return db.insert(_tableVehicleParkType, vehicleTypeParkOffModelMap);
  }

  Future<List<VehicleTypeParkOffModel>> findAllTypeVehicle() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableVehicleParkType);
    List<VehicleTypeParkOffModel> vehicleTypeParkOffModelList = _toListVehicleTypeParkOffModel(result);
    return vehicleTypeParkOffModelList;
  }
  Future<bool> verifyVehicleTypeParkOffModelById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableVehicleParkType,
        columns: ['$_id'],
        where: '$_id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {

      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapVehicleTypeParkOffModel(VehicleTypeParkOffModel vehicleTypeParkOffModel) {
    final Map<String, dynamic> vehicleTypeParkOffModelMap = Map();
    vehicleTypeParkOffModelMap[_id] = vehicleTypeParkOffModel.id;
    vehicleTypeParkOffModelMap[_id_vehicle_type] = vehicleTypeParkOffModel.id_vehicle_type;
    vehicleTypeParkOffModelMap[_id_park] = vehicleTypeParkOffModel.id_park;
    vehicleTypeParkOffModelMap[_status] = vehicleTypeParkOffModel.status;
    vehicleTypeParkOffModelMap[_sort_order] = vehicleTypeParkOffModel.sort_order;
    return vehicleTypeParkOffModelMap;
  }

  List<VehicleTypeParkOffModel> _toListVehicleTypeParkOffModel(List<Map<String, dynamic>> result) {
    final List<VehicleTypeParkOffModel> vehicleTypeParkModelList = List();
    for (Map<String, dynamic> row in result) {
      final VehicleTypeParkOffModel vehicleTypeParkOffModel = VehicleTypeParkOffModel(
        row[_id],
        row[_id_vehicle_type],
        row[_id_park],
        row[_status],
        row[_sort_order]
      );
      vehicleTypeParkModelList.add(vehicleTypeParkOffModel);
    }
    return vehicleTypeParkModelList;
  }

  Future<List<VehicleTypeInnerjoinTypePark>> getAllVehicleTypeParkJoin(int id_park) async {
    final Database db = await getDatabase();
    List<VehicleTypeInnerjoinTypePark> list = new List<VehicleTypeInnerjoinTypePark>();
    List<Map<String, dynamic>> dbList = await db.rawQuery('SELECT V.type, S.id, S.id_vehicle_type, S.id_park, S.status, S.sort_order FROM vehicle_type_park AS S INNER JOIN vehicle_type AS V ON (S.id_vehicle_type = V.id) WHERE S.id_park = $id_park AND S.status = 1');
    print(dbList);
    dbList.forEach((itemMap) {
      list.add(VehicleTypeInnerjoinTypePark.fromJson(itemMap));
    });
    return list;
  }


  Future<List<VehicleTypeInnerjoinTypePark>> getAllVehicleTypeInnerJoinTypePark(int id_park) async {
    final Database db = await getDatabase();
      List<VehicleTypeInnerjoinTypePark> list = new List<VehicleTypeInnerjoinTypePark>();
      List<Map<String, dynamic>> dbList = await db.rawQuery('SELECT V.type, S.id, S.id_vehicle_type, S.id_park, S.status, S.sort_order FROM vehicle_type_park AS S INNER JOIN vehicle_type AS V ON (S.id_vehicle_type = V.id) WHERE id_park = $id_park');
      print(dbList);
      dbList.forEach((itemMap) {
        list.add(VehicleTypeInnerjoinTypePark.fromJson(itemMap));
      });
      return list;
  }

  Future<bool> updateVehicleTypePark(int id, int status) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE vehicle_type_park SET status = $status WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> SincupdateVehicleTypePark(int id, int status, int sort_order) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE vehicle_type_park SET status = $status, sort_order = $sort_order WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }
}

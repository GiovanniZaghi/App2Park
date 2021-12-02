import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_off_model.dart';
import 'package:sqflite/sqflite.dart';

class VehicleTypeDao {
  static const String _tableVehicleType = 'vehicle_type';
  static const String tableVehicleType = 'CREATE TABLE $_tableVehicleType('
      '$_id INTEGER, '
      '$_type TEXT);';

  static const String _id = 'id';
  static const String _type = 'type';

  Future<int> saveVehicleTypeOffModel(VehicleTypeOffModel vehicleTypeOffModel) async {
    final Database db = await getDatabase();
    Map<String, dynamic> vehicleTypeOffModelMap = _toMapVehicleTypeModelOff(vehicleTypeOffModel);
    return db.insert(_tableVehicleType, vehicleTypeOffModelMap);
  }

  Future<List<VehicleTypeOffModel>> findAllVehicleTypeModelOff() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableVehicleType);
    List<VehicleTypeOffModel> vehicleTypeOffModelList = _toListVehicleTypeOffModel(result);
    return vehicleTypeOffModelList;
  }

   Future<bool> verifyVehicleTypeOffModelById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableVehicleType,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapVehicleTypeModelOff(VehicleTypeOffModel vehicleTypeOffModel) {
    final Map<String, dynamic> vehicleTypeOffModelMap = Map();
    vehicleTypeOffModelMap[_id] = vehicleTypeOffModel.id;
    vehicleTypeOffModelMap[_type] = vehicleTypeOffModel.type;
    return vehicleTypeOffModelMap;
  }

  List<VehicleTypeOffModel> _toListVehicleTypeOffModel(List<Map<String, dynamic>> result) {
    final List<VehicleTypeOffModel> vehicleTypeOffModelList = List();
    for (Map<String, dynamic> row in result) {
      final VehicleTypeOffModel vehicleTypeOffModel = VehicleTypeOffModel(
        row[_id],
        row[_type],
      );
      vehicleTypeOffModelList.add(vehicleTypeOffModel);
    }
    return vehicleTypeOffModelList;
  }
}

import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/vehicles/vehicles_off_model.dart';
import 'package:sqflite/sqflite.dart';

class VehiclesDao {

  static const String _tableVehicles = 'vehicles';
  static const String tableVehicles = 'CREATE TABLE $_tableVehicles('
      '$_id INTEGER NULL, '
      '$_id_vehicle_app INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_id_vehicle_type INTEGER, '
      '$_maker TEXT NULL, '
      '$_model TEXT NULL, '
      '$_color TEXT NULL, '
      '$_plate TEXT, '
      '$_year TEXT NULL);';

  static const String _id = 'id';
  static const String _id_vehicle_app = 'id_vehicle_app';
  static const String _id_vehicle_type = 'id_vehicle_type';
  static const String _maker = 'maker';
  static const String _model = 'model';
  static const String _color = 'color';
  static const String _plate = 'plate';
  static const String _year= 'year';

  Future<int> saveVehicles(VehiclesOffModel vehicles) async {
    final Database db = await getDatabase();
    Map<String, dynamic> vehiclesMap = _toMapVehicles(vehicles);
    return db.insert(_tableVehicles, vehiclesMap);
  }

  Future<List<VehiclesOffModel>> findAllVehicles() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableVehicles);
    List<VehiclesOffModel> vehiclesList = _toListVehicles(result);
    return vehiclesList;
  }

  Future<int> getVehicleByPlateSincOn(String plate) async {
    final Database db = await getDatabase();
    return Sqflite.firstIntValue(await db.rawQuery('SELECT id_vehicle_app FROM vehicles WHERE plate = "$plate"'));
  }

  Future<bool> verifyVehicles(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableVehicles,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateVehicles(int id, String maker, String model, String color, String year, int id_vehicle_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate("UPDATE vehicles SET id = $id, maker = '$maker', model = '$model', color = '$color', year = '$year' WHERE id_vehicle_app = $id_vehicle_app");
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<VehiclesOffModel> getVehicleByPlate(String plate) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableVehicles,
        columns: [ _id, _id_vehicle_app, _id_vehicle_type, _maker, _model, _color, _plate, _year],
        where: 'plate = ?',
        whereArgs: [plate]);

    if (result.length > 0) {
      return new VehiclesOffModel.fromJson(result.first);
    }
    return null;
  }

  Future<VehiclesOffModel> getVehicleById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableVehicles,
        columns: [ _id, _id_vehicle_app, _id_vehicle_type, _maker, _model, _color, _plate, _year],
        where: 'id_vehicle_app = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new VehiclesOffModel.fromJson(result.first);
    }
    return null;
  }

  Map<String, dynamic> _toMapVehicles(VehiclesOffModel vehicles) {
    final Map<String, dynamic> vehiclesMap = Map();
    vehiclesMap['id'] = vehicles.id;
    vehiclesMap['id_vehicle_app'] = vehicles.id_vehicle_app;
    vehiclesMap['id_vehicle_type'] = vehicles.id_vehicle_type;
    vehiclesMap['maker'] = vehicles.maker;
    vehiclesMap['model'] = vehicles.model;
    vehiclesMap['color'] = vehicles.color;
    vehiclesMap['plate'] = vehicles.plate;
    vehiclesMap['year'] = vehicles.year;
    return vehiclesMap;
  }

  List<VehiclesOffModel> _toListVehicles(List<Map<String, dynamic>> result) {
    final List<VehiclesOffModel> vehiclesList = List();
    for (Map<String, dynamic> row in result) {
      final VehiclesOffModel vehicles = VehiclesOffModel(
          row['id'],
          row['id_vehicle_type'],
          row['maker'],
          row['model'],
          row['color'],
          row['plate'],
          row['year']
      );
      vehiclesList.add(vehicles);
    }
    return vehiclesList;
  }
}
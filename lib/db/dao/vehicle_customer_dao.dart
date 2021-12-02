import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/customer_app_ss.dart';
import 'package:app2park/moduleoff/vehicle_app_ss.dart';
import 'package:app2park/moduleoff/vehicle_customer_off_model.dart';
import 'package:app2park/moduleoff/vehicle_inner_join_customer_model.dart';
import 'package:sqflite/sqflite.dart';

class VehicleCustomerDao {

  static const String _tableVehicleCustomer = 'vehicle_customer';
  static const String tableVehicleCustomer = 'CREATE TABLE $_tableVehicleCustomer('
      '$_id INTEGER NULL, '
      '$_id_vehicle_customer_app INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_id_customer INTEGER NULL, '
      '$_id_customer_app INTEGER, '
      '$_id_vehicle INTEGER NULL, '
      '$_id_vehicle_app INTEGER);';

  static const String _id = 'id';
  static const String _id_vehicle_customer_app = 'id_vehicle_customer_app';
  static const String _id_customer = 'id_customer';
  static const String _id_customer_app = 'id_customer_app';
  static const String _id_vehicle = 'id_vehicle';
  static const String _id_vehicle_app = 'id_vehicle_app';

  Future<int> saveVehicleCustomer(VehicleCustomerOffModel vehicleCustomer) async {
    final Database db = await getDatabase();
    Map<String, dynamic> vehicleCustomerMap = _toMapVehicleCustomer(vehicleCustomer);
    return db.insert(_tableVehicleCustomer, vehicleCustomerMap);
  }

  Future<List<VehicleCustomerOffModel>> findAllVehicleCustomer() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableVehicleCustomer);
    List<VehicleCustomerOffModel> vehicleCustomerList = _toListVehicleCustomer(result);
    return vehicleCustomerList;
  }

  Future<bool> verifyVehicleCustomer(int id_customer, int id_vehicle) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableVehicleCustomer,
        columns: ['id'],
        where: 'id_customer = ? AND id_vehicle = ?',
        whereArgs: ['$id_customer','$id_vehicle']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateVehicleCustomer(int id, int id_vehicle_customer_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE vehicle_customer SET id = $id WHERE id_vehicle_customer_app = $id_vehicle_customer_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<List<VehicleAppSS>> getvehicleapp(int id) async {
    final Database db = await getDatabase();
    List<VehicleAppSS> list = new List<VehicleAppSS>();
    List<Map<String, dynamic>> dbList = await db.rawQuery('SELECT id_vehicle_app FROM vehicles WHERE id = $id LIMIT 1');
    print(dbList);
    dbList.forEach((itemMap) {
      list.add(VehicleAppSS.fromJson(itemMap));
    });
    return list;
  }

  Future<List<CustomerAppSS>> getcustomerapp(int id) async {
    final Database db = await getDatabase();
    List<CustomerAppSS> list = new List<CustomerAppSS>();
    List<Map<String, dynamic>> dbList = await db.rawQuery('SELECT id_customer_app FROM customers WHERE id =$id LIMIT 1');
    print(dbList);
    dbList.forEach((itemMap) {
      list.add(CustomerAppSS.fromJson(itemMap));
    });
    return list;
  }

  Future<List<VehicleInnerJoinCustomer>> getCustomersJoinVehicles(int id_vehicle_app) async {
    final Database db = await getDatabase();
    List<VehicleInnerJoinCustomer> list = new List<VehicleInnerJoinCustomer>();
    List<Map<String, dynamic>> dbList = await db.rawQuery('SELECT C.id, C.id_customer_app, C.cell, C.email, C.name, C.doc, C.id_status FROM vehicle_customer AS V INNER JOIN customers AS C ON(V.id_customer_app = C.id_customer_app) WHERE V.id_vehicle_app = $id_vehicle_app');
    print(dbList);
    dbList.forEach((itemMap) {
      list.add(VehicleInnerJoinCustomer.fromJson(itemMap));
    });
    return list;
  }

  Map<String, dynamic> _toMapVehicleCustomer(VehicleCustomerOffModel vehicleCustomer) {
    final Map<String, dynamic> vehicleCustomerMap = Map();
    vehicleCustomerMap['id'] = vehicleCustomer.id;
    vehicleCustomerMap['id_vehicle_customer_app'] = vehicleCustomer.id_vehicle_customer_app;
    vehicleCustomerMap['id_customer'] = vehicleCustomer.id_customer;
    vehicleCustomerMap['id_customer_app'] = vehicleCustomer.id_customer_app;
    vehicleCustomerMap['id_vehicle'] = vehicleCustomer.id_vehicle;
    vehicleCustomerMap['id_vehicle_app'] = vehicleCustomer.id_vehicle_app;
    return vehicleCustomerMap;
  }

  List<VehicleCustomerOffModel> _toListVehicleCustomer(List<Map<String, dynamic>> result) {
    final List<VehicleCustomerOffModel> vehicleCustomerList = List();
    for (Map<String, dynamic> row in result) {
      final VehicleCustomerOffModel vehicleCustomer = VehicleCustomerOffModel(
          row['id'],
          row['id_customer'],
          row['id_customer_app'],
          row['id_vehicle'],
          row['id_vehicle_app']
      );
      vehicleCustomerList.add(vehicleCustomer);
    }
    return vehicleCustomerList;
  }
}
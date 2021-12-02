import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/customer/customers_off_model.dart';
import 'package:sqflite/sqflite.dart';

class CustomersDao {

  static const String _tableCustomers = 'customers';
  static const String tableCustomers = 'CREATE TABLE $_tableCustomers('
      '$_id INTEGER NULL, '
      '$_id_customer_app INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_cell TEXT NULL, '
      '$_email TEXT NULL, '
      '$_name TEXT NULL, '
      '$_doc TEXT NULL, '
      '$_id_status INTEGER);';

  static const String _id = 'id';
  static const String _id_customer_app = 'id_customer_app';
  static const String _cell = 'cell';
  static const String _email = 'email';
  static const String _name = 'name';
  static const String _doc = 'doc';
  static const String _id_status = 'id_status';

  Future<int> saveCustomers(CustomersOffModel customers) async {
    final Database db = await getDatabase();
    Map<String, dynamic> customersMap = _toMapCustomers(customers);
    return db.insert(_tableCustomers, customersMap);
  }

  Future<CustomersOffModel> getCustomerById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableCustomers,
        columns: [ _id, _id_customer_app, _cell, _email, _name, _doc, _id_status],
        where: 'id_customer_app = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new CustomersOffModel.fromJson(result.first);
    }
    return null;
  }

  Future<List<CustomersOffModel>> findAllCustomers() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableCustomers);
    List<CustomersOffModel> customersList = _toListCustomers(result);
    return customersList;
  }

  Future<bool> verifyCustomer(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableCustomers,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<int> getCustomerApp(int id) async {
    final Database db = await getDatabase();
    return Sqflite.firstIntValue(await db.rawQuery('SELECT id_customer_app FROM customers WHERE id = "$id"'));
  }


  Future<bool> updateCustomers(int id, int id_customer_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE customers SET id = $id WHERE id_customer_app = $id_customer_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapCustomers(CustomersOffModel customers) {
    final Map<String, dynamic> customersMap = Map();
    customersMap['id'] = customers.id;
    customersMap['id_customer_app'] = customers.id_customer_app;
    customersMap['cell'] = customers.cell;
    customersMap['email'] = customers.email;
    customersMap['name'] = customers.name;
    customersMap['doc'] = customers.doc;
    customersMap['id_status'] = customers.id_status;
    return customersMap;
  }

  List<CustomersOffModel> _toListCustomers(List<Map<String, dynamic>> result) {
    final List<CustomersOffModel> customersList = List();
    for (Map<String, dynamic> row in result) {
      final CustomersOffModel customers = CustomersOffModel(
          row['id'],
          row['cell'],
          row['email'],
          row['name'],
          row['doc'],
          row['id_status']
      );
      customersList.add(customers);
    }
    return customersList;
  }
}
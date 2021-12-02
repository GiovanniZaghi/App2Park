import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/subscription/subscription_off_model.dart';
import 'package:sqflite/sqflite.dart';

class SubscriptionDao {

  static const String _tableSubscription = 'subscription';
  static const String tableSubscription = 'CREATE TABLE $_tableSubscription('
      '$_id INTEGER, '
      '$_id_user INTEGER, '
      '$_subscription_price REAL, '
      '$_id_period INTEGER, '
      '$_id_send INTEGER, '
      '$_doc TEXT, '
      '$_name TEXT, '
      '$_email TEXT, '
      '$_postal_code TEXT, '
      '$_street TEXT, '
      '$_number TEXT, '
      '$_complement TEXT NULL, '
      '$_neighborhood TEXT, '
      '$_city TEXT, '
      '$_state TEXT, '
      '$_ddd TEXT, '
      '$_cell TEXT, '
      '$_type TEXT);';

  static const String _id = 'id';
  static const String _id_user = 'id_user';
  static const String _subscription_price = 'subscription_price';
  static const String _id_period = 'id_period';
  static const String _id_send = 'id_send';
  static const String _doc = 'doc';
  static const String _name = 'name';
  static const String _email = 'email';
  static const String _postal_code = 'postal_code';
  static const String _street = 'street';
  static const String _number = 'number';
  static const String _complement = 'complement';
  static const String _neighborhood = 'neighborhood';
  static const String _city = 'city';
  static const String _state = 'state';
  static const String _ddd = 'ddd';
  static const String _cell = 'cell';
  static const String _type = 'type';

  Future<int> saveSubscriptionOffModel(SubscriptionOffModel subscriptionOffModel) async {
    final Database db = await getDatabase();
    Map<String, dynamic> subcriptionMap = _toMapSubscriptionOffModel(subscriptionOffModel);
    return db.insert(_tableSubscription, subcriptionMap);
  }

  Future<SubscriptionOffModel> getSubscriptionOffModelById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableSubscription,
        columns: [ _id, _id_user, _subscription_price, _id_period, _id_send, _doc, _name, _email, _postal_code, _street, _number, _complement, _neighborhood, _city, _state, _ddd, _cell, _type],
        where: 'id = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new SubscriptionOffModel.fromJson(result.first);
    }
    return null;
  }

  Future<SubscriptionOffModel> getSubscription(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableSubscription,
        columns: [ _id, _id_user, _subscription_price, _id_period, _id_send, _doc, _name, _email, _postal_code, _street, _number, _complement, _neighborhood, _city, _state, _ddd, _cell, _type],
        where: 'id = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new SubscriptionOffModel.fromJson(result.first);
    }
    return null;
  }

  Future<List<SubscriptionOffModel>> findsubscriptionOffModel() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableSubscription);
    List<SubscriptionOffModel> SubscriptionOffModelList = _toListsubscriptionOffModel(result);
    return SubscriptionOffModelList;
  }

  Future<bool> verifySubscriptionOffModel(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableSubscription,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<bool> verifyUserHaveSubscription(int id_user) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableSubscription,
        columns: ['id_user'],
        where: 'id_user = ?',
        whereArgs: ['$id_user']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }



  Map<String, dynamic> _toMapSubscriptionOffModel(SubscriptionOffModel subscriptionOffModel) {
    final Map<String, dynamic> subscriptionOffModelMap = Map();
    subscriptionOffModelMap['id'] = subscriptionOffModel.id;
    subscriptionOffModelMap['id_user'] = subscriptionOffModel.id_user;
    subscriptionOffModelMap['subscription_price'] = subscriptionOffModel.subscription_price;
    subscriptionOffModelMap['id_period'] = subscriptionOffModel.id_period;
    subscriptionOffModelMap['id_send'] = subscriptionOffModel.id_send;
    subscriptionOffModelMap['doc'] = subscriptionOffModel.doc;
    subscriptionOffModelMap['name'] = subscriptionOffModel.name;
    subscriptionOffModelMap['email'] = subscriptionOffModel.email;
    subscriptionOffModelMap['postal_code'] = subscriptionOffModel.postal_code;
    subscriptionOffModelMap['street'] = subscriptionOffModel.street;
    subscriptionOffModelMap['number'] = subscriptionOffModel.number;
    subscriptionOffModelMap['complement'] = subscriptionOffModel.complement;
    subscriptionOffModelMap['neighborhood'] = subscriptionOffModel.neighborhood;
    subscriptionOffModelMap['city'] = subscriptionOffModel.city;
    subscriptionOffModelMap['state'] = subscriptionOffModel.state;
    subscriptionOffModelMap['ddd'] = subscriptionOffModel.ddd;
    subscriptionOffModelMap['cell'] = subscriptionOffModel.cell;
    subscriptionOffModelMap['type'] = subscriptionOffModel.type;
    return subscriptionOffModelMap;
  }

  List<SubscriptionOffModel> _toListsubscriptionOffModel(List<Map<String, dynamic>> result) {
    final List<SubscriptionOffModel> subscriptionOffList = List();
    for (Map<String, dynamic> row in result) {
      final SubscriptionOffModel subscriptionOffModel = SubscriptionOffModel(
          row['id'],
          row['id_user'],
          row['subscription_price'],
          row['id_period'],
          row['id_send'],
          row['doc'],
          row['name'],
          row['email'],
          row['postal_code'],
          row['street'],
          row['number'],
          row['complement'],
          row['neighborhood'],
          row['city'],
          row['state'],
          row['ddd'],
          row['cell'],
          row['type']
      );
      subscriptionOffList.add(subscriptionOffModel);
    }
    return subscriptionOffList;
  }
}
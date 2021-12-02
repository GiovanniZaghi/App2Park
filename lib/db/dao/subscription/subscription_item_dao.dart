import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/subscription/subscription_item_off_model.dart';
import 'package:sqflite/sqflite.dart';

class SubscriptionItemDao {

  static const String _tableSubscriptionItem = 'subscription_item';
  static const String tableSubscriptionItem = 'CREATE TABLE $_tableSubscriptionItem('
      '$_id INTEGER, '
      '$_id_subscription INTEGER, '
      '$_id_park INTEGER);';

  static const String _id = 'id';
  static const String _id_subscription= 'id_subscription';
  static const String _id_park = 'id_park';


  Future<int> saveSubscriptionItemOffModel(SubscriptionItemOffModel subscriptionItemOffModel) async {
    final Database db = await getDatabase();
    Map<String, dynamic> subcriptionItemMap = _toMapSubscriptionItemOffModel(subscriptionItemOffModel);
    return db.insert(_tableSubscriptionItem, subcriptionItemMap);
  }

  Future<SubscriptionItemOffModel> getSubscriptionItemOffModelById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableSubscriptionItem,
        columns: [ _id, _id_subscription, _id_park],
        where: 'id = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new SubscriptionItemOffModel.fromJson(result.first);
    }
    return null;
  }

  Future<SubscriptionItemOffModel> getSubscription(int id_park) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableSubscriptionItem,
        columns: [ _id, _id_subscription, _id_park],
        where: 'id_park = ?',
        whereArgs: [id_park]);

    if (result.length > 0) {
      return new SubscriptionItemOffModel.fromJson(result.first);
    }
    return null;
  }

  Future<List<SubscriptionItemOffModel>> findsubscriptionItemOffModel() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableSubscriptionItem);
    List<SubscriptionItemOffModel> SubscriptionItemOffModelList = _toListsubscriptionItemOffModel(result);
    return SubscriptionItemOffModelList;
  }

  Future<bool> verifySubscriptionItemOffModel(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableSubscriptionItem,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }


  Map<String, dynamic> _toMapSubscriptionItemOffModel(SubscriptionItemOffModel subscriptionItemOffModel) {
    final Map<String, dynamic> subscriptionItemOffModelMap = Map();
    subscriptionItemOffModelMap['id'] = subscriptionItemOffModel.id;
    subscriptionItemOffModelMap['id_subscription'] = subscriptionItemOffModel.id_subscription;
    subscriptionItemOffModelMap['id_park'] = subscriptionItemOffModel.id_park;
    return subscriptionItemOffModelMap;
  }

  List<SubscriptionItemOffModel> _toListsubscriptionItemOffModel(List<Map<String, dynamic>> result) {
    final List<SubscriptionItemOffModel> subscriptionItemOffList = List();
    for (Map<String, dynamic> row in result) {
      final SubscriptionItemOffModel subscriptionItemOffModel = SubscriptionItemOffModel(
          row['id'],
          row['id_subscription'],
          row['id_park']
      );
      subscriptionItemOffList.add(subscriptionItemOffModel);
    }
    return subscriptionItemOffList;
  }
}
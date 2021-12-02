import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/cart/cart_item_off_model.dart';
import 'package:sqflite/sqflite.dart';

class CartItemDao {

  static const String _tableCartItem = 'cart_item';
  static const String tableCartItem = 'CREATE TABLE $_tableCartItem('
      '$_id INTEGER, '
      '$_id_cart INTEGER, '
      '$_id_park INTEGER, '
      '$_id_period INTEGER, '
      '$_value REAL);';

  static const String _id = 'id';
  static const String _id_cart = 'id_cart';
  static const String _id_park = 'id_park';
  static const String _id_period = 'id_period';
  static const String _value = 'value';


  Future<int> saveCartOffModel(CartItemOffModel cartItemOffModel) async {
    final Database db = await getDatabase();
    Map<String, dynamic> customersMap = _toMapCartItemOffModel(cartItemOffModel);
    return db.insert(_tableCartItem, customersMap);
  }

  Future<CartItemOffModel> getCartItemOffModelById(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableCartItem,
        columns: [ _id, _id_cart, _id_park, _id_period, _value],
        where: 'id = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new CartItemOffModel.fromJson(result.first);
    }
    return null;
  }

  Future<List<CartItemOffModel>> findAllCartOffModel() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableCartItem);
    List<CartItemOffModel> cartItemOffModelList = _toListCartItemOffModel(result);
    return cartItemOffModelList;
  }

  Future<bool> verifyCartItemOffModel(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableCartItem,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }


  Map<String, dynamic> _toMapCartItemOffModel(CartItemOffModel cartItemOffModel) {
    final Map<String, dynamic> cartOffModelMap = Map();
    cartOffModelMap['id'] = cartItemOffModel.id;
    cartOffModelMap['id_cart'] = cartItemOffModel.id_cart;
    cartOffModelMap['id_park'] = cartItemOffModel.id_park;
    cartOffModelMap['id_period'] = cartItemOffModel.id_period;
    cartOffModelMap['value'] = cartItemOffModel.value;
    return cartOffModelMap;
  }

  List<CartItemOffModel> _toListCartItemOffModel(List<Map<String, dynamic>> result) {
    final List<CartItemOffModel> cartItemOffList = List();
    for (Map<String, dynamic> row in result) {
      final CartItemOffModel cartItem = CartItemOffModel(
          row['id'],
          row['id_cart'],
          row['id_park'],
          row['id_period'],
          row['value']
      );
      cartItemOffList.add(cartItem);
    }
    return cartItemOffList;
  }
}
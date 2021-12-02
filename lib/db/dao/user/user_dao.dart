import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/user/user_off_model.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDao{
  static const String _tableUser = 'user';
  static const String tableUser = 'CREATE TABLE $_tableUser('
      '$_id INTEGER PRIMARY KEY, '
      '$_first TEXT,'
      '$_last_name TEXT, '
      '$_cell INTEGER,'
      '$_doc INTEGER,'
      '$_email TEXT,'
      '$_pass TEXT,'
      '$_id_status INTEGER NULL);';

  static const String _id = 'id';
  static const String _first = 'first_name';
  static const String _last_name = 'last_name';
  static const String _cell = 'cell';
  static const String _doc = 'doc';
  static const String _email = 'email';
  static const String _pass = 'pass';
  static const String _id_status = 'id_status';

  Future<int> saveUser(UserOff user) async {
    final Database db = await getDatabase();
    Map<String, dynamic> userMap = _toMapUser(user);
    return db.insert(_tableUser, userMap);

  }

  Future<List<UserOff>> findAllUser() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableUser);
    List<UserOff> users = _toListUser(result);
    return users;
  }

  Future<bool> verifyUser(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableUser,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }


  Map<String, dynamic> _toMapUser(UserOff user) {
    final Map<String, dynamic> userMap = Map();
    userMap['id'] = user.id;
    userMap['first_name'] = user.first_name;
    userMap['last_name'] = user.last_name;
    userMap['cell'] = user.cell;
    userMap['doc'] = user.doc;
    userMap['email'] = user.email;
    userMap['pass'] = user.pass;
    userMap['id_status'] = user.id_status;

    return userMap;
  }

  List<UserOff> _toListUser(List<Map<String, dynamic>> result) {
    final List<UserOff> users = List();
    for (Map<String, dynamic> row in result) {
      final UserOff user = UserOff(
        row['id'],
        row['first_name'],
        row['last_name'],
        row['cell'],
        row['doc'],
        row['email'],
        row['pass'],
        row['id_status'],
      );
      users.add(user);
    }
    return users;
  }
}
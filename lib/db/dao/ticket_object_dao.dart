import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/ticket_object_off_model.dart';
import 'package:sqflite/sqflite.dart';

class TicketObjectDao {

  static const String _tableTicketObject = 'ticket_object';
  static const String tableTicketObject = 'CREATE TABLE $_tableTicketObject('
      '$_id INTEGER NULL, '
      '$_id_ticket INTEGER NULL, '
      '$_id_ticket_object_app INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_id_ticket_app INTEGER, '
      '$_id_object INTEGER);';

  static const String _id = 'id';
  static const String _id_ticket = 'id_ticket';
  static const String _id_ticket_object_app = 'id_ticket_object_app';
  static const String _id_ticket_app = 'id_ticket_app';
  static const String _id_object = 'id_object';

  Future<int> saveTicketObject(TicketObjectOffModel ticketObject) async {
    final Database db = await getDatabase();
    Map<String, dynamic> ticketObjectMap = _toMapTicketObject(ticketObject);
    return db.insert(_tableTicketObject, ticketObjectMap);
  }

  Future<List<TicketObjectOffModel>> findAllTicketObject() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableTicketObject);
    List<TicketObjectOffModel> ticketObjectList = _toListTicketObject(result);
    return ticketObjectList;
  }

  Future<bool> verifyTicketObjects(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableTicketObject,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateTicketObjectIdOn(int id, int id_ticket_object_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE ticket_object SET id = $id WHERE id_ticket_object_app = $id_ticket_object_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> updateTicketObjectIdOnSinc(int id, int id_ticket, int id_ticket_object_app,) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE ticket_object SET id = $id, id_ticket = $id_ticket WHERE id_ticket_object_app = $id_ticket_object_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<List<TicketObjectOffModel>> getTicketsObjectsNoSincronized(int id_ticket_app) async {
    final Database db = await getDatabase();
    List<TicketObjectOffModel> list = new List<TicketObjectOffModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM ticket_object WHERE id_ticket_app = $id_ticket_app');
    dbList.forEach((itemMap) {
      list.add(TicketObjectOffModel.fromJson(itemMap));
    });
    return list;
  }

  Map<String, dynamic> _toMapTicketObject(TicketObjectOffModel ticketObject) {
    final Map<String, dynamic> ticketObjectMap = Map();
    ticketObjectMap['id'] = ticketObject.id;
    ticketObjectMap['id_ticket'] = ticketObject.id_ticket;
    ticketObjectMap['id_ticket_object_app'] = ticketObject.id_ticket_object_app;
    ticketObjectMap['id_ticket_app'] = ticketObject.id_ticket_app;
    ticketObjectMap['id_object'] = ticketObject.id_object;
    return ticketObjectMap;
  }

  List<TicketObjectOffModel> _toListTicketObject(List<Map<String, dynamic>> result) {
    final List<TicketObjectOffModel> ticketObjectList = List();
    for (Map<String, dynamic> row in result) {
      final TicketObjectOffModel ticketObject = TicketObjectOffModel(
        row['id'],
        row['id_ticket'],
        row['id_ticket_app'],
        row['id_object'],
      );
      ticketObjectList.add(ticketObject);
    }
    return ticketObjectList;
  }
}
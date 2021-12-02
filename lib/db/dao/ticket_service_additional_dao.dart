import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/exit_service_additional_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_service_additional_off_model.dart';
import 'package:sqflite/sqflite.dart';

class TicketServiceAdditionalDao {

  static const String _tableTicketServiceAdditional = 'ticket_service_additional';
  static const String tableTicketServiceAdditional = 'CREATE TABLE $_tableTicketServiceAdditional('
      '$_id INTEGER NULL, '
      '$_id_ticket INTEGER NULL, '
      '$_id_ticket_service_additional_app INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_id_ticket_app INTEGER, '
      '$_id_park_service_additional INTEGER, '
      '$_name TEXT, '
      '$_price REAL,'
      '$_lack TEXT, '
      '$_finish_estimate TEXT, '
      '$_price_justification TEXT, '
      '$_observation TEXT, '
      '$_id_status INTEGER);';

  static const String _id = 'id';
  static const String _id_ticket = 'id_ticket';
  static const String _id_ticket_service_additional_app = 'id_ticket_service_additional_app';
  static const String _id_ticket_app = 'id_ticket_app';
  static const String _id_park_service_additional = 'id_park_service_additional';
  static const String _name = 'name';
  static const String _price = 'price';
  static const String _lack = 'lack';
  static const String _finish_estimate = 'finish_estimate';
  static const String _price_justification = 'price_justification';
  static const String _observation = 'observation';
  static const String _id_status = 'id_status';

  Future<int> saveTicketServiceAdditional(TicketServiceAdditionalOffModel ticketServiceAdditional) async {
    final Database db = await getDatabase();
    Map<String, dynamic> ticketServiceAdditionalMap = _toMapTicketServiceAdditional(ticketServiceAdditional);
    return db.insert(_tableTicketServiceAdditional, ticketServiceAdditionalMap);
  }

  Future<List<TicketServiceAdditionalOffModel>> findAllTicketServiceAdditional() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableTicketServiceAdditional);
    List<TicketServiceAdditionalOffModel> ticketServiceAdditionalList = _toListTicketServiceAdditional(result);
    return ticketServiceAdditionalList;
  }

  Future<bool> verifyTicketServiceAdditional(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableTicketServiceAdditional,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<List<TicketServiceAdditionalOffModel>> getAllServicesAdditionalByIdTicketAppSinc(
      int id_ticket_app) async {
    final Database db = await getDatabase();
    List<TicketServiceAdditionalOffModel> list = new List<TicketServiceAdditionalOffModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM ticket_service_additional WHERE id_ticket_app = $id_ticket_app');
    dbList.forEach((itemMap) {
      list.add(TicketServiceAdditionalOffModel.fromJson(itemMap));
    });
    return list;
  }

  Future<List<ExitServiceAdditionalModel>> getAllServicesAdditionalByIdTicketApp(
      int id_ticket_app) async {
    final Database db = await getDatabase();
    List<ExitServiceAdditionalModel> list = new List<ExitServiceAdditionalModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM ticket_service_additional WHERE id_ticket_app = $id_ticket_app');
    dbList.forEach((itemMap) {
      list.add(ExitServiceAdditionalModel.fromJson(itemMap));
    });
    return list;
  }

  Future<bool> updateTicketServiceAdditionalSinc(int id, int id_ticket, int id_ticket_service_additional_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE ticket_service_additional SET id = $id, id_ticket = $id_ticket WHERE id_ticket_service_additional_app = $id_ticket_service_additional_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> updateTicketServiceAdditional(int id, int id_ticket_service_additional_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE ticket_service_additional SET id = $id WHERE id_ticket_service_additional_app = $id_ticket_service_additional_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapTicketServiceAdditional(TicketServiceAdditionalOffModel ticketServiceAdditional) {
    final Map<String, dynamic> ticketServiceAdditionalMap = Map();
    ticketServiceAdditionalMap['id'] = ticketServiceAdditional.id;
    ticketServiceAdditionalMap['id_ticket'] = ticketServiceAdditional.id_ticket;
    ticketServiceAdditionalMap['id_ticket_service_additional_app'] = ticketServiceAdditional.id_ticket_service_additional_app;
    ticketServiceAdditionalMap['id_ticket_app'] = ticketServiceAdditional.id_ticket_app;
    ticketServiceAdditionalMap['id_park_service_additional'] = ticketServiceAdditional.id_park_service_additional;
    ticketServiceAdditionalMap['name'] = ticketServiceAdditional.name;
    ticketServiceAdditionalMap['price'] = ticketServiceAdditional.price;
    ticketServiceAdditionalMap['lack'] = ticketServiceAdditional.lack;
    ticketServiceAdditionalMap['finish_estimate'] = ticketServiceAdditional.finish_estimate;
    ticketServiceAdditionalMap['price_justification'] = ticketServiceAdditional.price_justification;
    ticketServiceAdditionalMap['observation'] = ticketServiceAdditional.observation;
    ticketServiceAdditionalMap['id_status'] = ticketServiceAdditional.id_status;

    return ticketServiceAdditionalMap;
  }

  List<TicketServiceAdditionalOffModel> _toListTicketServiceAdditional(List<Map<String, dynamic>> result) {
    final List<TicketServiceAdditionalOffModel> ticketServiceAdditionalList = List();
    for (Map<String, dynamic> row in result) {
      final TicketServiceAdditionalOffModel ticketServiceAdditional = TicketServiceAdditionalOffModel(
        row['id'],
        row['id_ticket'],
        row['id_ticket_app'],
        row['id_park_service_additional'],
        row['name'],
        row['price'],
        row['lack'],
        row['finish_estimate'],
        row['price_justification'],
        row['observation'],
        row['id_status'],
      );
      ticketServiceAdditionalList.add(ticketServiceAdditional);
    }
    return ticketServiceAdditionalList;
  }
}
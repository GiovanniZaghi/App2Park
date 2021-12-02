import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_status_off_model.dart';
import 'package:sqflite/sqflite.dart';

class TicketHistoricStatusDao {

  static const String _tableTicketHistoricStatus = 'ticket_historic_status';
  static const String tableTicketHistoricStatus = 'CREATE TABLE $_tableTicketHistoricStatus('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT);';

  static const String _id = 'id';
  static const String _name = 'name';

  Future<int> saveTicketHistoricStatus(TicketHistoricStatusOffModel ticketHistoricStatusOffModel) async {
    final Database db = await getDatabase();
    Map<String, dynamic> ticketHistoricStatusMap = _toMapTicketHistoricStatus(ticketHistoricStatusOffModel);
    return db.insert(_tableTicketHistoricStatus, ticketHistoricStatusMap);
  }

  Future<List<TicketHistoricStatusOffModel>> findAllTicketHistoricStatus() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableTicketHistoricStatus);
    List<TicketHistoricStatusOffModel> ticketHistoricStatusList = _toListTicketHistoricStatus(result);
    return ticketHistoricStatusList;
  }

  Future<bool> verifyTicketHistoricStatus(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableTicketHistoricStatus,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapTicketHistoricStatus(TicketHistoricStatusOffModel ticketHistoricStatusOffModel) {
    final Map<String, dynamic> ticketHistoricStatusMap = Map();
    ticketHistoricStatusMap['id'] = ticketHistoricStatusOffModel.id;
    ticketHistoricStatusMap['name'] = ticketHistoricStatusOffModel.name;

    return ticketHistoricStatusMap;
  }

  List<TicketHistoricStatusOffModel> _toListTicketHistoricStatus(List<Map<String, dynamic>> result) {
    final List<TicketHistoricStatusOffModel> ticketHistoricStatusList = List();
    for (Map<String, dynamic> row in result) {
      final TicketHistoricStatusOffModel ticketHistoricStatusOffModel = TicketHistoricStatusOffModel(
        row['id'],
        row['name']
      );
      ticketHistoricStatusList.add(ticketHistoricStatusOffModel);
    }
    return ticketHistoricStatusList;
  }
}
import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/exit_join_model.dart';
import 'package:app2park/moduleoff/get_plate_by_cupom.dart';
import 'package:app2park/moduleoff/get_ticket_by_cupom.dart';
import 'package:app2park/moduleoff/price_helper.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_off_model.dart';
import 'package:app2park/moduleoff/verifiy_plate_exists_model.dart';
import 'package:sqflite/sqflite.dart';

class TicketHistoricDao {
  static const String _tableTicketHistoric = 'ticket_historic';
  static const String tableTickethistoric =
      'CREATE TABLE $_tableTicketHistoric('
      '$_id INTEGER NULL, '
      '$_id_ticket INTEGER NULL, '
      '$_id_ticket_historic_app INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_id_ticket_app INTEGER, '
      '$_id_ticket_historic_status INTEGER, '
      '$_id_user INTEGER, '
      '$_id_service_additional INTEGER NULL,'
      '$_id_service_additional_app INTEGER NULL, '
      '$_date_time TEXT);';

  static const String _id = 'id';
  static const String _id_ticket = 'id_ticket';
  static const String _id_ticket_historic_app = 'id_ticket_historic_app';
  static const String _id_ticket_app = 'id_ticket_app';
  static const String _id_ticket_historic_status = 'id_ticket_historic_status';
  static const String _id_user = 'id_user';
  static const String _id_service_additional = 'id_service_additional';
  static const String _id_service_additional_app = 'id_service_additional_app';
  static const String _date_time = 'date_time';

  Future<int> saveTicketHistoric(TicketHistoricOffModel ticketHistoric) async {
    final Database db = await getDatabase();
    Map<String, dynamic> ticketHistoricMap =
        _toMapTicketHistoric(ticketHistoric);
    return db.insert(_tableTicketHistoric, ticketHistoricMap);
  }

  Future<List<TicketHistoricOffModel>> findAllTicketHistoric() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(_tableTicketHistoric);
    List<TicketHistoricOffModel> ticketHistoricList =
        _toListTicketHistoric(result);
    return ticketHistoricList;
  }

  Future<bool> verifyTicketHistoric(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableTicketHistoric,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<List<TicketHistoricOffModel>> getTicketHistoricByIdTicketApp(int id_ticket_app) async {
    final Database db = await getDatabase();
    List<TicketHistoricOffModel> list = new List<TicketHistoricOffModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM ticket_historic WHERE id_ticket_app = $id_ticket_app');
    dbList.forEach((itemMap) {
      list.add(TicketHistoricOffModel.fromJson(itemMap));
    });
    return list;
  }

  Future<bool> updateTicketHistoricIdOn(int id, int id_ticket, int id_ticket_historic_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE ticket_historic SET id = $id, id_ticket = $id_ticket WHERE id_ticket_historic_app = $id_ticket_historic_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapTicketHistoric(
      TicketHistoricOffModel ticketHistoric) {
    final Map<String, dynamic> ticketHistoricMap = Map();
    ticketHistoricMap['id'] = ticketHistoric.id;
    ticketHistoricMap['id_ticket'] = ticketHistoric.id_ticket;
    ticketHistoricMap['id_ticket_historic_app'] =
        ticketHistoric.id_ticket_historic_app;
    ticketHistoricMap['id_ticket_app'] = ticketHistoric.id_ticket_app;
    ticketHistoricMap['id_ticket_historic_status'] =
        ticketHistoric.id_ticket_historic_status;
    ticketHistoricMap['id_user'] = ticketHistoric.id_user;
    ticketHistoricMap['id_service_additional'] =
        ticketHistoric.id_service_additional;
    ticketHistoricMap['id_service_additional_app'] =
        ticketHistoric.id_service_additional_app;
    ticketHistoricMap['date_time'] = ticketHistoric.date_time;

    return ticketHistoricMap;
  }

  List<TicketHistoricOffModel> _toListTicketHistoric(
      List<Map<String, dynamic>> result) {
    final List<TicketHistoricOffModel> ticketHistoricList = List();
    for (Map<String, dynamic> row in result) {
      final TicketHistoricOffModel ticketHistoric = TicketHistoricOffModel(
        row['id'],
        row['id_ticket'],
        row['id_ticket_app'],
        row['id_ticket_historic_status'],
        row['id_user'],
        row['id_service_additional'],
        row['id_service_additional_app'],
        row['date_time'],
      );
      ticketHistoricList.add(ticketHistoric);
    }
    return ticketHistoricList;
  }

  Future<List<PriceHelper>> getPriceHelper(int id_price_detached_app) async {
    final Database db = await getDatabase();
    List<PriceHelper> list = new List<PriceHelper>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT  I.*, P.name AS name_table, B.name, B.time, B.type, B.level '
        ' FROM price_detached_item AS I'
        ' LEFT JOIN price_detached_item_base AS B ON (I.id_price_detached_item_base = B.id)'
        ' LEFT JOIN price_detached AS P ON (I.id_price_detached_app = P.id_price_detached_app)'
        ' WHERE I.id_price_detached_app = $id_price_detached_app'
        ' ORDER BY I.id_price_detached_item_base ASC');
    dbList.forEach((itemMap) {
      list.add(PriceHelper.fromJson(itemMap));
    });
    return list;
  }

  Future<List<VerifyPlateExitsModel>> verifyPlatesExitsOut(
      String placa, int id_park) async {
    final Database db = await getDatabase();
    List<VerifyPlateExitsModel> list = new List<VerifyPlateExitsModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT S.name, H.* FROM ticket_historic AS H LEFT JOIN'
        ' (SELECT T.id_ticket_app FROM tickets AS T INNER JOIN vehicles AS V ON(T.id_vehicle_app = V.id_vehicle_app) WHERE V.plate = "$placa" AND id_park = $id_park ORDER BY T.cupom_entrance_datetime DESC LIMIT 1) AS T'
        ' ON(H.id_ticket_app = T.id_ticket_app) INNER JOIN ticket_historic_status AS S ON(H.id_ticket_historic_status = S.id) WHERE H.id_ticket_app = T.id_ticket_app ORDER BY H.id_ticket_app ASC');
    dbList.forEach((itemMap) {
      list.add(VerifyPlateExitsModel.fromJson(itemMap));
    });
    return list;
  }

  Future<List<GetTicketByCupom>> getCupombyTicket(
      int cupom, int id_park) async {
    final Database db = await getDatabase();
    List<GetTicketByCupom> list = new List<GetTicketByCupom>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT id_ticket_app FROM tickets WHERE id_cupom = $cupom AND id_park = $id_park');
    dbList.forEach((itemMap) {
      list.add(GetTicketByCupom.fromJson(itemMap));
    });
    return list;
  }

  Future<List<GetPlateByCupom>> getPlatebyTicket(
      int cupom, int id_park) async {
    final Database db = await getDatabase();
    List<GetPlateByCupom> list = new List<GetPlateByCupom>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT V.plate FROM tickets AS T INNER JOIN vehicles AS V ON(T.id_vehicle_app = V.id_vehicle_app) WHERE T.id_cupom = $cupom AND T.id_park = $id_park');
    dbList.forEach((itemMap) {
      list.add(GetPlateByCupom.fromJson(itemMap));
    });
    return list;
  }
}

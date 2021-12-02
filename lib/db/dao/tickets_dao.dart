import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/exit_join_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_off_leftjoin_model.dart';
import 'package:app2park/moduleoff/ticket/tickets_off_model.dart';
import 'package:app2park/moduleoff/vehicle_patio.dart';
import 'package:sqflite/sqflite.dart';

class TicketsDao {
  static const String _tableTickets = 'tickets';
  static const String tableTickets = 'CREATE TABLE $_tableTickets('
      '$_id INTEGER NULL, '
      '$_id_ticket_app INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_id_park INTEGER, '
      '$_id_user INTEGER, '
      '$_id_vehicle INTEGER NULL, '
      '$_id_vehicle_app INTEGER NULL,'
      '$_id_customer INTEGER NULL, '
      '$_id_customer_app INTEGER NULL,'
      '$_id_agreement INTEGER NULL,'
      '$_id_agreement_app INTEGER NULL,'
      '$_id_cupom INTEGER,'
      '$_id_price_detached INTEGER,'
      '$_id_price_detached_app INTEGER,'
      '$_cupom_entrance_datetime TEXT,'
      '$_pay_until TEXT);';

  static const String _id = 'id';
  static const String _id_ticket_app = 'id_ticket_app';
  static const String _id_park = 'id_park';
  static const String _id_user = 'id_user';
  static const String _id_vehicle = 'id_vehicle';
  static const String _id_vehicle_app = 'id_vehicle_app';
  static const String _id_customer = 'id_customer';
  static const String _id_customer_app = 'id_customer_app';
  static const String _id_agreement = 'id_agreement';
  static const String _id_agreement_app = 'id_agreement_app';
  static const String _id_cupom = 'id_cupom';
  static const String _id_price_detached = 'id_price_detached';
  static const String _id_price_detached_app = 'id_price_detached_app';
  static const String _cupom_entrance_datetime = 'cupom_entrance_datetime';
  static const String _pay_until = 'pay_until';

  Future<int> saveTickets(TicketsOffModel ticket) async {
    final Database db = await getDatabase();
    Map<String, dynamic> ticketsMap = _toMapTickets(ticket);
    return db.insert(_tableTickets, ticketsMap);
  }

  Future<List<TicketsOffModel>> findAllTickets() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableTickets);
    List<TicketsOffModel> ticketsList = _toListTickets(result);
    return ticketsList;
  }

  Future<int> getTicketappsinc(int id_ticket) async {
    final Database db = await getDatabase();
    return Sqflite.firstIntValue(await db
        .rawQuery('SELECT id_ticket_app FROM tickets WHERE id = $id_ticket'));
  }

  Future<List<TicketsOffLeftJoinModel>> getTicketByIdTicketIdCupom(int id_ticket_app, int id_cupom) async {
    final Database db = await getDatabase();
    List<TicketsOffLeftJoinModel> list = new List<TicketsOffLeftJoinModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT T.id, T.id_ticket_app, T.id_cupom, O.id as id_object, S.id as id_service, V.plate, V.model, A.type '
            'FROM tickets AS T LEFT JOIN ticket_historic AS H ON (H.id_ticket_app = T.id_ticket_app) '
            'LEFT JOIN vehicles AS V ON(T.id_vehicle_app = V.id_vehicle_app) '
            'LEFT JOIN ticket_object AS O ON(T.id_ticket_app = O.id_ticket_app) '
            'LEFT JOIN ticket_service_additional AS S ON(T.id_ticket_app = S.id_ticket_app) '
            'LEFT JOIN vehicle_type AS A ON(V.id_vehicle_type = A.id) WHERE T.id_ticket_app = $id_ticket_app AND T.id_cupom = $id_cupom LIMIT 1');
    dbList.forEach((itemMap) {
      list.add(TicketsOffLeftJoinModel.fromJson(itemMap));
    });
    return list;
  }




  Future<TicketsOffModel> getTicketByIdTicketApp(int id_ticket_app) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableTickets,
        columns: [
          _id,
          _id_ticket_app,
          _id_park,
          _id_user,
          _id_vehicle,
          _id_vehicle_app,
          _id_customer,
          _id_customer_app,
          _id_agreement,
          _id_agreement_app,
          _id_cupom,
          _id_price_detached,
          _id_price_detached_app,
          _cupom_entrance_datetime,
          _pay_until
        ],
        where: 'id_ticket_app = ?',
        whereArgs: [id_ticket_app]);

    if (result.length > 0) {
      return new TicketsOffModel.fromJson(result.first);
    }
    return null;
  }

  Future<List<TicketsOffModel>> getTicketInfo(
      int id_ticket_app, int id_park) async {
    final Database db = await getDatabase();
    List<TicketsOffModel> list = new List<TicketsOffModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM `tickets` WHERE id_ticket_app = $id_ticket_app AND id_park = $id_park ORDER BY id DESC LIMIT 1');
    dbList.forEach((itemMap) {
      list.add(TicketsOffModel.fromJson(itemMap));
    });
    return list;
  }

  Future<List<TicketsOffModel>> getTicketsNoSincronized(int id_user) async {
    final Database db = await getDatabase();
    List<TicketsOffModel> list = new List<TicketsOffModel>();
    List<Map<String, dynamic>> dbList = await db
        .rawQuery('SELECT * FROM tickets WHERE id = 0  AND id_user = $id_user');
    dbList.forEach((itemMap) {
      list.add(TicketsOffModel.fromJson(itemMap));
    });
    return list;
  }

  Future<bool> verifyCupom(int id_cupom, int id_park) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableTickets,
        columns: ['id'],
        where: 'id_cupom = ? AND id_park = ?',
        whereArgs: ['$id_cupom', '$id_park']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<bool> verifyTicket(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableTickets,
        columns: ['id'], where: 'id = ?', whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<int> getTicketApp(int id) async {
    final Database db = await getDatabase();
    return Sqflite.firstIntValue(await db.rawQuery('SELECT id_ticket_app FROM tickets WHERE id = "$id"'));
  }

  Map<String, dynamic> _toMapTickets(TicketsOffModel tickets) {
    final Map<String, dynamic> ticketsMap = Map();
    ticketsMap['id'] = tickets.id;
    ticketsMap['id_ticket_app'] = tickets.id_ticket_app;
    ticketsMap['id_park'] = tickets.id_park;
    ticketsMap['id_user'] = tickets.id_user;
    ticketsMap['id_vehicle'] = tickets.id_vehicle;
    ticketsMap['id_vehicle_app'] = tickets.id_vehicle_app;
    ticketsMap['id_customer'] = tickets.id_customer;
    ticketsMap['id_customer_app'] = tickets.id_customer_app;
    ticketsMap['id_agreement'] = tickets.id_agreement;
    ticketsMap['id_agreement_app'] = tickets.id_agreement_app;
    ticketsMap['id_cupom'] = tickets.id_cupom;
    ticketsMap['id_price_detached'] = tickets.id_price_detached;
    ticketsMap['id_price_detached_app'] = tickets.id_price_detached_app;
    ticketsMap['cupom_entrance_datetime'] = tickets.cupom_entrance_datetime;
    ticketsMap['pay_until'] = tickets.pay_until;

    return ticketsMap;
  }

  List<TicketsOffModel> _toListTickets(List<Map<String, dynamic>> result) {
    final List<TicketsOffModel> ticketsList = List();
    for (Map<String, dynamic> row in result) {
      final TicketsOffModel tickets = TicketsOffModel(
        row['id'],
        row['id_park'],
        row['id_user'],
        row['id_vehicle'],
        row['id_vehicle_app'],
        row['id_customer'],
        row['id_customer_app'],
        row['id_agreement'],
        row['id_agreement_app'],
        row['id_cupom'],
        row['id_price_detached'],
        row['id_price_detached_app'],
        row['cupom_entrance_datetime'],
        row['pay_until'],
      );
      ticketsList.add(tickets);
    }
    return ticketsList;
  }

  Future<bool> updateTicketsVehicle(
      int id_vehicle_app, int id_ticket_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE tickets SET id_vehicle_app = $id_vehicle_app WHERE id_ticket_app = $id_ticket_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }
  Future<bool> updateTicketsService(
      int id_vehicle_app, int id_ticket_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE tickets SET id_vehicle_app = $id_vehicle_app WHERE id_ticket_app = $id_ticket_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateTicketsIdOn(int id, int id_ticket_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE tickets SET id = $id WHERE id_ticket_app = $id_ticket_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateTicketsIdOnSinc(
      int id, int id_vehicle, int id_customer, int id_ticket_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE tickets SET id = $id, id_vehicle = $id_vehicle, id_customer = $id_customer WHERE id_ticket_app = $id_ticket_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateTicketsCustomers(
      int id_customer_app, int id_ticket_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE tickets SET id_customer_app = $id_customer_app WHERE id_ticket_app = $id_ticket_app');
    if (ids > 0) {
      return true;
    }
    return false;

  }

  Future<bool> updateTicketsPayUntil(
      String pay_until, int id_ticket_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE tickets SET pay_until = "$pay_until" WHERE id_ticket_app = $id_ticket_app');
    if (ids > 0) {
      return true;
    }
    return false;

  }

  Future<bool> updateTicketsPrice(
      int id_price_detached_app, int id_ticket_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE tickets SET id_price_detached_app = $id_price_detached_app WHERE id_ticket_app = $id_ticket_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<List<ExitJoinModel>> getExitInformation(int id_cupom) async {
    final Database db = await getDatabase();
    List<ExitJoinModel> list = new List<ExitJoinModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT T.id_ticket_app, T.id_cupom, H.id_ticket_historic_status, S.name, H.date_time, V.plate, V.model, A.type'
        ' FROM tickets AS T LEFT JOIN ticket_historic AS H ON (H.id_ticket_app = T.id_ticket_app)'
        ' LEFT JOIN vehicles AS V ON(T.id_vehicle_app = V.id_vehicle_app)'
        ' LEFT JOIN ticket_historic_status AS S ON(H.id_ticket_historic_app = S.id)'
        ' LEFT JOIN vehicle_type AS A ON(V.id_vehicle_type = A.id) WHERE T.id_cupom = $id_cupom');
    dbList.forEach((itemMap) {
      list.add(ExitJoinModel.fromJson(itemMap));
    });
    return list;
  }

  Future<List<TicketsOffModel>> getInformationTicket(int id_ticket_app, int id_cupom) async {
    final Database db = await getDatabase();
    List<TicketsOffModel> list = new List<TicketsOffModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM tickets WHERE id_ticket_app = $id_ticket_app AND id_cupom = $id_cupom');
    dbList.forEach((itemMap) {
      list.add(TicketsOffModel.fromJson(itemMap));
    });
    return list;
  }

  Future<List<VehiclePatio>> getVehiclesPatio(int id_park) async {
    final Database db = await getDatabase();
    List<VehiclePatio> list = new List<VehiclePatio>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT R.*, MAX(R.id_ticket_historic_status) AS status '
        ' FROM(SELECT   H.id_ticket_historic_app, H.id_ticket_app, H.date_time, H.id_ticket_historic_status,'
        ' H.id_ticket, T.id_cupom, V.maker, V.model, V.color, V.plate, V.year, C.email, C.cell'
        ' FROM ticket_historic AS H'
    ' LEFT JOIN tickets AS T ON(H.id_ticket_app = T.id_ticket_app)'
    ' LEFT JOIN vehicles AS V ON(T.id_vehicle_app = V.id_vehicle_app)'
    ' LEFT JOIN customers AS C ON(T.id_customer_app = C.id_customer_app)'
    ' WHERE H.id_ticket_app IN (SELECT H.id_ticket_app'
    ' FROM ticket_historic AS H'
    ' LEFT JOIN tickets    AS T ON (H.id_ticket_app = T.id_ticket_app)'
    ' WHERE H.id_ticket_historic_status = 2'
    ' AND T.id_park = $id_park)'
    ' ORDER BY H.id_ticket_app ,H.id_ticket_historic_status) AS R'
    ' GROUP BY R.id_ticket_app'
    ' HAVING status <> 11'
    ' ORDER BY R.plate ASC');
    dbList.forEach((itemMap) {
      list.add(VehiclePatio.fromJson(itemMap));
    });
    print('LISTA > $list');
    return list;
  }
}

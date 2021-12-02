import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/agreements/agreements_off_model.dart';
import 'package:app2park/moduleoff/name_table_model.dart';
import 'package:app2park/moduleoff/parked_vehicles.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AgreementsDao {
  static const String _tableAgreements = 'agreements';
  static const String tableAgreements = 'CREATE TABLE $_tableAgreements('
      '$_id INTEGER NULL, '
      '$_id_agreement_app INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_id_park INTEGER, '
      '$_id_user INTEGER, '
      '$_agreement_type INTEGER, '
      '$_date_time TEXT, '
      '$_agreement_begin TEXT,'
      '$_agreement_end TEXT, '
      '$_accountable_name TEXT, '
      '$_accountable_doc TEXT, '
      '$_accountable_cell TEXT, '
      '$_accountable_email TEXT,'
      '$_send_nf INTEGER, '
      '$_doc_nf INTEGER, '
      '$_company_name TEXT, '
      '$_company_doc TEXT , '
      '$_company_cell TEXT,'
      '$_company_email TEXT, '
      '$_bank_slip_send INTEGER, '
      '$_payment_day INTEGER, '
      '$_mon INTEGER, '
      '$_tue INTEGER,'
      '$_wed INTEGER, '
      '$_thur INTEGER,'
      '$_fri INTEGER, '
      '$_sat INTEGER,'
      '$_sun INTEGER, '
      '$_time_on TEXT,'
      '$_time_off TEXT,'
      '$_id_price_detached INTEGER, '
      '$_parking_spaces INTEGER,'
      '$_price REAL,'
      '$_plates TEXT, '
      '$_comment TEXT,'
      '$_status_payment INTEGER,'
      '$_until_payment TEXT NULL );';

  static const String _id = 'id';
  static const String _id_agreement_app = 'id_agreement_app ';
  static const String _id_park = 'id_park';
  static const String _id_user = 'id_user';
  static const String _agreement_type = 'agreement_type';
  static const String _date_time = 'date_time';
  static const String _agreement_begin = 'agreement_begin ';
  static const String _agreement_end = 'agreement_end';
  static const String _accountable_name = 'accountable_name';
  static const String _accountable_doc = 'accountable_doc';
  static const String _accountable_cell = 'accountable_cell';
  static const String _accountable_email = 'accountable_email';
  static const String _send_nf = 'send_nf';
  static const String _doc_nf = 'doc_nf';
  static const String _company_name = 'company_name';
  static const String _company_doc = 'company_doc';
  static const String _company_cell = 'company_cell';
  static const String _company_email = 'company_email';
  static const String _bank_slip_send = 'bank_slip_send';
  static const String _payment_day = 'payment_day';
  static const String _mon = 'mon';
  static const String _tue = 'tue';
  static const String _wed = 'wed';
  static const String _thur = 'thur';
  static const String _fri = 'fri';
  static const String _sat = 'sat';
  static const String _sun = 'sun';
  static const String _time_on = 'time_on';
  static const String _time_off = 'time_off';
  static const String _id_price_detached = 'id_price_detached';
  static const String _parking_spaces = 'parking_spaces';
  static const String _price = 'price';
  static const String _plates = 'plates';
  static const String _comment = 'comment';
  static const String _status_payment = 'status_payment';
  static const String _until_payment = 'until_payment';

  Future<int> saveAgreement(AgreementsOff agreement) async {
    final Database db = await getDatabase();
    Map<String, dynamic> agreementMap = _toMapAgreement(agreement);
    return db.insert(_tableAgreements, agreementMap);
  }

  Future<List<AgreementsOff>> findAllAgreement() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableAgreements);
    List<AgreementsOff> agreement = _toListAgreement(result);
    return agreement;
  }

  Future<bool> updateAgreements(int id, int id_agreement_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE agreements SET id = $id WHERE id_agreement_app = $id_agreement_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> updateAgreementsCash(int id_agreement_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE agreements SET status_payment = 1 WHERE id_agreement_app = $id_agreement_app');
    if(ids > 0){
      return true;
    }
    return false;
  }
  Future<bool> updateAgreementsUntilPayment(String untilPayment, int id_agreement_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE agreements SET until_payment = "$untilPayment" WHERE id_agreement_app = $id_agreement_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> verifyAgreement(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableAgreements,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<List<AgreementsOff>> getContracts(
      int id_park, int agreement_type) async {
    final Database db = await getDatabase();
    List<AgreementsOff> list = new List<AgreementsOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT *'
        ' FROM agreements'
        ' WHERE id_park = $id_park AND agreement_type = $agreement_type ORDER BY accountable_name ASC');
    dbList.forEach((itemMap) {
      list.add(AgreementsOff.fromJson(itemMap));
    });

    return list;
  }

  Future<bool> updateAgreement(
      int id_park,
      int id_agreement_app,
      String agreement_begin,
      String agreement_end,
      String accountable_name,
      String accountable_doc,
      String accountable_cell,
      String accountable_email,
      int send_nf,
      int doc_nf,
      String company_name,
      String company_doc,
      String company_cell,
      String company_email,
      int bank_slip_send,
      int payment_day,
      int mon,
      int tue,
      int wed,
      int thur,
      int fri,
      int sat,
      int sun,
      String time_on,
      String time_off,
      int id_price_detached,
      int parking_spaces,
      double price,
      String plates,
      String comment,
      int status_payment,
      String until_payment) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE agreements SET agreement_begin = "$agreement_begin", agreement_end = "$agreement_end", accountable_name = "$accountable_name", accountable_doc = "$accountable_doc", accountable_cell = "$accountable_cell", accountable_email = "$accountable_email", send_nf = "$send_nf", doc_nf = "$doc_nf", company_name = "$company_name", company_doc = "$company_doc", company_cell = "$company_cell", company_email = "$company_email", bank_slip_send = "$bank_slip_send", payment_day = "$payment_day", mon = "$mon", tue = "$tue", wed = "$wed", thur = "$thur", fri = "$fri", sat = "$sat", sun = "$sun", time_on = "$time_on", time_off = "$time_off", id_price_detached = "$id_price_detached", parking_spaces = "$parking_spaces", price = "$price", plates = "$plates", comment = "$comment", status_payment = "$status_payment", until_payment = "$until_payment" WHERE id_park = $id_park AND id_agreement_app = $id_agreement_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<List<NameTableModel>> nameTableAgreements(
      int id_price_detached, int id_park) async {
    final Database db = await getDatabase();
    List<NameTableModel> list = new List<NameTableModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT P.name FROM agreements AS A INNER JOIN price_detached AS P ON(A.id_price_detached = P.id_price_detached_app) WHERE A.id_price_detached = $id_price_detached AND A.id_park = $id_park');
    dbList.forEach((itemMap) {
      list.add(NameTableModel.fromJson(itemMap));
    });

    return list;
  }
  Future<List<AgreementsOff>> getAgreementsCash(
      int id_park) async {
    final Database db = await getDatabase();
    List<AgreementsOff> list = new List<AgreementsOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM agreements WHERE id_park = $id_park');
    dbList.forEach((itemMap) {
      list.add(AgreementsOff.fromJson(itemMap));
    });

    return list;
  }

  Future<int> getAgreement(int id) async {
    final Database db = await getDatabase();
    return Sqflite.firstIntValue(await db.rawQuery('SELECT id_agreement_app FROM agreements WHERE id = "$id"'));
  }

  Future<List<AgreementsOff>> SincUpdateAgreementById(
      int id) async {
    final Database db = await getDatabase();
    List<AgreementsOff> list = new List<AgreementsOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM agreements WHERE id = $id');
    dbList.forEach((itemMap) {
      list.add(AgreementsOff.fromJson(itemMap));
    });

    return list;
  }

  Future<List<AgreementsOff>> SincAgreementOff() async {
    final Database db = await getDatabase();
    List<AgreementsOff> list = new List<AgreementsOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM agreements WHERE id = 0');
    dbList.forEach((itemMap) {
      list.add(AgreementsOff.fromJson(itemMap));
    });

    return list;
  }



  Future<List<AgreementsOff>> getAgreementByPlate(
      int id_park, String plate) async {
    final Database db = await getDatabase();
    List<AgreementsOff> list = new List<AgreementsOff>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT * FROM agreements WHERE id_park = $id_park AND plates LIKE "%$plate%"');
    dbList.forEach((itemMap) {
      list.add(AgreementsOff.fromJson(itemMap));
    });

    return list;
  }

  Future<List<ParkedVehicles>> getParkedVehicles(int id_agreement_app, int id_park) async {
    final Database db = await getDatabase();
    List<ParkedVehicles> list = new List<ParkedVehicles>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        ' SELECT C.name, C.cell, C.email, X.type, V.plate, V.maker, V.model, V.color, V.year'
        ' FROM ticket_historic AS H LEFT JOIN tickets as T ON (H.id_ticket_app = T.id_ticket_app)'
        ' LEFT JOIN vehicles AS V ON(T.id_vehicle_app = V.id_vehicle_app)'
        ' LEFT JOIN customers AS C ON(T.id_customer_app = C.id_customer_app)'
        ' LEFT JOIN vehicle_type AS X ON(V.id_vehicle_type = X.id)'
        ' WHERE H.id_ticket_app'
        ' IN'
        ' (SELECT id_ticket_app FROM(SELECT * FROM ticket_historic AS H WHERE H.id_ticket_app IN'
        ' (SELECT H.id_ticket_app FROM ticket_historic AS H LEFT JOIN tickets AS T ON'
        ' (H.id_ticket_app = T.id_ticket_app) WHERE H.id_ticket_historic_status = 2 AND T.id_agreement_app = $id_agreement_app AND T.id_park = $id_park)'
        ' ORDER BY H.id_ticket_app ,H.id_ticket_historic_status DESC)GROUP BY id_ticket_app HAVING id_ticket_historic_status <> 11)GROUP BY H.id_ticket_app');
    dbList.forEach((itemMap) {
      list.add(ParkedVehicles.fromJson(itemMap));
    });

    return list;
  }

  Map<String, dynamic> _toMapAgreement(AgreementsOff agreement) {
    final Map<String, dynamic> agreementMap = Map();
    agreementMap['id'] = agreement.id;
    agreementMap['id_agreement_app'] = agreement.id_agreement_app;
    agreementMap['id_park'] = agreement.id_park;
    agreementMap['id_user'] = agreement.id_user;
    agreementMap['agreement_type'] = agreement.agreement_type;
    agreementMap['date_time'] = agreement.date_time;
    agreementMap['agreement_begin'] = agreement.agreement_begin;
    agreementMap['agreement_end'] = agreement.agreement_end;
    agreementMap['accountable_name'] = agreement.accountable_name;
    agreementMap['accountable_doc'] = agreement.accountable_doc;
    agreementMap['accountable_cell'] = agreement.accountable_cell;
    agreementMap['accountable_email'] = agreement.accountable_email;
    agreementMap['send_nf'] = agreement.send_nf;
    agreementMap['doc_nf'] = agreement.doc_nf;
    agreementMap['company_name'] = agreement.company_name;
    agreementMap['company_doc'] = agreement.company_doc;
    agreementMap['company_cell'] = agreement.company_cell;
    agreementMap['company_email'] = agreement.company_email;
    agreementMap['bank_slip_send'] = agreement.bank_slip_send;
    agreementMap['payment_day'] = agreement.payment_day;
    agreementMap['mon'] = agreement.mon;
    agreementMap['tue'] = agreement.tue;
    agreementMap['wed'] = agreement.wed;
    agreementMap['thur'] = agreement.thur;
    agreementMap['fri'] = agreement.fri;
    agreementMap['sat'] = agreement.sat;
    agreementMap['sun'] = agreement.sun;
    agreementMap['time_on'] = agreement.time_on;
    agreementMap['time_off'] = agreement.time_off;
    agreementMap['id_price_detached'] = agreement.id_price_detached;
    agreementMap['parking_spaces'] = agreement.parking_spaces;
    agreementMap['price'] = agreement.price;
    agreementMap['plates'] = agreement.plates;
    agreementMap['comment'] = agreement.comment;
    agreementMap['status_payment'] = agreement.status_payment;
    agreementMap['until_payment'] = agreement.until_payment;
    return agreementMap;
  }

  List<AgreementsOff> _toListAgreement(List<Map<String, dynamic>> result) {
    final List<AgreementsOff> agreement = List();
    for (Map<String, dynamic> row in result) {
      final AgreementsOff agreementsOff = AgreementsOff(
        row['id'],
        row['id_park'],
        row['id_user'],
        row['agreement_type'],
        row['date_time'],
        row['agreement_begin'],
        row['agreement_end'],
        row['accountable_name'],
        row['accountable_doc'],
        row['accountable_cell'],
        row['accountable_email'],
        row['send_nf'],
        row['doc_nf'],
        row['company_name'],
        row['company_doc'],
        row['company_cell'],
        row['company_email'],
        row['bank_slip_send'],
        row['payment_day'],
        row['mon'],
        row['tue'],
        row['wed'],
        row['thur'],
        row['fri'],
        row['sat'],
        row['sun'],
        row['time_on'],
        row['time_off'],
        row['id_price_detached'],
        row['parking_spaces'],
        row['price'],
        row['plates'],
        row['comment'],
        row['status_payment'],
        row['until_payment']
      );
      agreement.add(agreementsOff);
    }
    return agreement;
  }
}

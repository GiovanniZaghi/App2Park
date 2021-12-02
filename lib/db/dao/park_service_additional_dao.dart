import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/park_service_additional_off_model.dart';
import 'package:app2park/moduleoff/park_service_inner_join_service_additional_model.dart';
import 'package:sqflite/sqflite.dart';

class ParkServiceAdditionalDao {

  static const String _tableParkServiceAdditional = 'park_service_additional';
  static const String tableParkServiceAdditional = 'CREATE TABLE $_tableParkServiceAdditional('
      '$_id INTEGER, '
      '$_id_service_additional INTEGER, '
      '$_id_park INTEGER, '
      '$_price REAL, '
      '$_tolerance TEXT, '
      '$_sort_order INTEGER, '
      '$_status INTEGER, '
      '$_date_edited TEXT);';

  static const String _id = 'id';
  static const String _id_service_additional = 'id_service_additional';
  static const String _id_park = 'id_park';
  static const String _price = 'price';
  static const String _tolerance= 'tolerance';
  static const String _sort_order = 'sort_order';
  static const String _status = 'status';
  static const String _date_edited = 'date_edited';

  Future<int> saveParkServiceAdditional(ParkServiceAdditionalOffModel parkServiceAdditionalModel) async {
    final Database db = await getDatabase();
    Map<String, dynamic> parkServiceAdditionalMap = _toMapParkServiceAdditional(parkServiceAdditionalModel);
    return db.insert(_tableParkServiceAdditional, parkServiceAdditionalMap);
  }

  Future<List<ParkServiceAdditionalOffModel>> findAllParkServiceAdditional() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableParkServiceAdditional);
    List<ParkServiceAdditionalOffModel> parkServiceAdditionalList = _toListParkServiceAdditional(result);
    return parkServiceAdditionalList;
  }

  Future<bool> verifyParkServiceAdditional(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableParkServiceAdditional,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<List<ParkServiceInnerJoinServiceAdditionalModel>> getParkServiceAdditionalInnerJoin(
      int id_park) async {
    final Database db = await getDatabase();
    List<ParkServiceInnerJoinServiceAdditionalModel> list = new List<ParkServiceInnerJoinServiceAdditionalModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT S.id AS id_servico, S.name, P.id, P.status, P.price, P.tolerance, P.sort_order, V.type FROM service_additional AS S'
            ' LEFT JOIN (SELECT * FROM park_service_additional WHERE id_park = $id_park) AS P'
            ' ON (P.id_service_additional = S.id) LEFT JOIN vehicle_type AS V ON (S.id_vehicle_type = V.id)');
    dbList.forEach((itemMap) {
      list.add(ParkServiceInnerJoinServiceAdditionalModel.fromJson(itemMap));
    });
    return list;
  }

  Future<List<ParkServiceInnerJoinServiceAdditionalModel>> getParkServicesJoin(
      int id_park) async {
    final Database db = await getDatabase();
    List<ParkServiceInnerJoinServiceAdditionalModel> list = new List<ParkServiceInnerJoinServiceAdditionalModel>();
    List<Map<String, dynamic>> dbList = await db.rawQuery(
        'SELECT S.id AS id_servico, S.name, P.id, P.status, P.price, P.price as price_p, P.tolerance, P.sort_order, V.type FROM park_service_additional AS P'
            ' LEFT JOIN service_additional AS S ON(P.id_service_additional = S.id) '
            'LEFT JOIN vehicle_type AS V ON(S.id_vehicle_type = V.id) WHERE status = 1 AND id_park = $id_park');
    dbList.forEach((itemMap) {
      list.add(ParkServiceInnerJoinServiceAdditionalModel.fromJson(itemMap));
    });
    return list;
  }

  Future<bool> updateParkServiceAdditional(int id, double price, String tolerance, int status, int sort_order) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE park_service_additional SET price = $price, tolerance = "$tolerance", status = "$status", sort_order = "$sort_order" WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Future<bool> SincupdateParkServiceAdditional(int id, double price, String tolerance, int status, int sort_order) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE park_service_additional SET price = $price, tolerance = "$tolerance", status = "$status", sort_order = "$sort_order" WHERE id = $id');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapParkServiceAdditional(ParkServiceAdditionalOffModel parkServiceAdditionalModel) {
    final Map<String, dynamic> parkServiceAdditionalMap = Map();
    parkServiceAdditionalMap['id'] = parkServiceAdditionalModel.id;
    parkServiceAdditionalMap['id_service_additional'] = parkServiceAdditionalModel.id_service_additional;
    parkServiceAdditionalMap['id_park'] = parkServiceAdditionalModel.id_park;
    parkServiceAdditionalMap['price'] = parkServiceAdditionalModel.price;
    parkServiceAdditionalMap['tolerance'] = parkServiceAdditionalModel.tolerance;
    parkServiceAdditionalMap['sort_order'] = parkServiceAdditionalModel.sort_order;
    parkServiceAdditionalMap['status'] = parkServiceAdditionalModel.status;
    parkServiceAdditionalMap['date_edited'] = parkServiceAdditionalModel.date_edited;
    return parkServiceAdditionalMap;
  }

  List<ParkServiceAdditionalOffModel> _toListParkServiceAdditional(List<Map<String, dynamic>> result) {
    final List<ParkServiceAdditionalOffModel> parkServiceAdditionalList = List();
    for (Map<String, dynamic> row in result) {
      final ParkServiceAdditionalOffModel parkServiceAdditionalModel = ParkServiceAdditionalOffModel(
        row['id'],
        row['id_service_additional'],
        row['id_park'],
        row['price'],
        row['tolerance'],
        row['sort_order'],
        row['status'],
        row['date_edited'],
      );
      parkServiceAdditionalList.add(parkServiceAdditionalModel);
    }
    return parkServiceAdditionalList;
  }
}
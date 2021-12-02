import 'package:app2park/db/database.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_photo_off_model.dart';
import 'package:sqflite/sqflite.dart';

class TicketHistoricPhotoDao {

  static const String _tableTicketHistoricPhoto = 'ticket_historic_photo';
  static const String tableTicketHistoricPhoto = 'CREATE TABLE $_tableTicketHistoricPhoto('
      '$_id INTEGER NULL, '
      '$_id_ticket_historic INTEGER NULL, '
      '$_id_historic_photo_app INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_id_ticket_historic_app INTEGER, '
      '$_photo TEXT, '
      '$_date_time TEXT);';

  static const String _id = 'id';
  static const String _id_ticket_historic = 'id_ticket_historic';
  static const String _id_historic_photo_app = 'id_historic_photo_app';
  static const String _id_ticket_historic_app = 'id_ticket_historic_app';
  static const String _photo = 'photo';
  static const String _date_time = 'date_time';

  Future<int> saveTicketHistoricPhoto(TicketHistoricPhotoOffModel ticketHistoricPhoto) async {
    final Database db = await getDatabase();
    Map<String, dynamic> ticketHistoricPhotoMap = _toMapTicketHistoricPhoto(ticketHistoricPhoto);
    return db.insert(_tableTicketHistoricPhoto, ticketHistoricPhotoMap);
  }

  Future<List<TicketHistoricPhotoOffModel>> findAllTicketHistoricPhoto() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableTicketHistoricPhoto);
    List<TicketHistoricPhotoOffModel> ticketHistoricPhotoList = _toListTicketHistoricPhoto(result);
    return ticketHistoricPhotoList;
  }

  Future<bool> verifyTicketHistoricPhoto(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableTicketHistoricPhoto,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateTicketHistoricPhotoIdOn(int id, int id_ticket_historic,  String photo, int id_historic_photo_app) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate('UPDATE ticket_historic_photo SET id = $id, id_ticket_historic = $id_ticket_historic, photo = "$photo" WHERE id_historic_photo_app = $id_historic_photo_app');
    if(ids > 0){
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapTicketHistoricPhoto(TicketHistoricPhotoOffModel ticketHistoricPhoto) {
    final Map<String, dynamic> ticketHistoricPhotoMap = Map();
    ticketHistoricPhotoMap['id'] = ticketHistoricPhoto.id;
    ticketHistoricPhotoMap['id_ticket_historic'] = ticketHistoricPhoto.id_ticket_historic;
    ticketHistoricPhotoMap['id_historic_photo_app'] = ticketHistoricPhoto.id_historic_photo_app;
    ticketHistoricPhotoMap['id_ticket_historic_app'] = ticketHistoricPhoto.id_ticket_historic_app;
    ticketHistoricPhotoMap['photo'] = ticketHistoricPhoto.photo;
    ticketHistoricPhotoMap['date_time'] = ticketHistoricPhoto.date_time;

    return ticketHistoricPhotoMap;
  }

  List<TicketHistoricPhotoOffModel> _toListTicketHistoricPhoto(List<Map<String, dynamic>> result) {
    final List<TicketHistoricPhotoOffModel> ticketHistoricPhotoList = List();
    for (Map<String, dynamic> row in result) {
      final TicketHistoricPhotoOffModel ticketHistoricPhoto = TicketHistoricPhotoOffModel(
          row['id'],
          row['id_ticket_historic'],
          row['id_ticket_historic_app'],
          row['photo'],
          row['date_time']
      );
      ticketHistoricPhotoList.add(ticketHistoricPhoto);
    }
    return ticketHistoricPhotoList;
  }
}
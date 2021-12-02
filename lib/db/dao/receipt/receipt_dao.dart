import 'package:app2park/db/database.dart';
import 'package:app2park/module/receipt/receipt_send.dart';
import 'package:app2park/moduleoff/receipt/receipt_off.dart';
import 'package:sqflite/sqlite_api.dart';

class ReceiptDao{
  static const String _tableReceipt = 'receipt';
  static const String tableReceipt = 'CREATE TABLE $_tableReceipt('
      '$_id TEXT, '
      '$_id_receipt_app INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_id_ticket_app INTEGER, '
      '$_id_ticket TEXT,'
      '$_id_cupom TEXT,'
      '$_res TEXT );';

  static const String _id = 'id';
  static const String _id_receipt_app = 'id_receipt_app';
  static const String _id_ticket_app = 'id_ticket_app';
  static const String _id_ticket = 'id_ticket';
  static const String _id_cupom = 'id_cupom';
  static const String _res = 'res';


  Future<int> saveReceipt(ReceiptOff receipt) async {
    final Database db = await getDatabase();
    Map<String, dynamic> receiptMap = _toMapReceipt(receipt);
    return db.insert(_tableReceipt, receiptMap);
  }

  Future<List<ReceiptOff>> findAllReceipt() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableReceipt);
    List<ReceiptOff> receipts = _toListReceipt(result);
    return receipts;
  }

  Future<List<ReceiptOff>> getReceiptNoSincronized() async {
    final Database db = await getDatabase();
    List<ReceiptOff> list = new List<ReceiptOff>();
    List<Map<String, dynamic>> dbList = await db
        .rawQuery('SELECT * FROM receipt WHERE id = 0');
    dbList.forEach((itemMap) {
      list.add(ReceiptOff.fromJson(itemMap));
    });
    return list;
  }

  Future<bool> updateReceiptIdTicket(
      int id_ticket_app, int id_ticket) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE receipt SET id_ticket = $id_ticket WHERE id_ticket_app = $id_ticket_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<bool> updateReceiptId(
      int id_receipt_app, String id) async {
    final Database db = await getDatabase();
    int ids = await db.rawUpdate(
        'UPDATE receipt SET id = $id WHERE id_receipt_app = $id_receipt_app');
    if (ids > 0) {
      return true;
    }
    return false;
  }

  Future<void> deleteReceipt(int id_receipt_app) async {
    final Database db = await getDatabase();
    await db.delete(
      'receipt',
      where: "id_receipt_app = ?",
      whereArgs: [id_receipt_app],
    );
  }

  Future<bool> verifyReceipt(int id) async {
    final Database db = await getDatabase();
    List<Map> result = await db.query(_tableReceipt,
        columns: ['id'],
        where: 'id = ?',
        whereArgs: ['$id']);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> _toMapReceipt(ReceiptOff receipt) {
    final Map<String, dynamic> ReceiptMap = Map();
    ReceiptMap['id'] = receipt.id;
    ReceiptMap['id_receipt_app'] = receipt.id_receipt_app;
    ReceiptMap['id_ticket_app'] = receipt.id_ticket_app;
    ReceiptMap['id_ticket'] = receipt.id_ticket;
    ReceiptMap['id_cupom'] = receipt.id_cupom;
    ReceiptMap['res'] = receipt.res;


    return ReceiptMap;
  }

  List<ReceiptOff> _toListReceipt(List<Map<String, dynamic>> result) {
    final List<ReceiptOff> receipts = List();
    for (Map<String, dynamic> row in result) {
      final ReceiptOff receipt = ReceiptOff(
        row['id'] as String,
        row['id_ticket_app'] as int,
        row['id_ticket'] as String,
        row['id_cupom'] as String,
        row['res'] as String,
      );
      receipts.add(receipt);
    }
    return receipts;
  }

}
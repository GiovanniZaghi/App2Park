import 'package:app2park/module/receipt/receipt_send.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt_off.g.dart';

@JsonSerializable()
class ReceiptOff{
  int id_receipt_app;
  String id;
  int id_ticket_app;
  String id_ticket;
  String id_cupom;
  String res;

  ReceiptOff(this.id, this.id_ticket_app, this.id_ticket, this.id_cupom, this.res);

  @override
  String toString() {
    return 'Receipt{id_ticket: $id_ticket, res: $res}';
  }
  factory ReceiptOff.fromJson(Map<String, dynamic> json) => _$ReceiptOffFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptOffToJson(this);
}
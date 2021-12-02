import 'package:app2park/module/receipt/receipt_send.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt.g.dart';

@JsonSerializable()
class Receipt{
  String id_ticket;
  String id_cupom;
  String res;

  Receipt({this.id_ticket, this.id_cupom, this.res});


  @override
  String toString() {
    return '{"id_ticket": $id_ticket, "id_cupom": $id_cupom, "res": $res}';
  }

  factory Receipt.fromJson(Map<String, dynamic> json) => _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}
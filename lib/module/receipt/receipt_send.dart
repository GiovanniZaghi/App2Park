import 'package:json_annotation/json_annotation.dart';
import 'package:app2park/moduleoff/exit_service_additional_model.dart';
import 'package:app2park/app/helpers/price/extrato.dart';

part 'receipt_send.g.dart';

@JsonSerializable()
class ReceiptSend{
  String id;
  String name_park;
  String doc;
  String street;
  String number;
  String city;
  String state;
  String plate;
  String model;
  String data_ent;
  String data_sai;
  String exitserviceAdittionalList;
  String eList;
  String total;
  String taxa;
  String desconto;
  String total_pago;


  ReceiptSend({
      this.id,
      this.name_park,
      this.doc,
      this.street,
      this.number,
      this.city,
      this.state,
      this.plate,
      this.model,
      this.data_ent,
      this.data_sai,
      this.exitserviceAdittionalList,
      this.eList,
      this.total,
      this.taxa,
      this.desconto,
      this.total_pago});


  @override
  String toString() {
    return '{"id": "$id", "name_park": "$name_park", "doc": "$doc", "street": "$street", "number": "$number", "city": "$city", "state": "$state", "plate": "$plate", "model": "$model", "data_ent": "$data_ent", "data_sai": "$data_sai", "exitserviceAdittionalList": "$exitserviceAdittionalList", "eList": "$eList", "total": "$total", "taxa": "$taxa", "desconto": "$desconto", "total_pago": "$total_pago"}';
  }

  factory ReceiptSend.fromJson(Map<String, dynamic> json) => _$ReceiptSendFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptSendToJson(this);
}
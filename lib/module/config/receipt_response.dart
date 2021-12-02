import 'package:app2park/module/receipt/receipt.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt_response.g.dart';

@JsonSerializable()
class ReceiptResponse{
  String status;
  Receipt data;
  String message;

  ReceiptResponse({this.status, this.data, this.message});


  @override
  String toString() {
    return '{"status": "$status", "data": "$data", "message": "$message"}';
  }

  factory ReceiptResponse.fromJson(Map<String, dynamic> json) => _$ReceiptResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptResponseToJson(this);
}
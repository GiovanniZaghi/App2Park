import 'package:app2park/module/cashier/type/cash_type_movement_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_type_response.g.dart';

@JsonSerializable()
class CashTypeResponse{
  String status;
  List<CashTypeMovement> data;
  String message;

  CashTypeResponse({this.status, this.data, this.message});

  factory CashTypeResponse.fromJson(Map<String, dynamic> json) => _$CashTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CashTypeResponseToJson(this);

}
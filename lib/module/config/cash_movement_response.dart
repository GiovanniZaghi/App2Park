import 'package:app2park/module/cashier/movement/cash_movement_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_movement_response.g.dart';

@JsonSerializable()
class CashMovementResponse{
  String status;
  List<CashMovement> data;
  String message;

  CashMovementResponse({this.status, this.data, this.message});

  factory CashMovementResponse.fromJson(Map<String, dynamic> json) => _$CashMovementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CashMovementResponseToJson(this);

}
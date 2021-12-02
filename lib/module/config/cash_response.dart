import 'package:app2park/module/cashier/cashs_model.dart';
import 'package:app2park/module/cashier/movement/cash_movement_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_response.g.dart';

@JsonSerializable()
class CashResponse{
  String status;
  List<Cashs> data;
  String message;

  CashResponse({this.status, this.data, this.message});

  factory CashResponse.fromJson(Map<String, dynamic> json) => _$CashResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CashResponseToJson(this);

}
import 'package:json_annotation/json_annotation.dart';

part 'cash_type_movement_model.g.dart';

@JsonSerializable()
class CashTypeMovement{
  String id;
  String name;

  CashTypeMovement({this.id, this.name});

  factory CashTypeMovement.fromJson(Map<String, dynamic> json) =>
      _$CashTypeMovementFromJson(json);

  Map<String, dynamic> toJson() => _$CashTypeMovementToJson(this);
}
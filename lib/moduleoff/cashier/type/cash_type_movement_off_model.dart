import 'package:json_annotation/json_annotation.dart';

part 'cash_type_movement_off_model.g.dart';

@JsonSerializable()
class CashTypeMovementOff{
  int id;
  String name;

  CashTypeMovementOff(this.id, this.name);

  factory CashTypeMovementOff.fromJson(Map<String, dynamic> json) =>
      _$CashTypeMovementOffFromJson(json);

  Map<String, dynamic> toJson() => _$CashTypeMovementOffToJson(this);
}
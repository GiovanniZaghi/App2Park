import 'package:json_annotation/json_annotation.dart';

part 'cashs_off_model.g.dart';

@JsonSerializable()
class CashsOff{
  int id;
  int id_cash_app;
  int id_park;
  int id_user;

  CashsOff(this.id, this.id_park, this.id_user);

  factory CashsOff.fromJson(Map<String, dynamic> json) =>
      _$CashsOffFromJson(json);

  Map<String, dynamic> toJson() => _$CashsOffToJson(this);

  @override
  String toString() {
    return 'CashsOff{id: $id, id_cash_app: $id_cash_app, id_park: $id_park, id_user: $id_user}';
  }
}
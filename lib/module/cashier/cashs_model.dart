import 'package:json_annotation/json_annotation.dart';

part 'cashs_model.g.dart';

@JsonSerializable()
class Cashs{
  String id;
  String id_cash_app;
  String id_park;
  String id_user;

  Cashs({this.id, this.id_cash_app, this.id_park, this.id_user});

  factory Cashs.fromJson(Map<String, dynamic> json) =>
      _$CashsFromJson(json);

  Map<String, dynamic> toJson() => _$CashsToJson(this);
}
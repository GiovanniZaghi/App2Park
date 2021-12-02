import 'package:json_annotation/json_annotation.dart';

part 'cashs_innerjoin.g.dart';

@JsonSerializable()
class SelectCashStatus{
  int id_park;
  int id_user;
  int id_cash_app;
  int status;


  SelectCashStatus(this.id_park, this.id_user, this.id_cash_app, this.status);

  factory SelectCashStatus.fromJson(Map<String, dynamic> json) =>
      _$SelectCashStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SelectCashStatusToJson(this);


}
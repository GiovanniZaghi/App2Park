import 'package:json_annotation/json_annotation.dart';

part 'dashboard_money_graphics.g.dart';

@JsonSerializable()
class DashboardMoneyGraphics{
  int id;
  String tipo;
  String pagamento;
  double value;


  DashboardMoneyGraphics({this.id, this.tipo, this.pagamento, this.value});

  factory DashboardMoneyGraphics.fromJson(Map<String, dynamic> json) => _$DashboardMoneyGraphicsFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardMoneyGraphicsToJson(this);
}
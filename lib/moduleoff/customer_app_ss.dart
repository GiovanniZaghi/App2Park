import 'package:json_annotation/json_annotation.dart';

part 'customer_app_ss.g.dart';

@JsonSerializable()
class CustomerAppSS{
  int id_customer_app;

  CustomerAppSS(this.id_customer_app);

  factory CustomerAppSS.fromJson(Map<String, dynamic> json) => _$CustomerAppSSFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerAppSSToJson(this);
}
import 'package:json_annotation/json_annotation.dart';


part 'subscription_off_model.g.dart';

@JsonSerializable()
class SubscriptionOffModel{
  int id;
  int id_user;
  double subscription_price;
  int id_period;
  int id_send;
  String doc;
  String name;
  String email;
  String postal_code;
  String street;
  String number;
  String complement;
  String neighborhood;
  String city;
  String state;
  String ddd;
  String cell;
  String type;

  SubscriptionOffModel(
      this.id,
      this.id_user,
      this.subscription_price,
      this.id_period,
      this.id_send,
      this.doc,
      this.name,
      this.email,
      this.postal_code,
      this.street,
      this.number,
      this.complement,
      this.neighborhood,
      this.city,
      this.state,
      this.ddd,
      this.cell,
      this.type);

  factory SubscriptionOffModel.fromJson(Map<String, dynamic> json) => _$SubscriptionOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionOffModelToJson(this);
}
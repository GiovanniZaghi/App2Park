import 'package:json_annotation/json_annotation.dart';


part 'subscription_model.g.dart';

@JsonSerializable()
class SubscriptionModel{
  String id;
  String id_user;
  String subscription_price;
  String id_period;
  String id_send;
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

  SubscriptionModel(
      {this.id,
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
      this.type});

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);

}
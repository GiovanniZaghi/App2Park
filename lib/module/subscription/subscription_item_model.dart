import 'package:json_annotation/json_annotation.dart';


part 'subscription_item_model.g.dart';

@JsonSerializable()
class SubscriptionItemModel{
  String id;
  String id_subscription;
  String id_park;

  SubscriptionItemModel({this.id, this.id_subscription, this.id_park});

  factory SubscriptionItemModel.fromJson(Map<String, dynamic> json) => _$SubscriptionItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionItemModelToJson(this);
}
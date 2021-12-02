import 'package:json_annotation/json_annotation.dart';


part 'subscription_item_off_model.g.dart';

@JsonSerializable()
class SubscriptionItemOffModel{
  int id;
  int id_subscription;
  int id_park;

  SubscriptionItemOffModel(this.id, this.id_subscription, this.id_park);

  factory SubscriptionItemOffModel.fromJson(Map<String, dynamic> json) => _$SubscriptionItemOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionItemOffModelToJson(this);
}
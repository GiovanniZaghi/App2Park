import 'package:app2park/module/subscription/subscription_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_item_response.g.dart';

@JsonSerializable()
class SubscriptionItemResponse{
  String status;
  List<SubscriptionItemModel> data;
  String message;

  SubscriptionItemResponse({this.status, this.data, this.message});

  factory SubscriptionItemResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionItemResponseToJson(this);


}
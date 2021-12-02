import 'package:app2park/module/subscription/subscription_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_response.g.dart';

@JsonSerializable()
class SubscriptionResponse{
  String status;
  List<SubscriptionModel> data;
  String message;

  SubscriptionResponse({this.status, this.data, this.message});

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionResponseToJson(this);


}
import 'package:app2park/module/park/Park.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_update_response.g.dart';

@JsonSerializable()
class SubscriptionUpdateResponse{
  String status;
  List<Park> data;
  String message;

  SubscriptionUpdateResponse({this.status, this.data, this.message});

  factory SubscriptionUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionUpdateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionUpdateResponseToJson(this);


}
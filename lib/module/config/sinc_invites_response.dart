import 'package:app2park/module/puser/park_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sinc_invites_response.g.dart';

@JsonSerializable()
class SincInviteResponse{
  String status;
  List<ParkUser> puser;
  String message;

  SincInviteResponse({this.status, this.puser, this.message});

  factory SincInviteResponse.fromJson(Map<String, dynamic> json) =>
      _$SincInviteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SincInviteResponseToJson(this);


}
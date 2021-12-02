import 'package:app2park/module/puser/park_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'park_user_invite_response.g.dart';

@JsonSerializable()
class ParkUserInviteResponse{
  String status;
  List<ParkUser> puser;
  String message;
  String link_invite;

  ParkUserInviteResponse({this.status, this.puser, this.message, this.link_invite});

  factory ParkUserInviteResponse.fromJson(Map<String, dynamic> json) =>
      _$ParkUserInviteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParkUserInviteResponseToJson(this);


}
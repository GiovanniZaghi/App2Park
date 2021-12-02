import 'package:json_annotation/json_annotation.dart';


part 'RecoverEmail.g.dart';


@JsonSerializable()
class RecoverEmail{
  String email;
  String keyval;
  String pass;

  RecoverEmail({this.email, this.keyval, this.pass});

  factory RecoverEmail.fromJson(Map<String, dynamic> json) => _$RecoverEmailFromJson(json);

  Map<String, dynamic> toJson() => _$RecoverEmailToJson(this);

}
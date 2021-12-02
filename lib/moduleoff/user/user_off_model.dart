import 'package:json_annotation/json_annotation.dart';


part 'user_off_model.g.dart';

@JsonSerializable()
class UserOff{
  @JsonKey(nullable: true)
  String id;
  String first_name;
  String last_name;
  String cell;
  String doc;
  String email;
  String pass;
  String id_status;

  UserOff(
      this.id,
        this.first_name,
        this.last_name,
        this.cell,
        this.doc,
        this.email,
        this.pass,
        this.id_status);

  factory UserOff.fromJson(Map<String, dynamic> json) => _$UserOffFromJson(json);

  Map<String, dynamic> toJson() => _$UserOffToJson(this);
}

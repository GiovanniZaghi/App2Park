import 'package:json_annotation/json_annotation.dart';


part 'UserJwt.g.dart';

@JsonSerializable()
class UserJwt {
  String id;
  String first_name;
  String last_name;
  String cell;
  String doc;
  String email;
  String pass;
  String id_status;
  @JsonKey(name: 'jwt', required: true)
  String jwt;

  UserJwt(
      {this.id,
        this.first_name,
        this.last_name,
        this.cell,
        this.doc,
        this.email,
        this.pass,
        this.id_status,
        this.jwt});

  factory UserJwt.fromJson(Map<String, dynamic> json) => _$UserJwtFromJson(json);

  Map<String, dynamic> toJson() => _$UserJwtToJson(this);
}

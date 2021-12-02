import 'package:json_annotation/json_annotation.dart';


part 'User.g.dart';

@JsonSerializable()
class User {
  @JsonKey(nullable: true)
  String id;
  String first_name;
  String last_name;
  String cell;
  String doc;
  String email;
  String pass;
  String id_status;

  User(
      {this.id,
      this.first_name,
      this.last_name,
      this.cell,
      this.doc,
      this.email,
      this.pass,
      this.id_status});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

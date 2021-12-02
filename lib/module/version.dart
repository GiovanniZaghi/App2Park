import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

@JsonSerializable()
class Version{
  String id;
  String name;
  String id_status;

  Version({this.id, this.name, this.id_status});

  factory Version.fromJson(Map<String, dynamic> json) => _$VersionFromJson(json);

  Map<String, dynamic> toJson() => _$VersionToJson(this);
}
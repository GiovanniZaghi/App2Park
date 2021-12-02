import 'package:json_annotation/json_annotation.dart';

part 'version_off.g.dart';

@JsonSerializable()
class VersionOff{
  int id;
  String name;
  int id_status;

  VersionOff(this.id, this.name, this.id_status);

  factory VersionOff.fromJson(Map<String, dynamic> json) => _$VersionOffFromJson(json);

  Map<String, dynamic> toJson() => _$VersionOffToJson(this);
}
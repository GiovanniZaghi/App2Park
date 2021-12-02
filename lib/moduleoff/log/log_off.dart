import 'package:json_annotation/json_annotation.dart';

part 'log_off.g.dart';

@JsonSerializable()
class LogOff{
  int id_mob;
  String id;
  String id_user;
  String id_park;
  String error;
  String version;
  String created;
  String screen_error;
  String platform;

  LogOff(this.id, this.id_user, this.id_park, this.error, this.version, this.created,
    this.screen_error, this.platform);

  @override
  String toString() {
    return 'LogOff{id_mob: $id_mob, id: $id, id_user: $id_user, id_park: $id_park, error: $error, version: $version, created: $created, screen_error: $screen_error, platform: $platform}';
  }

  factory LogOff.fromJson(Map<String, dynamic> json) => _$LogOffFromJson(json);

  Map<String, dynamic> toJson() => _$LogOffToJson(this);
}
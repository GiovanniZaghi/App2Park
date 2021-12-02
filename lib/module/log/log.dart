import 'package:json_annotation/json_annotation.dart';

part 'log.g.dart';

@JsonSerializable()
class Log{
  String id;
  String id_user;
  String id_park;
  String error;
  String version;
  String created;
  String screen_error;
  String platform;

  Log({this.id_user, this.id_park, this.error, this.version, this.created,
      this.screen_error, this.platform});

  @override
  String toString() {
    return 'Log{id_user: $id_user, id_park: $id_park, error: $error, version: $version, created: $created, screen_error: $screen_error, platform: $platform}';
  }

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);

  Map<String, dynamic> toJson() => _$LogToJson(this);
}
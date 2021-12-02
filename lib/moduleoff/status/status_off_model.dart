import 'package:json_annotation/json_annotation.dart';

part 'status_off_model.g.dart';

@JsonSerializable()
class StatusOff {
  int id;
  String status;

  StatusOff(this.id, this.status);

  factory StatusOff.fromJson(Map<String, dynamic> json) =>
      _$StatusOffFromJson(json);

  Map<String, dynamic> toJson() => _$StatusOffToJson(this);

}

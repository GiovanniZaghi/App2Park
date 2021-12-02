import 'package:json_annotation/json_annotation.dart';

part 'status_model.g.dart';

@JsonSerializable()
class Status {
  String id;
  String status;

  Status({this.id, this.status});

  factory Status.fromJson(Map<String, dynamic> json) =>
      _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

}

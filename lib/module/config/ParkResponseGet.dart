import 'package:app2park/module/park/Park.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ParkResponseGet.g.dart';

@JsonSerializable()
class ParkResponseGet {
  final String status;
  @JsonKey(includeIfNull : false)
  final Park data;
  final String message;

  ParkResponseGet({this.status, this.data, this.message});

  factory ParkResponseGet.fromJson(Map<String, dynamic> json) =>
      _$ParkResponseGetFromJson(json);

  Map<String, dynamic> toJson() => _$ParkResponseGetToJson(this);
}

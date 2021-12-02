import 'package:json_annotation/json_annotation.dart';

part 'office_model.g.dart';

@JsonSerializable()
class Office{
  String id;
  String office;

  Office({this.id, this.office});

  factory Office.fromJson(Map<String, dynamic> json) =>
      _$OfficeFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeToJson(this);

}

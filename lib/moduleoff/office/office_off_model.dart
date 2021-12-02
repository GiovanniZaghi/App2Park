import 'package:json_annotation/json_annotation.dart';

part 'office_off_model.g.dart';

@JsonSerializable()
class OfficeOff {
  int id;
  String office;

  OfficeOff(this.id, this.office);

  factory OfficeOff.fromJson(Map<String, dynamic> json) =>
      _$OfficeOffFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeOffToJson(this);

  @override
  String toString() {
    return 'OfficeOff{id: $id, office: $office}';
  }
}

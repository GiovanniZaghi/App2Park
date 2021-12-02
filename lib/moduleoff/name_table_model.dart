import 'package:json_annotation/json_annotation.dart';

part 'name_table_model.g.dart';

@JsonSerializable()
class NameTableModel{
  String name;


  NameTableModel(this.name);

  factory NameTableModel.fromJson(Map<String, dynamic> json) => _$NameTableModelFromJson(json);

  Map<String, dynamic> toJson() => _$NameTableModelToJson(this);

}
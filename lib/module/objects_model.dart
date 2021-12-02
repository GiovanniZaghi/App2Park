import 'package:json_annotation/json_annotation.dart';


part 'objects_model.g.dart';

@JsonSerializable()
class ObjectsModel{
  String id;
  String name;
  String sort_order;

  ObjectsModel({this.id, this.name, this.sort_order});

  factory ObjectsModel.fromJson(Map<String, dynamic> json) => _$ObjectsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectsModelToJson(this);
}
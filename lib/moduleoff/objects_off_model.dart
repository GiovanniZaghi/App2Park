import 'package:json_annotation/json_annotation.dart';

part 'objects_off_model.g.dart';

@JsonSerializable()
class ObjectsOffModel{
  int id;
  String name;
  int sort_order;
  int tickado;

  ObjectsOffModel(this.id, this.name, this.sort_order);

  factory ObjectsOffModel.fromJson(Map<String, dynamic> json) => _$ObjectsOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectsOffModelToJson(this);

  @override
  String toString() {
    return 'ObjectsOffModel{id: $id, name: $name, sort_order: $sort_order, tickado: $tickado}';
  }
}
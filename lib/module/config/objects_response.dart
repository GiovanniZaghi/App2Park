import 'package:app2park/module/objects_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'objects_response.g.dart';

@JsonSerializable()
class ObjectsResponse{
  String status;
  List<ObjectsModel> data;
  String message;

  ObjectsResponse({this.status, this.data, this.message});

  factory ObjectsResponse.fromJson(Map<String, dynamic> json) =>
      _$ObjectsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectsResponseToJson(this);
}
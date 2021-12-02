import 'package:json_annotation/json_annotation.dart';

part 'sinc_model.g.dart';

@JsonSerializable()
class SincModel{
  String id_user;
  String sinc_time;

  SincModel({this.id_user, this.sinc_time});

  factory SincModel.fromJson(Map<String, dynamic> json) => _$SincModelFromJson(json);

  Map<String, dynamic> toJson() => _$SincModelToJson(this);
}
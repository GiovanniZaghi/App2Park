import 'package:json_annotation/json_annotation.dart';

part 'get_plate_by_cupom.g.dart';

@JsonSerializable()

class GetPlateByCupom{
  String plate;


  GetPlateByCupom(this.plate);

  factory GetPlateByCupom.fromJson(Map<String, dynamic> json) => _$GetPlateByCupomFromJson(json);

  Map<String, dynamic> toJson() => _$GetPlateByCupomToJson(this);
}
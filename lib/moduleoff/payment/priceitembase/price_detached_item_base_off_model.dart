import 'package:json_annotation/json_annotation.dart';

part 'price_detached_item_base_off_model.g.dart';

@JsonSerializable()
class PriceDetachedItemBaseOff{
  int id;
  String name;
  String time;
  String type;
  int level;
  int id_status;

  PriceDetachedItemBaseOff(
    this.id, this.name, this.time, this.type, this.level, this.id_status);

  factory PriceDetachedItemBaseOff.fromJson(Map<String, dynamic> json) =>
      _$PriceDetachedItemBaseOffFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetachedItemBaseOffToJson(this);
}
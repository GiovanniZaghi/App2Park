import 'package:json_annotation/json_annotation.dart';

part 'price_type_item_base_checkbox.g.dart';

@JsonSerializable()
class PriceTypeItemBaseCheckbox{
  String type;
  bool status;

  PriceTypeItemBaseCheckbox({this.type, this.status});

  factory PriceTypeItemBaseCheckbox.fromJson(Map<String, dynamic> json) => _$PriceTypeItemBaseCheckboxFromJson(json);

  Map<String, dynamic> toJson() => _$PriceTypeItemBaseCheckboxToJson(this);

  @override
  String toString() {
    return 'PriceTypeItemBaseCheckbox{type: $type, status: $status}';
  }
}
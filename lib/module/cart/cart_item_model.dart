import 'package:json_annotation/json_annotation.dart';


part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel{
  String id;
  String id_cart;
  String id_park;
  String id_period;
  String value;

  CartItemModel(
      {this.id, this.id_cart, this.id_park, this.id_period, this.value});

  factory CartItemModel.fromJson(Map<String, dynamic> json) => _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
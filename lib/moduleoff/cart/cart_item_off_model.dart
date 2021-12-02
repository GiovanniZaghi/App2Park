import 'package:json_annotation/json_annotation.dart';


part 'cart_item_off_model.g.dart';

@JsonSerializable()
class CartItemOffModel{
  int id;
  int id_cart;
  int id_park;
  int id_period;
  double value;

  CartItemOffModel(this.id, this.id_cart, this.id_park, this.id_period, this.value);

  factory CartItemOffModel.fromJson(Map<String, dynamic> json) => _$CartItemOffModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemOffModelToJson(this);
}
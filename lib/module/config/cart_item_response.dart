import 'package:app2park/module/cart/cart_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_response.g.dart';

@JsonSerializable()
class CartItemResponse{
  String status;
  CartItemModel data;
  String message;

  CartItemResponse({this.status, this.data, this.message});

  factory CartItemResponse.fromJson(Map<String, dynamic> json) => _$CartItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemResponseToJson(this);

}
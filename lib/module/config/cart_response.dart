import 'package:app2park/module/cart/cart_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse{
  String status;
  CartModel data;
  String message;

  CartResponse({this.status, this.data, this.message});

  factory CartResponse.fromJson(Map<String, dynamic> json) => _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);

}
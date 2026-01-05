import 'dart:convert';
import 'package:foody_licious/data/models/cart/cart_model.dart';

CartResponseModel cartResponseModelFromJson(String str) =>
    CartResponseModel.fromJson(json.decode(str));

String cartResponseModelToJson(CartResponseModel data) =>
    json.encode(data.toJson());

class CartResponseModel {
  final CartModel cartModel;
  const CartResponseModel({required this.cartModel});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(cartModel: CartModel.fromJson(json['cart']));
  }

  Map<String, dynamic> toJson() {
    return {"cart": cartModel};
  }
}

import 'dart:convert';
import 'package:foody_licious/data/models/cart/cart_item_model.dart';

CartItemsResponseModel cartItemsResponseModelFromJson(String str) =>
    CartItemsResponseModel.fromJson(json.decode(str));

String cartItemsResponseModelToJson(CartItemsResponseModel data) =>
    json.encode(data.toJson());

class CartItemsResponseModel {
  final List<CartItemModel> cartItems;
  const CartItemsResponseModel({required this.cartItems});

  factory CartItemsResponseModel.fromJson(Map<String, dynamic> json) {
    final cartItems = json['cartItems'] as List;
    return CartItemsResponseModel(
      cartItems: cartItems.map((e) => CartItemModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"cartItems": cartItems.map((e) => e.toJson()).toList()};
  }
}

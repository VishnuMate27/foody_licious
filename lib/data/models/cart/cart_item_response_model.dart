import 'dart:convert';
import 'package:foody_licious/data/models/cart/cart_item_model.dart';

CartItemResponseModel cartItemResponseModelFromJson(String str) {
  return CartItemResponseModel.fromJson(json.decode(str));
}

String cartItemResponseModelToJson(CartItemResponseModel data) =>
    json.encode(data.toJson());

class CartItemResponseModel {
  final CartItemModel? cartItem;
  const CartItemResponseModel({required this.cartItem});

  factory CartItemResponseModel.fromJson(Map<String, dynamic> json) {
    return CartItemResponseModel(
      cartItem: CartItemModel.fromJson(
        json['cartItem'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"cartItem": cartItem};
  }
}

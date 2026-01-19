import 'dart:convert';
import 'package:foody_licious/data/models/cart/cart_item_model.dart';

CartItemResponseModel cartItemResponseModelFromJson(String str) {
  return CartItemResponseModel.fromJson(json.decode(str));
}

String cartItemResponseModelToJson(CartItemResponseModel data) =>
    json.encode(data.toJson());

class CartItemResponseModel {
  final CartItemModel? cartItem;

  const CartItemResponseModel({this.cartItem});

  factory CartItemResponseModel.fromJson(Map<String, dynamic> json) {
    return CartItemResponseModel(
      cartItem: json['cartItem'] == null
          ? null
          : CartItemModel.fromJson(
              json['cartItem'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cartItem": cartItem?.toJson(),
    };
  }
}

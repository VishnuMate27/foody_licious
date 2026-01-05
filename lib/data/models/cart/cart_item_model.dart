import 'dart:convert';
import 'package:foody_licious/data/models/menuItem/menu_item_model.dart';
import 'package:foody_licious/domain/entities/cart/cartItem.dart';

CartItemModel cartItemsModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemsModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.menuItemId,
    required super.quantity,
    required super.price,
    required super.totalPrice,
    super.menuItem,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      menuItemId: json['menuItemId'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      menuItem: MenuItemModel.fromJson(json['menuItem']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "menuItemId": menuItemId,
      "quantity": quantity,
      "price": price,
      "totalPrice": totalPrice,
      "menuItem": menuItem,
    };
  }
}

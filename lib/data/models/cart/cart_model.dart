import 'dart:convert';
import 'package:foody_licious/domain/entities/cart/cart.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) =>
    json.encode(data.toJson());

class CartModel extends Cart {
  const CartModel({
    required super.id,
    required super.restaurantId,
    required super.userId,
    required super.items,
    required super.totalAmount,
    required super.status,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      userId: json['userId'] ?? '',
      items: json['items'] ?? [],
      totalAmount: json['totalAmount'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "restaurantId": restaurantId,
      "userId": userId,
      "items": items,
      "totalAmount": totalAmount,
      "status": status
    };
  }
}

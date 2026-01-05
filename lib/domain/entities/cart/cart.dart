import 'package:equatable/equatable.dart';
import 'package:foody_licious/domain/entities/cart/cartItem.dart';

class Cart extends Equatable {
  final String id;
  final String restaurantId;
  final String userId;
  final List<CartItem> items;
  final int totalAmount;
  final String status;

  const Cart({
    required this.id,
    required this.restaurantId,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
  });

  Cart copyWith(
      {String? id,
      String? restaurantId,
      String? userId,
      List<CartItem>? items,
      int? totalAmount,
      String? status}) {
    return Cart(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      userId: this.userId,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        restaurantId,
        userId,
        items,
        totalAmount,
        status,
      ];
}

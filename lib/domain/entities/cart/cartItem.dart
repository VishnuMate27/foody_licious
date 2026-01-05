import 'package:equatable/equatable.dart';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';

class CartItem extends Equatable {
  final String menuItemId;
  final int quantity;
  final int price;
  final int totalPrice;
  final MenuItem? menuItem;

  const CartItem({
    required this.menuItemId,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    this.menuItem,
  });

  CartItem copyWith({
    String? menuItemId,
    int? quantity,
    int? price,
    int? totalPrice,
    MenuItem? menuItem,
  }) {
    return CartItem(
      menuItemId: menuItemId ?? this.menuItemId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
      menuItem: menuItem,
    );
  }

  @override
  List<Object?> get props => [
        menuItemId,
        quantity,
        price,
        totalPrice,
        menuItem,
      ];
}

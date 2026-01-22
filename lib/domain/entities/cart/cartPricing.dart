import 'package:equatable/equatable.dart';

class CartPricingDetails extends Equatable {
  final double totalCartAmount;
  final double gstCharges;
  final double platformFees;
  final double deliveryCharges;
  final double grandTotalAmount;

  const CartPricingDetails({
    required this.totalCartAmount,
    required this.gstCharges,
    required this.platformFees,
    required this.deliveryCharges,
    required this.grandTotalAmount,
  });

  CartPricingDetails copyWith({
    double? totalCartAmount,
    double? gstCharges,
    double? platformFees,
    double? deliveryCharges,
    double? grandTotalAmount,
  }) {
    return CartPricingDetails(
      totalCartAmount: this.totalCartAmount,
      gstCharges: this.gstCharges,
      platformFees: this.platformFees,
      deliveryCharges: this.deliveryCharges,
      grandTotalAmount: this.grandTotalAmount,
    );
  }

  @override
  List<Object?> get props => [
        totalCartAmount,
        gstCharges,
        platformFees,
        deliveryCharges,
        grandTotalAmount,
      ];
}

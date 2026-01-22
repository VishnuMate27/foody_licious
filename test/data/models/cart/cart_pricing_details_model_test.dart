import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/domain/entities/cart/cartPricing.dart';
import '../../../fixtures/constant_objects.dart';

void main() {
  test(
    'CartPricingDetailsModel should be a subclass of CartPricingDetails entity',
    () async {
      /// Assert
      expect(tCartPricingDetailsModel, isA<CartPricingDetails>());
    },
  );
}
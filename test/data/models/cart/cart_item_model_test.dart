import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/domain/entities/cart/cartItem.dart';
import '../../../fixtures/constant_objects.dart';

void main() {
  test(
    'CartItemModel should be a subclass of CartItem entity',
    () async {
      /// Assert
      expect(tCartItemModel, isA<CartItem>());
    },
  );
}
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/domain/entities/cart/cart.dart';
import '../../../fixtures/constant_objects.dart';

void main() {
  test(
    'CartModel should be a subclass of Cart entity',
    () async {
      /// Assert
      expect(tCartModel, isA<Cart>());
    },
  );
}
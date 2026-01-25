import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/domain/entities/checkout/place_order_details.dart';
import '../../../fixtures/constant_objects.dart';

void main() {
  test(
    'PlaceOrderModel should be a subclass of PlaceOrderDetails entity',
    () async {
      /// Assert
      expect(tPlaceOrderModel, isA<PlaceOrderDetails>());
    },
  );
}

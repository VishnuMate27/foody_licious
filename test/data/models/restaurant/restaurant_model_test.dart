import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/domain/entities/restaurant/restaurant.dart';
import '../../../fixtures/constant_objects.dart';

void main() {
  test(
    'RestaurantModel should be a subclass of User entity',
    () async {
      /// Assert
      expect(tRestaurantModel, isA<Restaurant>());
    },
  );
}
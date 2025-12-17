import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious/domain/usecase/restaurant/get_restaurant_details_usecase.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, Restaurant>> getRestaurantDetails(GetRestaurantDetailsParams params);
}

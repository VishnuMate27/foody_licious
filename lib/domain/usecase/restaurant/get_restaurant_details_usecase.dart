import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious/domain/repositories/restaurant_repository.dart';

class GetRestaurantDetailsUseCase
    extends UseCase<Restaurant, GetRestaurantDetailsParams> {
  final RestaurantRepository repository;
  GetRestaurantDetailsUseCase(this.repository);
  @override
  Future<Either<Failure, Restaurant>> call(
      GetRestaurantDetailsParams params) async {
    return await repository.getRestaurantDetails(params);
  }
}

class GetRestaurantDetailsParams {
  String restaurantId;
  GetRestaurantDetailsParams(this.restaurantId);
}

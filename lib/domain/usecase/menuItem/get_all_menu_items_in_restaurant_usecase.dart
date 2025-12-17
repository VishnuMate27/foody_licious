import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';

class GetAllMenuItemsInRestaurantUseCase
    extends UseCase<List<MenuItem>, GetAllMenuItemsInRestaurantParams> {
  @override
  Future<Either<Failure, List<MenuItem>>> call(params) {
    throw UnimplementedError();
  }
}

class GetAllMenuItemsInRestaurantParams {
  String restaurantId;
  GetAllMenuItemsInRestaurantParams(this.restaurantId);
}

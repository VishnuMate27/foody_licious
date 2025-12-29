import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious/domain/repositories/menu_item_repository.dart';

class GetAllMenuItemsInRestaurantUseCase
    extends UseCase<List<MenuItem>, GetAllMenuItemsInRestaurantParams> {
  final MenuItemRepository repository;
  GetAllMenuItemsInRestaurantUseCase(this.repository);
  @override
  Future<Either<Failure, List<MenuItem>>> call(
      GetAllMenuItemsInRestaurantParams params) async {
    return await repository.getAllItemsInRestaurant(params);
  }
}

class GetAllMenuItemsInRestaurantParams {
  String restaurantId;
  int page;
  int limit;
  GetAllMenuItemsInRestaurantParams({
    required this.restaurantId,
    required this.page,
    required this.limit,
  });
}

import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_in_restaurant_usecase.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_usecase.dart';

abstract class MenuItemRepository {
  Future<Either<Failure, List<MenuItem>>> getAllItemsInRestaurantsOfUsersCity(
      GetAllItemsInRestaurantsOfUsersCityParams params);
  Future<Either<Failure, List<MenuItem>>> getAllItemsInRestaurant(
      GetAllMenuItemsInRestaurantParams params);
}

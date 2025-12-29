import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/data/data_sources/remote/menu_remote_data_source.dart';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious/domain/repositories/menu_item_repository.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_in_restaurant_usecase.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_usecase.dart';

class MenuItemRepositoryImpl implements MenuItemRepository {
  final MenuItemsRemoteDataSource menuItemsRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  MenuItemRepositoryImpl({
    required this.menuItemsRemoteDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MenuItem>>> getAllItemsInRestaurantsOfUsersCity(
    GetAllItemsInRestaurantsOfUsersCityParams params,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = await userLocalDataSource.getUser();
      params.userId = user.id;
      final remoteResponse =
          await menuItemsRemoteDataSource.getAllItemsInRestaurantsOfUsersCity(
        params,
      );
      return Right(remoteResponse.menuItems);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<MenuItem>>> getAllItemsInRestaurant(
    GetAllMenuItemsInRestaurantParams params,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse =
          await menuItemsRemoteDataSource.getAllItemsInRestaurant(
        params,
      );
      return Right(remoteResponse.menuItems);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}

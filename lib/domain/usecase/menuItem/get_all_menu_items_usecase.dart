import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious/domain/repositories/menu_item_repository.dart';

class GetAllItemsInRestaurantsOfUsersCityUseCase
    implements UseCase<List<MenuItem>, GetAllItemsInRestaurantsOfUsersCityParams> {
  final MenuItemRepository repository;

  GetAllItemsInRestaurantsOfUsersCityUseCase(this.repository);
  @override
  Future<Either<Failure, List<MenuItem>>> call(
    GetAllItemsInRestaurantsOfUsersCityParams params,
  ) async {
    return await repository.getAllItemsInRestaurantsOfUsersCity(params);
  }
}

class GetAllItemsInRestaurantsOfUsersCityParams {
  String? userId;
  int page;
  int limit;
  GetAllItemsInRestaurantsOfUsersCityParams({
    this.userId,
    required this.page,
    required this.limit,
  });
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (userId != null) data['user_id'] = userId;
    data['page'] = page;
    data['limit'] = limit; 
    return data;
  }
}

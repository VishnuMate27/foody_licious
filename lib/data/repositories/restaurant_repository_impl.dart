import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/remote/restaurant_remote_data_source.dart';
import 'package:foody_licious/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious/domain/repositories/restaurant_repository.dart';
import 'package:foody_licious/domain/usecase/restaurant/get_restaurant_details_usecase.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  RestaurantRepositoryImpl({required this.remoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, Restaurant>> getRestaurantDetails(
      GetRestaurantDetailsParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.getRestaurantDetails(
        params,
      );
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/data/data_sources/remote/checkout_remote_data_source.dart';
import 'package:foody_licious/domain/entities/checkout/place_order_details.dart';
import 'package:foody_licious/domain/repositories/checkout_repository.dart';
import 'package:foody_licious/domain/usecase/checkout/cancel_checkout_usecase.dart';
import 'package:foody_licious/domain/usecase/checkout/place_order_usecase.dart';

class CheckoutRepositoryImpl extends CheckoutRepository {
  final CheckoutRemoteDataSource checkoutRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;
  CheckoutRepositoryImpl({
    required this.checkoutRemoteDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PlaceOrderDetails>> placeOrder(
      PlaceOrderParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = await userLocalDataSource.getUser();
      params.userId = user.id;
      final remoteResponse = await checkoutRemoteDataSource.placeOrder(
        params,
      );
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelCheckout(
      CancelCheckoutParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await checkoutRemoteDataSource.cancelCheckout(
        params,
      );
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }


}

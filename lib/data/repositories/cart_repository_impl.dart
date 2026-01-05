import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:foody_licious/domain/entities/cart/cartItem.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';
import 'package:foody_licious/domain/usecase/cart/add_item_to_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/decrease_item_quantity_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/delete_item_in_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/get_all_cart_item_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/increase_item_quantity_usecase.dart';

class CartRepositoryImpl extends CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;
  CartRepositoryImpl({
    required this.cartRemoteDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CartItem>>> getAllCartItem(
      GetAllCartItemParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = await userLocalDataSource.getUser();
      params.userId = user.id;
      final remoteResponse = await cartRemoteDataSource.getAllCartItem(
        params,
      );
      return Right(remoteResponse.cartItems);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> addItemToCart(
      AddItemToCartParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = await userLocalDataSource.getUser();
      params.userId = user.id;
      final remoteResponse = await cartRemoteDataSource.addItemToCart(
        params,
      );
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItemInCart(
      DeleteItemInCartParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = await userLocalDataSource.getUser();
      params.userId = user.id;
      final remoteResponse = await cartRemoteDataSource.deleteItemInCart(
        params,
      );
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, CartItem>> increaseItemQuantity(
      IncreaseItemQuantityParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = await userLocalDataSource.getUser();
      params.userId = user.id;
      final remoteResponse = await cartRemoteDataSource.increaseItemQuantity(
        params,
      );
      return Right(remoteResponse.cartItem!);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, CartItem?>> decreaseItemQuantity(
      DecreaseItemQuantityParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = await userLocalDataSource.getUser();
      params.userId = user.id;
      final remoteResponse = await cartRemoteDataSource.decreaseItemQuantity(
        params,
      );
      return Right(remoteResponse.cartItem);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}

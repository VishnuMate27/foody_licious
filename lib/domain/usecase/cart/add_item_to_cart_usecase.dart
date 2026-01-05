import 'dart:core';
import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';

class AddItemToCartUseCase implements UseCase<Unit, AddItemToCartParams> {
  final CartRepository repository;
  const AddItemToCartUseCase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(AddItemToCartParams params) {
    return repository.addItemToCart(params);
  }
}

class AddItemToCartParams {
  String? userId;
  final String menuItemId;
  final String restaurantId;
  AddItemToCartParams({
    required this.menuItemId,
    required this.restaurantId,
    this.userId,
  });
}

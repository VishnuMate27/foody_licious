import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/cart/cartItem.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';

class GetAllCartItemUseCase
    implements UseCase<List<CartItem>, GetAllCartItemParams> {
  final CartRepository repository;
  GetAllCartItemUseCase(this.repository);
  @override
  Future<Either<Failure, List<CartItem>>> call(GetAllCartItemParams params) {
    return repository.getAllCartItem(params);
  }
}

class GetAllCartItemParams {
   String? userId;
   int page;
   int limit;
   GetAllCartItemParams({
    this.userId,
    required this.page,
    required this.limit,
  });
}

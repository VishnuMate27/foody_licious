import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';

class DeleteItemInCartUseCase implements UseCase<Unit, DeleteItemInCartParams> {
  final CartRepository repository;
  DeleteItemInCartUseCase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(DeleteItemInCartParams params) async {
    return await repository.deleteItemInCart(params);
  }
}

class DeleteItemInCartParams {
  String menuItemId;
  String? userId;
  String? cartId;
  DeleteItemInCartParams({
    required this.menuItemId,
    this.userId,
    this.cartId,
  });
}

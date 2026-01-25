import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/checkout/place_order_details.dart';
import 'package:foody_licious/domain/repositories/checkout_repository.dart';

class PlaceOrderUseCase extends UseCase<PlaceOrderDetails, PlaceOrderParams> {
  final CheckoutRepository repository;
  PlaceOrderUseCase(this.repository);
  @override
  Future<Either<Failure, PlaceOrderDetails>> call(
      PlaceOrderParams params) async {
    return await repository.placeOrder(params);
  }
}

class PlaceOrderParams {
  String? userId;
  String name;
  String address;
  String phone;
  PlaceOrderParams({
    this.userId,
    required this.name,
    required this.address,
    required this.phone,
  });
}

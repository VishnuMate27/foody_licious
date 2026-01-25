import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/checkout/place_order_details.dart';
import 'package:foody_licious/domain/usecase/checkout/cancel_checkout_usecase.dart';
import 'package:foody_licious/domain/usecase/checkout/place_order_usecase.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, PlaceOrderDetails>> placeOrder(
      PlaceOrderParams params);
  Future<Either<Failure, Unit>> cancelCheckout(
      CancelCheckoutParams params);    
}

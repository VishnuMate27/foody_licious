import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/remote/payment_remote_data_source.dart';
import 'package:foody_licious/domain/repositories/payment_repository.dart';
import 'package:foody_licious/domain/usecase/payment/complete_payment_usecase.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  PaymentRemoteDataSource paymentRemoteDataSource;
  NetworkInfo networkInfo;
  PaymentRepositoryImpl({
    required this.paymentRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> completePayment(PaymentParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse =
          await paymentRemoteDataSource.completePayment(params);
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}

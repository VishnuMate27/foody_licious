import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';

class UpdateUserUseCase extends UseCase<User, UpdateUserParams> {
  final UserRepository repository;
  UpdateUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateUserParams params) async {
    return await repository.updateUser(params);
  }
}

class UpdateUserParams {
  String? id;
  final String? name;
  final String? email;
  final String? phone;
  final AddressModel? address;
  final List<String>? orderHistory;

  UpdateUserParams({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.orderHistory,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (address != null) data['address'] = address!.toJson();
    if (orderHistory != null) data['orderHistory'] = orderHistory;
    
    return data;
  }
}
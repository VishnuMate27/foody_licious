import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRemoteDataSource {
  User checkUser();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  User? user;
  final FirebaseAuth firebaseAuth;
  UserRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  User checkUser() {
    User user;
    user = firebaseAuth.currentUser!;
    return user;
  }
}

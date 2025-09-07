import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../models/user/user_model.dart';

abstract class UserLocalDataSource {

  Future<UserModel> getUser();

  Future<void> saveUser(UserModel user);

  Future<void> clearCache();
}

const cachedUser = 'USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;
  UserLocalDataSourceImpl(
      {required this.sharedPreferences, required this.secureStorage});


  @override
  Future<UserModel> getUser() async {
    if (sharedPreferences.getBool('first_run') ?? true) {
      await secureStorage.deleteAll();
      sharedPreferences.setBool('first_run', false);
    }
    final jsonString = sharedPreferences.getString(cachedUser);
    if (jsonString != null) {
      return Future.value(userModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveUser(UserModel user) {
    return sharedPreferences.setString(
      cachedUser,
      userModelToJson(user),
    );
  }

  @override
  Future<void> clearCache() async {
    await secureStorage.deleteAll();
    // await sharedPreferences.remove(cachedCart);
    await sharedPreferences.remove(cachedUser);
  }
}
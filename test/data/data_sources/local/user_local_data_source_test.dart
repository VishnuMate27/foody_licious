import 'package:foody_licious/core/error/exceptions.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixture/constant_objects.dart';

// import '../../../fixtures/constant_objects.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late UserLocalDataSourceImpl userLocalDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    userLocalDataSource = UserLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getUser', () {
    test('should return a UserModel when it is available', () async {
      /// Arrange
      when(() => mockSharedPreferences.getBool('first_run'))
          .thenAnswer((_) => true);
      when(() => mockSharedPreferences.setBool('first_run', false))
          .thenAnswer((_) => Future<bool>.value(true));
      when(() => mockSharedPreferences.getString(cachedUser))
          .thenReturn(userModelToJson(tUserModel));

      /// Act
      final result = await userLocalDataSource.getUser();

      /// Assert
      expect(result, isA<UserModel>());
      verify(() => mockSharedPreferences.getString(cachedUser)).called(1);
    });

    test('should throw CacheException when UserModel is not available',
        () async {
      /// Arrange
      when(() => mockSharedPreferences.getBool('first_run'))
          .thenAnswer((_) => false);
      when(() => mockSharedPreferences.getString(cachedUser)).thenReturn(null);

      /// Act and Assert
      expect(
          () => userLocalDataSource.getUser(), throwsA(isA<CacheException>()));
      verify(() => mockSharedPreferences.getString(cachedUser)).called(1);
    });
  });

  group('saveUser', () {
    test('should save the user', () async {
      /// Arrange
      when(() => mockSharedPreferences.setString(
              cachedUser, userModelToJson(tUserModel)))
          .thenAnswer((invocation) => Future<bool>.value(true));

      /// Act
      await userLocalDataSource.saveUser(tUserModel);

      /// Assert
      verify(() => mockSharedPreferences.setString(
          cachedUser, userModelToJson(tUserModel))).called(1);
    });
  });

  group('clearCache', () {
    test('should clear the cache', () async {
      /// Arrange
      when(() => mockSharedPreferences.remove(cachedUser))
          .thenAnswer((_) => Future<bool>.value(true));

      /// Act
      await userLocalDataSource.clearCache();

      /// Assert
      verify(() => mockSharedPreferences.remove(cachedUser)).called(1);
    });
  });
}
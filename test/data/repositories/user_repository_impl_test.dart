import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/data/data_sources/remote/user_remote_data_source.dart';
import 'package:foody_licious/data/repositories/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../fixtures/constant_objects.dart';

class MockRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late UserRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('checkUser', () {

    test('should return Right(User) when localDataSource.getUser succeeds',
        () async {
      // arrange
      when(() => mockLocalDataSource.getUser()).thenAnswer((_) async => tUserModel);

      // act
      final result = await repository.checkUser();

      // assert
      verify(() => mockLocalDataSource.getUser()).called(1);
      expect(result, Right(tUserModel));
    });

    test(
        'should return Left(Failure) when localDataSource.getUser throws Failure',
        () async {
      // arrange
      final tFailure = CacheFailure();
      when(() => mockLocalDataSource.getUser()).thenThrow(tFailure);

      // act
      final result = await repository.checkUser();

      // assert
      verify(() => mockLocalDataSource.getUser()).called(1);
      expect(result, Left(tFailure));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/data_sources/remote/restaurant_remote_data_source.dart';
import 'package:foody_licious/data/models/restaurant/restaurant_response_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late RestaurantRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    dataSource = RestaurantRemoteDataSourceImpl(client: mockHttpClient);
  });

  test('use BASE_URL from env', () {
    expect(kBaseUrlTest, contains('http')); // ✅ now available everywhere
  });

  group('getRestaurantDetails', () {
    var expectedUrl =
        '$kBaseUrlTest/api/users/restaurant/restaurantDetails?restaurant_id=${tGetRestaurantDetailsParams.restaurantId}';
    final fakeResponse = fixture('restaurant/restaurant_response_model.json');
    test('should perform a GET request to correct URL with params', () async {
      /// Arrange
      when(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result =
          await dataSource.getRestaurantDetails(tGetRestaurantDetailsParams);

      /// Assert
      verify(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).called(1);
      expect(result, isA<RestaurantResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      /// Arrange
      when(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response('Error', 400));

      /// Act & Assert
      expect(
        () async =>
            await dataSource.getRestaurantDetails(tGetRestaurantDetailsParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw RestaurantNotExistsFailure on 404', () async {
      /// Arrange
      when(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response('Error', 404));

      /// Act & Assert
      expect(
        () async =>
            await dataSource.getRestaurantDetails(tGetRestaurantDetailsParams),
        throwsA(isA<RestaurantNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
      /// Arrange
      when(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response('Error', 500));

      /// Act & Assert
      expect(
        () async =>
            dataSource.getRestaurantDetails(tGetRestaurantDetailsParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}

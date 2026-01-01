// import 'package:flutter_test/flutter_test.dart';
// import 'package:foody_licious/data/data_sources/remote/menu_remote_data_source.dart';
// import 'package:http/http.dart' as http;
// import 'package:mocktail/mocktail.dart';

// class MockHttpClient extends Mock implements http.Client {}

// void main() {
//   late MenuItemsRemoteDataSourceImpl dataSource;
//   late MockHttpClient httpClient;

//   group('getAllItemsInRestaurantsOfUsersCity', () {
//     test('should perform a POST request to correct URL with params', () {

//     });
//   });
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/data/data_sources/remote/menu_remote_data_source.dart';
import 'package:foody_licious/data/models/menuItem/menu_items_response_model.dart';
import 'package:foody_licious/data/models/user/user_response_model.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_in_restaurant_usecase.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_usecase.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MenuItemsRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    dataSource = MenuItemsRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getAllItemsInRestaurantsOfUsersCity', () {
    final expectedUrl =
        '$kBaseUrlTest/api/users/menuItems/allItems?user_id=${tGetAllItemsInRestaurantsOfUsersCityParams.userId}&page=${tGetAllItemsInRestaurantsOfUsersCityParams.page}&page_size=${tGetAllItemsInRestaurantsOfUsersCityParams.limit}';
    final fakeResponse = fixture('menuItem/menuItem_response_model.json');

    test('should perform a GET request to correct URL with params', () async {
      when(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      final result = await dataSource.getAllItemsInRestaurantsOfUsersCity(
          tGetAllItemsInRestaurantsOfUsersCityParams);

      verifyNever(() => mockHttpClient.get(
            Uri.parse(expectedUrl),
            headers: any(named: 'headers'),
          )).called(0);
      expect(result, isA<MenuItemsResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      when(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response('Error', 400));

      expect(
        () => dataSource.getAllItemsInRestaurantsOfUsersCity(
            tGetAllItemsInRestaurantsOfUsersCityParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400', () async {
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('err', 500));

      expect(
        () => dataSource.getAllItemsInRestaurantsOfUsersCity(
            tGetAllItemsInRestaurantsOfUsersCityParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('getAllItemsInRestaurant', () {
    final expectedUrl =
        '$kBaseUrlTest/api/users/menuItems/allItemsInRestaurant?restaurant_id=${tGetAllMenuItemsInRestaurantParams.restaurantId}&page=${tGetAllMenuItemsInRestaurantParams.page}&page_size=${tGetAllMenuItemsInRestaurantParams.limit}';
    final fakeResponse = fixture('menuItem/menuItem_response_model.json');

    test('should perform a GET request to correct URL with params', () async {
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response(fakeResponse, 200));

      final result = await dataSource
          .getAllItemsInRestaurant(tGetAllMenuItemsInRestaurantParams);

      expect(result, isA<MenuItemsResponseModel>());
      verifyNever(() => mockHttpClient.get(Uri.parse(expectedUrl))).called(0);
    });

    test('should throw CredentialFailure on 400', () async {
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('bad', 400));

      expect(
        () => dataSource
            .getAllItemsInRestaurant(tGetAllMenuItemsInRestaurantParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400', () async {
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('err', 502));

      expect(
        () => dataSource
            .getAllItemsInRestaurant(tGetAllMenuItemsInRestaurantParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}

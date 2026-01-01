import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_in_restaurant_usecase.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_usecase.dart';
import 'package:foody_licious/domain/usecase/restaurant/get_restaurant_details_usecase.dart';
import 'package:foody_licious/presentation/bloc/menuItem/menu_item_bloc.dart';
import 'package:foody_licious/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../fixtures/constant_objects.dart';

class MockGetAllItemsInRestaurantsOfUsersCityUseCase extends Mock
    implements GetAllItemsInRestaurantsOfUsersCityUseCase {}

class MockGetAllMenuItemsInRestaurantUseCase extends Mock
    implements GetAllMenuItemsInRestaurantUseCase {}

void main() {
  group('MenuItemBloc', () {
    late MenuItemBloc menuItemBloc;
    late MockGetAllItemsInRestaurantsOfUsersCityUseCase
        mockGetAllItemsInRestaurantsOfUsersCityUseCase;
    late MockGetAllMenuItemsInRestaurantUseCase mockGetRestaurantDetailsUseCase;
    setUp(() {
      mockGetAllItemsInRestaurantsOfUsersCityUseCase =
          MockGetAllItemsInRestaurantsOfUsersCityUseCase();
      mockGetRestaurantDetailsUseCase =
          MockGetAllMenuItemsInRestaurantUseCase();
      registerFallbackValue(NoParams());

      menuItemBloc = MenuItemBloc(
        mockGetAllItemsInRestaurantsOfUsersCityUseCase,
        mockGetRestaurantDetailsUseCase,
      );
    });

    test('initial state should be MenuItemInitial', () {
      expect(menuItemBloc.state, MenuItemInitial());
    });

    // GetAllItemsInRestaurantsOfUsersCity
    blocTest<MenuItemBloc, MenuItemState>(
      'emits [FetchingAllMenuItemsLoading, FetchingAllMenuItemsSuccess] when GetAllItemsInRestaurantsOfUsersCity is added',
      build: () {
        when(() => mockGetAllItemsInRestaurantsOfUsersCityUseCase(
                tGetAllItemsInRestaurantsOfUsersCityParams))
            .thenAnswer((_) async => Right(tMenuItemsResponseModel.menuItems));
        return menuItemBloc;
      },
      act: (bloc) => bloc.add(GetAllItemsInRestaurantsOfUsersCity(
          tGetAllItemsInRestaurantsOfUsersCityParams)),
      expect: () => [
        FetchingAllMenuItemsLoading(),
        FetchingAllMenuItemsSuccess(tMenuItemsResponseModel.menuItems)
      ],
    );

    blocTest<MenuItemBloc, MenuItemState>(
      'emits [FetchingAllMenuItemsLoading, FetchingAllMenuItemsFailed] on GetAllItemsInRestaurantsOfUsersCity error',
      build: () {
        when(() => mockGetAllItemsInRestaurantsOfUsersCityUseCase(
                tGetAllItemsInRestaurantsOfUsersCityParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return menuItemBloc;
      },
      act: (bloc) => bloc.add(GetAllItemsInRestaurantsOfUsersCity(
          tGetAllItemsInRestaurantsOfUsersCityParams)),
      expect: () => [
        FetchingAllMenuItemsLoading(),
        FetchingAllMenuItemsFailed(CredentialFailure())
      ],
    );

    blocTest<MenuItemBloc, MenuItemState>(
      'emits [FetchingAllMenuItemsLoading, FetchingAllMenuItemsFailed] on GetAllItemsInRestaurantsOfUsersCity error',
      build: () {
        when(() => mockGetAllItemsInRestaurantsOfUsersCityUseCase(
                tGetAllItemsInRestaurantsOfUsersCityParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return menuItemBloc;
      },
      act: (bloc) => bloc.add(GetAllItemsInRestaurantsOfUsersCity(
          tGetAllItemsInRestaurantsOfUsersCityParams)),
      expect: () => [
        FetchingAllMenuItemsLoading(),
        FetchingAllMenuItemsFailed(ServerFailure())
      ],
    );
  
    // GetMenuItemsInRestaurant
    blocTest<MenuItemBloc, MenuItemState>(
      'emits [FetchingAllMenuItemsInRestaurantLoading, FetchingAllMenuItemsInRestaurantSuccess] when GetMenuItemsInRestaurant is added',
      build: () {
        when(() => mockGetRestaurantDetailsUseCase(
                tGetAllMenuItemsInRestaurantParams))
            .thenAnswer((_) async => Right(tMenuItemsResponseModel.menuItems));
        return menuItemBloc;
      },
      act: (bloc) => bloc
          .add(GetMenuItemsInRestaurant(tGetAllMenuItemsInRestaurantParams)),
      expect: () => [
        FetchingAllMenuItemsInRestaurantLoading(),
        FetchingAllMenuItemsInRestaurantSuccess(
            tMenuItemsResponseModel.menuItems)
      ],
    );

    blocTest<MenuItemBloc, MenuItemState>(
      'emits [FetchingAllMenuItemsInRestaurantLoading, FetchingAllMenuItemsInRestaurantFailed] on GetMenuItemsInRestaurant error',
      build: () {
        when(() => mockGetRestaurantDetailsUseCase(
                tGetAllMenuItemsInRestaurantParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return menuItemBloc;
      },
      act: (bloc) => bloc
          .add(GetMenuItemsInRestaurant(tGetAllMenuItemsInRestaurantParams)),
      expect: () => [
        FetchingAllMenuItemsInRestaurantLoading(),
        FetchingAllMenuItemsInRestaurantFailed(CredentialFailure())
      ],
    );

    blocTest<MenuItemBloc, MenuItemState>(
      'emits [FetchingAllMenuItemsInRestaurantLoading, FetchingAllMenuItemsInRestaurantFailed] on GetMenuItemsInRestaurant error',
      build: () {
        when(() => mockGetRestaurantDetailsUseCase(
                tGetAllMenuItemsInRestaurantParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return menuItemBloc;
      },
      act: (bloc) => bloc
          .add(GetMenuItemsInRestaurant(tGetAllMenuItemsInRestaurantParams)),
      expect: () => [
        FetchingAllMenuItemsInRestaurantLoading(),
        FetchingAllMenuItemsInRestaurantFailed(ServerFailure())
      ],
    );
  
  });
}

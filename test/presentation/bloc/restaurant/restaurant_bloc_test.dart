import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/restaurant/get_restaurant_details_usecase.dart';
import 'package:foody_licious/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../fixtures/constant_objects.dart';

class MockGetRestaurantDetailsUseCase extends Mock
    implements GetRestaurantDetailsUseCase {}

void main() {
  group('RestaurantBloc', () {
    late RestaurantBloc restaurantBloc;
    late MockGetRestaurantDetailsUseCase mockGetRestaurantDetailsUseCase;
    setUp(() {
      mockGetRestaurantDetailsUseCase = MockGetRestaurantDetailsUseCase();
      registerFallbackValue(NoParams());

      restaurantBloc = RestaurantBloc(
        mockGetRestaurantDetailsUseCase,
      );
    });

    test('initial state should be RestaurantInitial', () {
      expect(restaurantBloc.state, RestaurantInitial());
    });

    // FetchRestaurantDetails
    blocTest<RestaurantBloc, RestaurantState>(
      'emits [FetchingRestaurantDetails, RestaurantDetailsFetchSuccess] when FetchRestaurantDetails is added',
      build: () {
        when(() => mockGetRestaurantDetailsUseCase(tGetRestaurantDetailsParams))
            .thenAnswer(
                (_) async => Right(tRestaurantResponseModel.restaurant));
        return restaurantBloc;
      },
      act: (bloc) =>
          bloc.add(FetchRestaurantDetails(tGetRestaurantDetailsParams)),
      expect: () => [
        FetchingRestaurantDetails(),
        RestaurantDetailsFetchSuccess(tRestaurantResponseModel.restaurant)
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [FetchingRestaurantDetails, RestaurantDetailsFetchFail] on FetchRestaurantDetails error',
      build: () {
        when(() => mockGetRestaurantDetailsUseCase(tGetRestaurantDetailsParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return restaurantBloc;
      },
      act: (bloc) =>
          bloc.add(FetchRestaurantDetails(tGetRestaurantDetailsParams)),
      expect: () => [
        FetchingRestaurantDetails(),
        RestaurantDetailsFetchFail(CredentialFailure())
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [FetchingRestaurantDetails, RestaurantDetailsFetchFail] on FetchRestaurantDetails error',
      build: () {
        when(() => mockGetRestaurantDetailsUseCase(tGetRestaurantDetailsParams))
            .thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
        return restaurantBloc;
      },
      act: (bloc) =>
          bloc.add(FetchRestaurantDetails(tGetRestaurantDetailsParams)),
      expect: () => [
        FetchingRestaurantDetails(),
        RestaurantDetailsFetchFail(RestaurantNotExistsFailure())
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [FetchingRestaurantDetails, RestaurantDetailsFetchFail] on FetchRestaurantDetails error',
      build: () {
        when(() => mockGetRestaurantDetailsUseCase(tGetRestaurantDetailsParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return restaurantBloc;
      },
      act: (bloc) =>
          bloc.add(FetchRestaurantDetails(tGetRestaurantDetailsParams)),
      expect: () => [
        FetchingRestaurantDetails(),
        RestaurantDetailsFetchFail(ServerFailure())
      ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [FetchingRestaurantDetails, RestaurantDetailsFetchFail] on FetchRestaurantDetails error',
      build: () {
        when(() => mockGetRestaurantDetailsUseCase(tGetRestaurantDetailsParams))
            .thenAnswer((_) async => Left(ExceptionFailure("Failure Message")));
        return restaurantBloc;
      },
      act: (bloc) =>
          bloc.add(FetchRestaurantDetails(tGetRestaurantDetailsParams)),
      expect: () => [
        FetchingRestaurantDetails(),
        RestaurantDetailsFetchFail(ExceptionFailure("Failure Message"))
      ],
    );
  });
}

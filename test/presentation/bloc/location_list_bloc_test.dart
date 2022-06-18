import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/common/error/error_popup_view_model.dart';
import 'package:flutter_wolt_assignment/data/coordinate_list.dart';
import 'package:flutter_wolt_assignment/presentation/bloc/location_list_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../domain/repository/api_repository_test.mocks.dart';
import '../../mocks/mock_data.dart';

void main() {
  late MockApiRepo repository;
  late LocationListBloc bloc;

  setUp(() {
    repository = MockApiRepo();
    bloc = LocationListBloc(repository);
    when(repository.getRestaurantsList(
            coordinateList[0].lat, coordinateList[0].long))
        .thenAnswer((_) async => Left(restaurantsByLocationModel));
  });

  blocTest<LocationListBloc, LocationListState>(
    'Test get restaurants list',
    build: () {
      return bloc;
    },
    act: (bloc) {
      bloc.getRestaurantsList();
    },
    wait: const Duration(seconds: 10),
    expect: () => [
      isA<LocationListState>(),
      isA<LocationListState>(),
    ],
  );

  blocTest<LocationListBloc, LocationListState>(
    'Test Get restaurants list error state',
    build: () {
      return bloc;
    },
    act: (bloc) {
      when(repository.getRestaurantsList(
              coordinateList[0].lat, coordinateList[0].long))
          .thenAnswer((_) async => Right(ErrorPopupViewModel.initialized()));
      bloc.getRestaurantsList();
    },
    wait: const Duration(seconds: 10),
    expect: () => [
      isA<LocationListState>(),
      isA<LocationListState>(),
    ],
  );

  test('Test add to favorite', () {
    bloc.restaurantsList.add(restaurantInfo);
    bloc.addFavorite("5ae6013cf78b5a000bb64022");
    expect(bloc.favoriteList[0], '5ae6013cf78b5a000bb64022');
    expect(bloc.restaurantsList[0].isFavorite, true);
  });

  test('Test remove favorite', () {
    bloc.restaurantsList.add(restaurantInfo);
    bloc.addFavorite("5ae6013cf78b5a000bb64022");
    bloc.removeFavorite("5ae6013cf78b5a000bb64022");
    expect(bloc.favoriteList, isEmpty);
    expect(bloc.restaurantsList[0].isFavorite, false);
  });

  tearDown(() {
    bloc.close();
  });
}

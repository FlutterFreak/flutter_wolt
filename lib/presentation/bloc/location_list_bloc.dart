import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wolt_assignment/core/common/base_state.dart';
import 'package:flutter_wolt_assignment/data/coordinate_list.dart';

import '../../core/common/error/error_popup_view_model.dart';
import '../../core/common/loading_indicator_view_model.dart';
import '../../domain/entity/restaurant_info.dart';
import '../../domain/repository/api_repository.dart';
import '../viewModel/restaurants_list_view_model.dart';

part 'location_list_state.dart';

class LocationListBloc extends Cubit<LocationListState> {
  final ApiRepo _apiRepository;

  LocationListBloc(this._apiRepository)
      : super(LocationListState.initialized());

  List<String> favoriteList = [];
  List<RestaurantInfo> restaurantsList = [];
  StreamSubscription? streamSubscription;

  Future<void> getRestaurantsList() async {
    var timer = Stream.periodic(const Duration(seconds: 10), (count) => count);

    streamSubscription = timer.listen((tick) async {
      emit(state.loading());
      var coordinateIndex = tick == 0
          ? 0
          : tick % 10 == 0
              ? 9
              : (tick % 10) - 1;

      var result = await _apiRepository.getRestaurantsList(
          coordinateList[coordinateIndex].lat,
          coordinateList[coordinateIndex].long);
      result!.fold((success) {
        if (success!.sections![1].items != null &&
            success.sections![1].items!.isNotEmpty) {
          restaurantsList.clear();
          for (var element in success!.sections![1].items!) {
            restaurantsList.add(RestaurantInfo(
              id: element.venue!.id,
              name: element.venue!.name,
              shortDescription: element.venue!.shortDescription,
              url: element.image!.url,
              isFavorite: favoriteList.contains(element.venue!.id),
            ));
          }
        }
        emit(state.copyWith(
            loader: const LoadingIndicatorViewModel.loaded(),
            data: RestaurantsListViewModel(restaurantsList: restaurantsList)));
      }, (failure) {
        streamSubscription?.cancel();
        emit(state.copyWith(
          loader: const LoadingIndicatorViewModel.loaded(),
        ));
        emit(state.withError(failure!));
      });
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }

  void addFavorite(String id) {
    emit(state.copyWith(loader: const LoadingIndicatorViewModel.loading()));
    if (restaurantsList.isNotEmpty) {
      favoriteList.add(id);
      int index = restaurantsList.indexWhere((element) => element.id == id);
      var item = restaurantsList.elementAt(index);
      item = item.copyWith(isFavorite: true);
      restaurantsList.removeAt(index);
      restaurantsList.insert(index, item);
    }
    emit(state.copyWith(
        loader: const LoadingIndicatorViewModel.loaded(),
        data: RestaurantsListViewModel(restaurantsList: restaurantsList)));
  }

  void removeFavorite(String id) {
    emit(state.copyWith(loader: const LoadingIndicatorViewModel.loading()));
    if (restaurantsList.isNotEmpty) {
      favoriteList.remove(id);
      int index = restaurantsList.indexWhere((element) => element.id == id);
      var item = restaurantsList.elementAt(index);
      item = item.copyWith(isFavorite: false);
      restaurantsList.removeAt(index);
      restaurantsList.insert(index, item);
    }
    emit(state.copyWith(
        loader: const LoadingIndicatorViewModel.loaded(),
        data: RestaurantsListViewModel(restaurantsList: restaurantsList)));
  }
}

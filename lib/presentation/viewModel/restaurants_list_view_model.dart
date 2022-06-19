import 'package:equatable/equatable.dart';
import 'package:flutter_wolt_assignment/domain/entity/restaurant_info.dart';

class RestaurantsListViewModel with EquatableMixin {
  final List<RestaurantInfo>? restaurantsList;

  RestaurantsListViewModel({this.restaurantsList});

  @override
  List<Object?> get props => [restaurantsList];

  RestaurantsListViewModel.initialized() : this(restaurantsList: []);
}

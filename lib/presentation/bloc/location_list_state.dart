part of 'location_list_bloc.dart';

class LocationListState extends BaseState<LocationListState> {
  @override
  final LoadingIndicatorViewModel loader;
  @override
  final ErrorPopupViewModel error;
  final RestaurantsListViewModel data;

  LocationListState(
      {required this.loader, required this.error, required this.data});

  @override
  List<Object?> get props => [loader, error, data];

  LocationListState.initialized()
      : this(
            loader: const LoadingIndicatorViewModel.initialized(),
            error: ErrorPopupViewModel.initialized(),
            data: RestaurantsListViewModel.initialized());

  @override
  LocationListState copyWith({
    LoadingIndicatorViewModel? loader,
    ErrorPopupViewModel? error,
    RestaurantsListViewModel? data,
  }) {
    return LocationListState(
        loader: loader ?? this.loader,
        error: error ?? this.error,
        data: data ?? this.data);
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/common/error/error_popup_view_model.dart';
import 'package:flutter_wolt_assignment/core/common/loading_indicator_view_model.dart';
import 'package:flutter_wolt_assignment/presentation/bloc/location_list_bloc.dart';
import 'package:flutter_wolt_assignment/presentation/viewModel/restaurants_list_view_model.dart';

void main() {
  testWidgets('LocationList state test...', (tester) async {
    final state = LocationListState.initialized().copyWith(
      data: RestaurantsListViewModel.initialized(),
      loader: const LoadingIndicatorViewModel.initialized(),
      error: ErrorPopupViewModel.initialized(),
    );
    expect(state.props.length, 3);
    expect(state.copyWith(), state.copyWith());
  });
}

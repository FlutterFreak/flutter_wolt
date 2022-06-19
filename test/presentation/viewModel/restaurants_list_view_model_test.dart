import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/presentation/viewModel/restaurants_list_view_model.dart';

void main() {
  test('RestaurantsListViewModel initialized constructor test', () {
    var data = RestaurantsListViewModel.initialized();
    expect(data.restaurantsList, []);
  });
  test('RestaurantsListViewModel instance equality test', () {
    var data = RestaurantsListViewModel.initialized();
    expect(data.props.length, 1);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/presentation/viewModel/restaurants_list_view_model.dart';

import '../../mocks/mock_data.dart';

void main() {
  test('RestaurantsListViewModel initialized constructor test', () {
    var data = RestaurantsListViewModel.initialized();
    expect(data.restaurantsList, []);
  });
  test('RestaurantsListViewModel instance equality test', () {
    var data = RestaurantsListViewModel.initialized();
    expect(data.props.length, 1);
  });
  test('RestaurantsListViewModel copy with function test', () {
    var data = RestaurantsListViewModel.initialized();
    expect(data.restaurantsList!.length, 0);
    data = data.copyWith(restaurantsList: [restaurantInfo]);
    expect(data.restaurantsList!.isNotEmpty, true);
    expect(data.restaurantsList!.length, 1);
  });
}

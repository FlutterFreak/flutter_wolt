import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/constants/strings.dart';
import 'package:flutter_wolt_assignment/data/coordinate_list.dart';
import 'package:flutter_wolt_assignment/domain/repository/api_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock_data.dart';
import 'api_repository_test.mocks.dart';

@GenerateMocks([Dio])
@GenerateMocks([ApiRepo])
void main() {
  late ApiRepository apiRepository;
  late MockDio dio;
  setUp(() {
    dio = MockDio();
    apiRepository = ApiRepository();
    final response = Response(
        requestOptions: RequestOptions(path: "", baseUrl: AppStrings.baseUrl),
        data: restaurantsByLocationModel);
    const path = AppStrings.baseUrl;
    when(dio.get(path, queryParameters: {
      "lat": coordinateList[0].lat,
      "lon": coordinateList[0].long
    })).thenAnswer((_) async => response);
  });

  test('ApiRepository => getRestaurantsList', () async {
    final result = await apiRepository.getRestaurantsList(
        coordinateList[0].lat, coordinateList[0].long);
    expect(result!.isLeft(), true);
  });
}

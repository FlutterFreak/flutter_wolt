import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/constants/strings.dart';
import 'package:flutter_wolt_assignment/data/coordinate_list.dart';
import 'package:flutter_wolt_assignment/domain/repository/api_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../flutter_test_utilities.dart';
import '../../mocks/mock_data.dart';
import 'api_repository_test.mocks.dart';

@GenerateMocks([Dio])
@GenerateMocks([ApiRepo])
void main() {
  late ApiRepository apiRepository;
  late MockDio dio;
  Response response;
  setUp(() {
    dio = MockDio();
    apiRepository = ApiRepository(dio: dio);
    response = Response(
        requestOptions: RequestOptions(path: "", baseUrl: AppStrings.baseUrl),
        data: restaurantsByLocation);
    when(dio.get(any, queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => response);
  });

  test('ApiRepository => getRestaurantsList', () async {
    final result = await apiRepository.getRestaurantsList(
        coordinateList[0].lat, coordinateList[0].lat);
    expect(result!.isLeft(), true);
  });

  test('ApiRepository => getRestaurantsList error', () async {
    when(dio.get(any, queryParameters: anyNamed('queryParameters'))).thenThrow(
        (_) async =>
            dioError(error: AppStrings.noInternet, type: DioErrorType.other));

    final result = await apiRepository.getRestaurantsList(
        coordinateList[0].lat, coordinateList[0].long);
    expect(result!.isRight(), true);
  });
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_wolt_assignment/core/common/error/error_popup_view_model.dart';

import '../../Data/Model/restaurants_by_location.dart';
import '../../core/common/error/network_exceptions.dart';
import '../../core/constants/strings.dart';

abstract class ApiRepo {
  Future<Either<RestaurantsByLocation?, ErrorPopupViewModel?>>?
      getRestaurantsList(double? lat, double? long);
}

class ApiRepository extends ApiRepo {
  Dio dio = Dio();
  String baseUrl = AppStrings.baseUrl;

  @override
  Future<Either<RestaurantsByLocation?, ErrorPopupViewModel?>>?
      getRestaurantsList(double? lat, double? long) async {
    final queryParameters = <String, dynamic>{"lat": lat, "lon": long};

    try {
      var result = await dio.get(baseUrl, queryParameters: queryParameters);
      var value = RestaurantsByLocation.fromJson(result.data);
      return Left(value);
    } catch (e) {
      var networkException = NetworkExceptions.getDioException(e);
      var error = NetworkExceptions.getErrorMessage(networkException);
      if (error == AppStrings.noInternet) {
        return Right(ErrorPopupViewModel.noInternet());
      } else {
        return Right(ErrorPopupViewModel(
          title: AppStrings.error.toUpperCase(),
          description: error,
        ));
      }
    }
  }
}

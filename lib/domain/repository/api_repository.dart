import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_wolt_assignment/Data/Model/restaurants_by_location.dart';
import 'package:flutter_wolt_assignment/core/common/error/error_popup_view_model.dart';
import 'package:flutter_wolt_assignment/core/common/error/network_exceptions.dart';
import 'package:flutter_wolt_assignment/core/constants/strings.dart';

abstract class ApiRepo {
  Future<Either<RestaurantsByLocation?, ErrorPopupViewModel?>>?
      getRestaurantsList(double? lat, double? long);
}

class ApiRepository extends ApiRepo {
  Dio dio;

  ApiRepository({required this.dio});

  @override
  Future<Either<RestaurantsByLocation?, ErrorPopupViewModel?>>?
      getRestaurantsList(double? lat, double? long) async {
    final queryParameters = <String, dynamic>{
      AppStrings.lat: lat,
      AppStrings.long: long
    };

    try {
      var result =
          await dio.get(AppStrings.baseUrl, queryParameters: queryParameters);
      var value = RestaurantsByLocation.fromJson(result.data);
      return Left(value);
    } catch (e) {
      var networkException = NetworkExceptions.getDioException(e);
      var error = NetworkExceptions.getErrorMessage(networkException);
      return Right(ErrorPopupViewModel(
        title: AppStrings.error,
        description: error,
      ));
    }
  }
}

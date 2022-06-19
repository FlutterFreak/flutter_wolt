import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/common/error/network_exceptions.dart';
import 'package:flutter_wolt_assignment/core/constants/strings.dart';

import '../../../flutter_test_utilities.dart';

void main() {
  // Network exceptions getDioException method tests
  test('Network exceptions FormatException test', () {
    NetworkExceptions networkException =
        NetworkExceptions.getDioException(FormatException);
    expect(networkException, const NetworkExceptions.unexpectedError());
  });
  test('Network exceptions SocketException test', () {
    NetworkExceptions networkException =
        NetworkExceptions.getDioException(SocketException);
    expect(networkException, const NetworkExceptions.unexpectedError());
  });

  test('Network exceptions unexpected error test', () {
    NetworkExceptions networkException =
        NetworkExceptions.getDioException(AppStrings.unexpectedError);
    expect(networkException, const NetworkExceptions.unexpectedError());
  });

  test('Network exceptions request timeout test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            error: AppStrings.connectionTimeout,
            type: DioErrorType.connectTimeout));
    expect(networkException, const NetworkExceptions.requestTimeout());
  });

  test('Network exceptions request cancelled test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            error: AppStrings.requestCancelled, type: DioErrorType.cancel));
    expect(networkException, const NetworkExceptions.requestCancelled());
  });

  test('Network exceptions no internet connection error test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(error: AppStrings.noInternet, type: DioErrorType.other));
    expect(networkException, const NetworkExceptions.noInternetConnection());
  });

  test('Network exceptions receive timeout error test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            error: AppStrings.sendTimeout, type: DioErrorType.receiveTimeout));
    expect(networkException, const NetworkExceptions.sendTimeout());
  });

  test('Network exceptions send timeout error test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            error: AppStrings.sendTimeout, type: DioErrorType.sendTimeout));
    expect(networkException, const NetworkExceptions.sendTimeout());
  });

  test('Network exceptions with status code 404  not found test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            statusCode: 404,
            error: AppStrings.notFound,
            type: DioErrorType.response));
    expect(networkException,
        const NetworkExceptions.notFound(AppStrings.notFound));
  });

  test('Network exceptions with status code 400 test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            statusCode: 400,
            error: AppStrings.unauthorisedRequest,
            type: DioErrorType.response));
    expect(
        networkException,
        const NetworkExceptions.unauthorisedRequest(
            AppStrings.unauthorisedRequest));
  });

  test('Network exceptions with status code 409 test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            statusCode: 409,
            error: AppStrings.conflict,
            type: DioErrorType.response));
    expect(networkException, const NetworkExceptions.conflict());
  });

  test('Network exceptions with status code 408 test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            statusCode: 408,
            error: AppStrings.connectionTimeout,
            type: DioErrorType.response));
    expect(networkException, const NetworkExceptions.requestTimeout());
  });

  test('Network exceptions with status code 422 test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            statusCode: 422,
            error: AppStrings.badRequest,
            type: DioErrorType.response));
    expect(networkException,
        const NetworkExceptions.badRequest(AppStrings.badRequest));
  });

  test('Network exceptions with status code 500 test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            statusCode: 500,
            error: AppStrings.internalServerError,
            type: DioErrorType.response));
    expect(
        networkException,
        const NetworkExceptions.internalServerError(
            AppStrings.internalServerError));
  });

  test('Network exceptions with status code 503 test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            statusCode: 503,
            error: AppStrings.serviceUnavailable,
            type: DioErrorType.response));
    expect(networkException, const NetworkExceptions.serviceUnavailable());
  });

  test('Network exceptions with invalid status code test', () {
    NetworkExceptions networkException = NetworkExceptions.getDioException(
        dioError(
            statusCode: 1000,
            error: AppStrings.invalidStatusCode,
            type: DioErrorType.response));
    expect(
        networkException,
        const NetworkExceptions.defaultError(
            "${AppStrings.invalidStatusCode}: 1000"));
  });
// Network exceptions getErrorMessage method tests

  test('Network exceptions getErrorMessage notImplemented test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.notImplemented());
    expect(errorMessage, AppStrings.notImplemented);
  });
  test('Network exceptions getErrorMessage requestCancelled test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.requestCancelled());
    expect(errorMessage, AppStrings.requestCancelled);
  });
  test('Network exceptions getErrorMessage internalServerError test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.internalServerError(
            AppStrings.internalServerError));
    expect(errorMessage, AppStrings.internalServerError);
  });
  test('Network exceptions getErrorMessage notFound test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.notFound(AppStrings.notFound));
    expect(errorMessage, AppStrings.notFound);
  });
  test('Network exceptions getErrorMessage serviceUnavailable test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.serviceUnavailable());
    expect(errorMessage, AppStrings.serviceUnavailable);
  });
  test('Network exceptions getErrorMessage methodNotAllowed test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.methodNotAllowed());
    expect(errorMessage, AppStrings.methodNotAllowed);
  });
  test('Network exceptions getErrorMessage badRequest test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.badRequest(AppStrings.badRequest));
    expect(errorMessage, AppStrings.badRequest);
  });
  test('Network exceptions getErrorMessage unauthorisedRequest test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.unauthorisedRequest(
            AppStrings.unauthorisedRequest));
    expect(errorMessage, AppStrings.unauthorisedRequest);
  });
  test('Network exceptions getErrorMessage unexpectedError test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.unexpectedError());
    expect(errorMessage, AppStrings.somethingBroken);
  });
  test('Network exceptions getErrorMessage requestTimeout test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.requestTimeout());
    expect(errorMessage, AppStrings.connectionTimeout);
  });
  test('Network exceptions getErrorMessage noInternetConnection test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.noInternetConnection());
    expect(errorMessage, AppStrings.noInternet);
  });
  test('Network exceptions getErrorMessage conflict test', () {
    String errorMessage =
        NetworkExceptions.getErrorMessage(const NetworkExceptions.conflict());
    expect(errorMessage, AppStrings.conflict);
  });
  test('Network exceptions getErrorMessage sendTimeout test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.sendTimeout());
    expect(errorMessage, AppStrings.sendTimeout);
  });
  test('Network exceptions getErrorMessage unableToProcess test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.unableToProcess());
    expect(errorMessage, AppStrings.unableToProcess);
  });
  test('Network exceptions getErrorMessage defaultError test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.defaultError(AppStrings.invalidStatusCode));
    expect(errorMessage, AppStrings.invalidStatusCode);
  });
  test('Network exceptions getErrorMessage formatException test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.formatException());
    expect(errorMessage, AppStrings.unexpectedError);
  });
  test('Network exceptions getErrorMessage notAcceptable test', () {
    String errorMessage = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.notAcceptable());
    expect(errorMessage, AppStrings.notAcceptable);
  });
}

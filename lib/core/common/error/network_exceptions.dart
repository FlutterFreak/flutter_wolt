import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constants/strings.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest(String? error) =
      UnauthorisedRequest;

  const factory NetworkExceptions.badRequest(String? error) = BadRequest;

  const factory NetworkExceptions.notFound(String? error) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError(String? error) =
      InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String? error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.connectTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.other:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.response:
              var response = error.response!.data["msg"].toString();
              switch (error.response!.statusCode) {
                case 400:
                case 401:
                case 403:
                  networkExceptions =
                      NetworkExceptions.unauthorisedRequest(response);
                  break;
                case 404:
                  networkExceptions = NetworkExceptions.notFound(response);
                  break;
                case 409:
                  networkExceptions = const NetworkExceptions.conflict();
                  break;
                case 408:
                  networkExceptions = const NetworkExceptions.requestTimeout();
                  break;
                case 422:
                  networkExceptions = NetworkExceptions.badRequest(response);
                  break;
                case 500:
                  networkExceptions =
                      NetworkExceptions.internalServerError(response);
                  break;
                case 503:
                  networkExceptions =
                      const NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  var responseCode = error.response!.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    "${AppStrings.invalidStatusCode}: $responseCode",
                  );
              }
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains(AppStrings.isNotASubtype)) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = AppStrings.emptyString;
    networkExceptions.when(notImplemented: () {
      errorMessage = AppStrings.notImplemented;
    }, requestCancelled: () {
      errorMessage = AppStrings.requestCancelled;
    }, internalServerError: (error) {
      errorMessage = error ?? AppStrings.internalServerError;
    }, notFound: (error) {
      errorMessage = error ?? AppStrings.notFound;
    }, serviceUnavailable: () {
      errorMessage = AppStrings.serviceUnavailable;
    }, methodNotAllowed: () {
      errorMessage = AppStrings.methodNotAllowed;
    }, badRequest: (error) {
      errorMessage = error ?? AppStrings.badRequest;
    }, unauthorisedRequest: (error) {
      errorMessage = error ?? AppStrings.unauthorisedRequest;
    }, unexpectedError: () {
      errorMessage = AppStrings.somethingBroken;
    }, requestTimeout: () {
      errorMessage = AppStrings.connectionTimeout;
    }, noInternetConnection: () {
      errorMessage = AppStrings.noInternet;
    }, conflict: () {
      errorMessage = AppStrings.conflict;
    }, sendTimeout: () {
      errorMessage = AppStrings.sendTimeout;
    }, unableToProcess: () {
      errorMessage = AppStrings.unableToProcess;
    }, defaultError: (error) {
      errorMessage = error ?? AppStrings.invalidStatusCode;
    }, formatException: () {
      errorMessage = AppStrings.unexpectedError;
    }, notAcceptable: () {
      errorMessage = AppStrings.notAcceptable;
    });
    return errorMessage;
  }
}

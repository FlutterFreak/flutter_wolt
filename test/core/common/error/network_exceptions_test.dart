import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/common/error/network_exceptions.dart';
import 'package:flutter_wolt_assignment/core/constants/strings.dart';

import '../../../mocks/mock_data.dart';

void main() {
  var error = dioError;
  test('Network exceptions getDioException method test', () {
    NetworkExceptions networkException =
        NetworkExceptions.getDioException(error);
    expect(networkException, const NetworkExceptions.requestTimeout());
  });
  test('Network exceptions unexpected error  test', () {
    NetworkExceptions networkException =
        NetworkExceptions.getDioException(unexpectedError);
    expect(networkException, const NetworkExceptions.unexpectedError());
  });

  test('Network exceptions getErrorMessage method test', () {
    NetworkExceptions networkException =
        NetworkExceptions.getDioException(error);
    String errorMessage = NetworkExceptions.getErrorMessage(networkException);
    expect(errorMessage, AppStrings.connectionTimeout);
  });
}

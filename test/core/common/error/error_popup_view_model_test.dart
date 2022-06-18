import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/common/error/error_popup_view_model.dart';
import 'package:flutter_wolt_assignment/core/constants/strings.dart';

void main() {
  test('ErrorPopupViewModel initialized constructor', () {
    var data = ErrorPopupViewModel.initialized();
    expect(data.title, AppStrings.emptyString);
    expect(data.description, AppStrings.emptyString);
    expect(data.okButtonLabel, AppStrings.okButtonLabel);
  });
  test('ErrorPopupViewModel no internet constructor', () {
    var data = ErrorPopupViewModel.noInternet();
    expect(data.title, AppStrings.noInternetHeader);
    expect(data.description, AppStrings.noInternet);
  });

  test('ErrorPopupViewModel instance equality', () {
    var data = ErrorPopupViewModel.initialized();
    expect(data.props.length, 3);
  });
}

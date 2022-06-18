import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wolt_assignment/core/common/loading_indicator_view_model.dart';

void main() {
  test('LoadingIndicatorViewModel initialized constructor', () {
    const data = LoadingIndicatorViewModel.initialized();
    expect(data.isLoading, true);
  });
  test('LoadingIndicatorViewModel loading constructor', () {
    const data = LoadingIndicatorViewModel.loading();
    expect(data.isLoading, true);
  });
  test('LoadingIndicatorViewModel loaded constructor', () {
    const data = LoadingIndicatorViewModel.loaded();
    expect(data.isLoading, false);
  });

  test('LoadingIndicatorViewModel instance equality', () {
    const data = LoadingIndicatorViewModel.initialized();
    expect(data.props.length, 1);
  });
}

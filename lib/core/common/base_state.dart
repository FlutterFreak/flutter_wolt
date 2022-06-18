import 'package:equatable/equatable.dart';

import 'error/error_popup_view_model.dart';
import 'loading_indicator_view_model.dart';

abstract class BaseState<STATE> with EquatableMixin {
  LoadingIndicatorViewModel get loader;
  ErrorPopupViewModel get error;

  const BaseState();

  STATE copyWith({
    LoadingIndicatorViewModel loader = const LoadingIndicatorViewModel.loaded(),
    ErrorPopupViewModel? error,
  });

  STATE loading() {
    return copyWith(
      loader: const LoadingIndicatorViewModel.loading(),
    );
  }

  STATE withError(ErrorPopupViewModel error) {
    return copyWith(
      error: error,
    );
  }
}

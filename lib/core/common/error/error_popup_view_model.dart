import 'package:equatable/equatable.dart';
import 'package:flutter_wolt_assignment/core/constants/strings.dart';

class ErrorPopupViewModel with EquatableMixin {
  final String title;
  final String description;
  final String okButtonLabel;

  const ErrorPopupViewModel({
    required this.title,
    required this.description,
    this.okButtonLabel = AppStrings.okButtonLabel,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        okButtonLabel,
      ];

  ErrorPopupViewModel.initialized()
      : this(
          title: AppStrings.emptyString,
          description: AppStrings.emptyString,
          okButtonLabel: AppStrings.okButtonLabel,
        );

  ErrorPopupViewModel.noInternet()
      : this(
          title: AppStrings.noInternetHeader,
          description: AppStrings.noInternet,
          okButtonLabel: AppStrings.okButtonLabel,
        );
}

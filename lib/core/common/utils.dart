import 'package:flutter/material.dart';
import 'package:flutter_wolt_assignment/core/common/error/custom_alert_dialog.dart';
import 'package:flutter_wolt_assignment/core/common/error/error_popup_view_model.dart';
import 'package:flutter_wolt_assignment/core/common/loader_animation.dart';

class Utils {
  static showErrorPopup(
      BuildContext context, ErrorPopupViewModel errorPopupViewModel) {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
              title: errorPopupViewModel.title,
              message: errorPopupViewModel.description,
              okBtnText: errorPopupViewModel.okButtonLabel,
              onOkPressed: () {
                Navigator.pop(context);
              });
        });
  }

  static showLoader() {
    return const Center(
      child: CustomLoader(),
    );
  }
}

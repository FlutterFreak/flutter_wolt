import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color? bgColor;
  final String? title;
  final String? message;
  final String? okBtnText;
  final Function? onOkPressed;
  final double? circularBorderRadius;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.grey,
    required this.okBtnText,
    required this.onOkPressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Center(
              child: Text(
                title!,
                style: const TextStyle(color: Colors.black),
              ),
            )
          : null,
      content: message != null
          ? Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
            )
          : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius!)),
      actions: <Widget>[
        TextButton(
          child: Text(
            okBtnText!,
            style: const TextStyle(color: Colors.blueGrey),
          ),
          onPressed: () {
            onOkPressed!();
          },
        )
      ],
    );
  }
}

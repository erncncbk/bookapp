import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String msg, VoidCallback? function) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            msg,
            style: TextStyle().extraSmallStyle,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: function,
              child: Text(
                "Ok",
                style: TextStyle().extraSmallStyle,
              ),
            )
          ],
        );
      });
}

void showAlertDialogNoButton(
  BuildContext context,
  String msg,
) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            msg,
            style: TextStyle().extraSmallStyle,
          ),
        );
      });
}

void showAlertDialogWOptions(
    BuildContext context, String title, String msg, VoidCallback? function) {
  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: AppColors.kSecondary),
            ),
          ),
          CupertinoDialogAction(
            textStyle: TextStyle(color: Colors.red),
            isDefaultAction: true,
            onPressed: function,
            child: Text(
              title,
              style: TextStyle(color: AppColors.kPrimary),
            ),
          ),
        ],
      );
    },
  );
}

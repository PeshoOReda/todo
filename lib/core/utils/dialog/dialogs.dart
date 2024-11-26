
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog {
  static void showLoading(context,
      {String? loadingMessage, bool isDismissible = false}) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) => AlertDialog(
          content: Row(
        children: [
          Text(loadingMessage ?? ''),
          const Spacer(),
          const CircularProgressIndicator(),
        ],
      )),
    );
  }

  static void hide(context) {
    Navigator.pop(context);
  }

  static void showMessage(context,
      {String? title,
      String? body,
      String? posActionTitle,
      String? negActionTitle,
      VoidCallback? posAction,
      VoidCallback? negAction}) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: body != null ? Text(body) : null,
          actions: [
            if (posActionTitle != null)
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    posAction?.call();
                  },
                  child: Text(posActionTitle)),
            if (negActionTitle != null)
              MaterialButton(
                  onPressed: () {
                    negAction?.call();
                    Navigator.pop(context);
                  },
                  child: Text(negActionTitle))
          ],
        );
      },
    );
  }
}

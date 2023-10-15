import 'package:flutter/material.dart';
import 'package:unlimit_demo/res/styles/styles.dart';
import 'package:unlimit_demo/ui/utils/extensions/context_extension.dart';
import 'package:unlimit_demo/ui/widget/app_text.dart';

extension BuildContextEntension<T> on BuildContext {
  Future<T?> showBottomSheet(
    Widget child, {
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    return showModalBottomSheet(
      context: this,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      builder: (context) => Wrap(children: [child]),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    SnackBarAction? action,
    Color? textColor,
  }) {
    return scaffoldMessenger.showSnackBar(
      SnackBar(
        content: AppText(
          message,
          textColor: textColor ?? Colors.white,
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 3,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        action: action,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

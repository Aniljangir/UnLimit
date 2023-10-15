import 'package:flutter/cupertino.dart';
import 'package:unlimit_demo/res/styles/font_sizes.dart';

class AppSafeArea extends StatelessWidget {
  final Widget child;
  final double? topPadding;
  final double? leftPadding;
  final double? rightPadding;
  final double? bottomPadding;

  const AppSafeArea(
      {super.key,
      required this.child,
      this.leftPadding,
      this.rightPadding,
      this.topPadding,
      this.bottomPadding});

  @override
  Widget build(BuildContext context) => SafeArea(
        minimum: EdgeInsets.only(
          top: topPadding ?? FontSizes.screenDefaultTopPadding,
          left: leftPadding ?? FontSizes.screenDefaultHorizontalPadding,
          right: rightPadding ?? FontSizes.screenDefaultHorizontalPadding,
          bottom: bottomPadding ?? FontSizes.screenDefaultTopPadding,
        ),
        child: child,
      );
}

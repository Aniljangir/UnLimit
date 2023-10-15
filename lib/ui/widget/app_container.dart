import 'package:flutter/material.dart';
import 'package:unlimit_demo/res/styles/font_sizes.dart';

class AppContainer extends StatelessWidget {
  final Widget child;

  const AppContainer({
    super.key,
    required this.child,
    this.paddingLeft,
    this.paddingRight,
    this.paddingTop,
    this.paddingBottom,
    this.backgroundColor = Colors.white,
    this.borderRadius,
  });

  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingTop;
  final double? paddingBottom;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        paddingLeft ?? FontSizes.containerLeftPadding,
        paddingTop ?? FontSizes.containerTopPadding,
        paddingRight ?? FontSizes.containerRightPadding,
        paddingBottom ?? FontSizes.containerBottomPadding,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

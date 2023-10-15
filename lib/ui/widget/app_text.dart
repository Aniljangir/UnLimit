import 'package:flutter/material.dart';
import 'package:unlimit_demo/res/styles/font_sizes.dart';
import 'package:unlimit_demo/res/styles/styles.dart';

class AppText extends StatelessWidget {
  const AppText(this.text,
      {Key? key,
      this.textColor,
      this.size,
      this.fontWeight,
      this.textAlign,
      this.maxLines,
      this.overflow,
      this.letterSpacing,
      this.textDecoration,
      this.isCopyEnabled = false,
      this.lineHeight,
      this.textStyle})
      : super(key: key);

  final String text;
  final Color? textColor;
  final double? size;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final TextDecoration? textDecoration;
  final bool isCopyEnabled;
  final double? lineHeight;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      key: key,
      text,
      style: textStyle ??
          getTextStyle(
            color: textColor,
            fontSize: size ?? FontSizes.normalTextSize,
            fontWeight: fontWeight,
            textDecoration: textDecoration,
            letterSpacing: letterSpacing,
            height: lineHeight,
          ),
      softWrap: true,
      overflow: overflow ?? TextOverflow.clip,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:unlimit_demo/res/styles/font_sizes.dart';
import 'package:unlimit_demo/ui/widget/app_container.dart';
import 'package:unlimit_demo/ui/widget/app_screen_widget.dart';
import 'package:unlimit_demo/ui/widget/app_text.dart';

class JokesItem extends AppScreenWidget {
  final String joke;
  final Color currentColor;
  final Color nextColor;

  const JokesItem({
    Key? key,
    required this.joke,
    required this.currentColor,
    required this.nextColor,
  }) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return AppContainer(
      backgroundColor: nextColor,
      child: AppContainer(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
        backgroundColor: currentColor,
        paddingBottom: 30,
        paddingLeft: 30,
        paddingTop: 50,
        paddingRight: 20,
        child: AppText(
          joke,
          size: FontSizes.headingTextSize,
          fontWeight: FontWeight.bold,
          textColor: Colors.white,
        ),
      ),
    );
  }
}

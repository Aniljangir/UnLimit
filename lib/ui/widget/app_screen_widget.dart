import 'package:flutter/material.dart';

abstract class AppScreenWidget extends StatelessWidget {
  const AppScreenWidget({required super.key}) : super();

  Widget buildView(BuildContext context);

  @override
  Widget build(BuildContext context) {
    var view = buildView(context);
    return view;
  }
}

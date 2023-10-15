import 'package:flutter/material.dart';
import 'package:unlimit_demo/res/styles/styles.dart';
import 'package:unlimit_demo/ui/widget/app_text.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String msg;
  final String? title;

  const ErrorMessageWidget({super.key, required this.msg, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            ...[
              AppText(
                title!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
            ].toList(),
          AppText(
            msg,
            textColor: AppColors.primaryTextColor,
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

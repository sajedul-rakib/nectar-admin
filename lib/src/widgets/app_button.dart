import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    required this.buttonTitle,
    this.buttonBackgroundColor = AppColors.successGreen,
  });

  final Function()? onPressed;
  final String buttonTitle;
  final Color? buttonBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            backgroundColor: WidgetStatePropertyAll(buttonBackgroundColor)),
        onPressed: onPressed,
        child: Text(
          buttonTitle,
          style: const TextStyle(fontSize: 16.0, color: AppColors.whiteColor),
        ));
  }
}

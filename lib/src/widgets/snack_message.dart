import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:flutter/material.dart';

class SnackMessage {
  static snackMessage(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        title,
        style: const TextStyle(color: AppColors.whiteColor),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: AppColors.successGreen,
    ));
  }
}

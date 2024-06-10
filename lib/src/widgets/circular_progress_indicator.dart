import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryBackgroundColor,
      ),
    );
  }
}

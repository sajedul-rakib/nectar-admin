import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/utils/responsive/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContentType {
  final String message;
  final Color? color;
  final IconData iconData;
  const ContentType(this.message, this.iconData, [this.color]);

  //success snackbar
  static const ContentType success = ContentType(
    'success',
    CupertinoIcons.checkmark_seal,
    AppColors.successGreen,
  );

  //failure snackbar
  static const ContentType failure = ContentType(
    'failure',
    CupertinoIcons.clear_circled,
    AppColors.failureRed,
  );

  //warning snackbar
  static const ContentType warning = ContentType(
    'warning',
    CupertinoIcons.exclamationmark_shield,
    AppColors.warningYellow,
  );

  //help snackbar
  static const ContentType help = ContentType(
    'help',
    CupertinoIcons.hand_thumbsup,
    AppColors.helpBlue,
  );
}

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar(
      {super.key,
      required this.contentType,
      this.color,
      required this.label,
      required this.message});

  final ContentType contentType;
  final Color? color;
  final String label;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color ?? contentType.color,
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(label,
            style: const TextStyle(
              fontSize: 20.0,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w700,
            )),
        subtitle: Text(message,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            )),
        trailing: Icon(
          contentType.iconData,
          size: 30,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}

void snackBar(
    {required String title,
    required String message,
    required ContentType contentType,
    required BuildContext context}) {
  final snackbar = SnackBar(
    duration: const Duration(seconds: 2),
    elevation: 0,
    width: !AppResponsive.isMobile(context) ? 500 : null,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: CustomSnackBar(
      label: title,
      message: message,
      contentType: contentType,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(
    snackbar,
  );
}

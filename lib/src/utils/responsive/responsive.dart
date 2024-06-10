import 'package:flutter/material.dart';

class AppResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const AppResponsive(
      {super.key, this.tablet, required this.desktop, required this.mobile});

  //detect [Mobile,Tablet,Desktoop] sizes

  //mobile
  static bool isMobile(context) => MediaQuery.of(context).size.width < 850;

  //table
  static bool isTablet(context) =>
      MediaQuery.of(context).size.width >= 850 &&
      MediaQuery.of(context).size.width < 1100;

  //desktop
  static bool isDesktop(context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width > 1100) {
      return desktop;
    } else if (size.width > 850 && size.width >= 1100 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

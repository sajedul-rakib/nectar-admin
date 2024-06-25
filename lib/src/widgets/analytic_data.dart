import 'package:flutter/cupertino.dart';

class AnalyticData {
  final String title;
  final String value;
  final IconData iconData;

  AnalyticData(
      {required this.iconData, required this.title, required this.value});

  static List<AnalyticData> data = [
    AnalyticData(
      iconData: CupertinoIcons.money_dollar_circle,
      title: "Total sells",
      value: "\$200",
    ),
    AnalyticData(
      iconData: CupertinoIcons.bag,
      title: "Total Products",
      value: "123",
    ),
    AnalyticData(
      iconData: CupertinoIcons.cart,
      title: "Order",
      value: "73",
    ),
    AnalyticData(
      iconData: CupertinoIcons.person_2_fill,
      title: "Customers",
      value: "732",
    ),
  ];
}

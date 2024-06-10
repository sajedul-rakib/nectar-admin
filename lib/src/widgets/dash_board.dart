import 'dart:developer';

import 'package:admin_panel/controller/controller.dart';
import 'package:admin_panel/src/utils/assets/assets_manager.dart';
import 'package:admin_panel/src/utils/responsive/responsive.dart';
import 'package:admin_panel/src/widgets/analytic_card.dart';
import 'package:admin_panel/src/widgets/analytic_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!AppResponsive.isDesktop(context))
                InkWell(
                  child: const Icon(
                    Icons.menu,
                  ),
                  onTap: () {
                    context.read<DrawerMenuController>().controlMenu();
                  },
                ),
              const Expanded(
                child: SearchBar(
                  hintText: "Search here",
                  elevation: WidgetStatePropertyAll(0.0),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notification_add)),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (!AppResponsive.isDesktop(context)) {
                        log("I am profile clicked");
                      }
                    },
                    child: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(AssetsManager.profileImage),
                      ),
                    ),
                  ),
                  if (AppResponsive.isDesktop(context))
                    const Text(
                      "Sajedul Islam Rakib",
                      style: TextStyle(fontSize: 16.0),
                    )
                ],
              )
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: AnalyticCardView(
                  analyticData: AnalyticData.data,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

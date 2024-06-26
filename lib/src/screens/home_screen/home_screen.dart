import 'package:admin_panel/controller/controller.dart';
import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/utils/responsive/responsive.dart';
import 'package:admin_panel/src/widgets/dash_board.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          width: 200,
          color: AppColors.whiteColor,
        ),
      ),
      key: context.read<DrawerMenuController>().scaffoldKey,
      drawer: kIsWeb ? const CustomMenuBar() : null,
      body: SafeArea(
        child: Row(
          children: [
            if (AppResponsive.isDesktop(context))
              const Expanded(
                flex: 2,
                child: CustomMenuBar(),
              ),
            Expanded(
              flex: 8,
              child: SizedBox(
                width: width,
                height: height,
                child: const SingleChildScrollView(child: DashBoard()),
              ),
            )
          ],
        ),
      ),
    );
  }
}

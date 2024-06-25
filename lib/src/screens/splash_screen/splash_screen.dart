import 'dart:developer';

import 'package:admin_panel/src/bloc/blocs.dart';
import 'package:admin_panel/src/routes/route.dart';
import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/utils/assets/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.successGreen,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          log(state.status.toString());
          if (state.status == Authenticate.unauthenticate) {
            Future.delayed(const Duration(seconds: 2), () {
              context.goNamed(RouteName.LOGINSCREEN);
            });
          } else {
            context.goNamed(RouteName.HOMESCREEN);
          }
        },
        child: Center(
          child: Image.asset(
            AssetsManager.logoImage,
            color: AppColors.whiteColor,
            width: 300,
          ),
        ),
      ),
    );
  }
}

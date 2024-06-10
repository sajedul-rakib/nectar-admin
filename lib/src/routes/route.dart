import 'package:admin_panel/src/screens/add_new_product_screen/add_new_product_screen.dart';
import 'package:admin_panel/src/screens/all_product_view/all_product_view_screen.dart';
import 'package:admin_panel/src/screens/home_screen/home_screen.dart';
import 'package:admin_panel/src/screens/log_in_screen/log_in_screen.dart';
import 'package:admin_panel/src/screens/order_management_screen/order_management_screen.dart';
import 'package:admin_panel/src/screens/product_details_screen/product_details_screen.dart';
import 'package:admin_panel/src/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_repo/product_repository.dart';

part 'route_name.dart';

class AppRoute {
  static final router = GoRouter(routes: [
    //splash screen
    GoRoute(
        path: RouteName.INITIAL,
        name: RouteName.INITIAL,
        pageBuilder: (context, build) =>
            const MaterialPage(child: SplashScreen())),

    //log in screen
    GoRoute(
        path: RouteName.LOGINSCREEN,
        name: RouteName.LOGINSCREEN,
        pageBuilder: (context, build) =>
            const MaterialPage(child: LogInScreen())),

    //home screen
    GoRoute(
        path: RouteName.HOMESCREEN,
        name: RouteName.HOMESCREEN,
        pageBuilder: (context, build) =>
            const MaterialPage(child: HomeScreen())),

    GoRoute(
        path: RouteName.ADDNEWPRODUCTSCREEN,
        name: RouteName.ADDNEWPRODUCTSCREEN,
        pageBuilder: (context, build) =>
            const MaterialPage(child: AddNewProductScreen())),

    GoRoute(
        path: RouteName.ALLPRODUCTSCREEN,
        name: RouteName.ALLPRODUCTSCREEN,
        pageBuilder: (context, build) =>
            const MaterialPage(child: AllProductViewScreen())),

    GoRoute(
        path: RouteName.PRODUCTDETAILSCREEN,
        name: RouteName.PRODUCTDETAILSCREEN,
        builder: (context, state) =>
            ProductDetailsScreen(product: state.extra as Product)),

    GoRoute(
        path: RouteName.ORDERMANAGEMENTSCREEN,
        name: RouteName.ORDERMANAGEMENTSCREEN,
        pageBuilder: (context, build) =>
            const MaterialPage(child: OrderManagementScreen())),
  ]);
}

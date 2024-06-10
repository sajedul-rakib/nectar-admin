import 'package:admin_panel/src/routes/route.dart';
import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/utils/assets/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomMenuBar extends StatelessWidget {
  const CustomMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.zero,
      ),
      elevation: 0.0,
      backgroundColor: AppColors.primaryBackgroundColor,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            AssetsManager.logoImage,
            width: 150,
            color: AppColors.whiteColor,
          ),
          const SizedBox(
            height: 30,
          ),
          DrawerListTile(
            iconData: Icons.dashboard,
            title: "Dashboard",
            onTap: () {},
          ),
          DrawerListTile(
            iconData: Icons.list_alt,
            title: "Orders",
            onTap: () {
              context.go(RouteName.ORDERMANAGEMENTSCREEN);
            },
          ),
          DrawerListTile(
            iconData: Icons.card_giftcard_outlined,
            title: "Add New Products",
            onTap: () {
              context.go(RouteName.ADDNEWPRODUCTSCREEN);
            },
          ),
          DrawerListTile(
            iconData: Icons.list_alt,
            title: "All Products",
            onTap: () {
              context.go(RouteName.ALLPRODUCTSCREEN);
            },
          ),
          DrawerListTile(
            iconData: Icons.notifications_active,
            title: "Notifications",
            onTap: () {},
          ),
          DrawerListTile(
            iconData: Icons.person_2,
            title: "Profile",
            onTap: () {},
          ),
          DrawerListTile(
            iconData: Icons.question_mark_rounded,
            title: "Help",
            onTap: () {},
          )
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
  });

  final IconData iconData;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: AppColors.whiteColor,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16.0, color: AppColors.whiteColor),
      ),
      onTap: onTap,
    );
  }
}

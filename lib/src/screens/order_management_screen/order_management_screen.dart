import 'package:admin_panel/controller/controller.dart';
import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/utils/responsive/responsive.dart';
import 'package:admin_panel/src/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<DrawerMenuController>().scaffoldKey,
      drawer: const CustomMenuBar(),
      appBar: AppBar(
        title: const Text(
          "Order Management",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryBackgroundColor,
      ),
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: 500,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.blackColor.withOpacity(.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order Id: a;sdfjka;sdriqwer"),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Customer Id: a;dkfja;dsfj;kdf")
                      ],
                    ),
                    Row(
                      children: [
                        !AppResponsive.isMobile(context)
                            ? const Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: null,
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            AppColors.successGreen)),
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                          color: AppColors.whiteColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                    onPressed: null,
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            AppColors.failureRed)),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: AppColors.whiteColor),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
                        const ElevatedButton(
                          onPressed: null,
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.failureRed)),
                          child: Text(
                            "View order details",
                            style: TextStyle(color: AppColors.whiteColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      )),
    );
  }
}

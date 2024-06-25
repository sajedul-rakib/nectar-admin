import 'package:admin_panel/controller/controller.dart';
import 'package:admin_panel/src/bloc/order_management_bloc/order_management_bloc.dart';
import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/utils/responsive/responsive.dart';
import 'package:admin_panel/src/widgets/app_button.dart';
import 'package:admin_panel/src/widgets/circular_progress_indicator.dart';
import 'package:admin_panel/src/widgets/menu.dart';
import 'package:admin_panel/src/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repo/model/order_data_model.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  //order data
  List<OrderDataModel> orders = [];

  @override
  void initState() {
    context.read<OrderManagementBloc>().add(GetOrderData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      key: context.read<DrawerMenuController>().scaffoldKey,
      drawer: const CustomMenuBar(),
      appBar: !AppResponsive.isDesktop(context)
          ? AppBar(
              title: const Text(
                "Manage Orders",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              backgroundColor: AppColors.successGreen,
            )
          : null,
      body: SafeArea(
          child: Row(
        children: [
          if (AppResponsive.isDesktop(context))
            const Expanded(flex: 2, child: CustomMenuBar()),
          Expanded(
              flex: 8,
              child: BlocConsumer<OrderManagementBloc, OrderManagementState>(
                listener: (context, state) {
                  if (state is GetOrderDataSuccess) {
                    setState(() {
                      orders = state.orderData;
                    });
                  } else if (state is GetOrderDataFailed) {
                    snackBar(
                        title: "Data Load Failed",
                        message: state.errorMessage,
                        contentType: ContentType.failure,
                        context: context);
                  }
                },
                builder: (context, state) {
                  if (state is GetOrderDataLoading) {
                    return const CustomProgressIndicator();
                  } else {
                    Size size = MediaQuery.of(context).size;
                    return Center(
                      child: SizedBox(
                        width: 700,
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 10.0),
                              decoration: BoxDecoration(
                                color: AppColors.shadowColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Order Id: ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "#${orders[index].orderId}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Customer Name: ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "${orders[index].customer!.fullName}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Order items: "),
                                  SizedBox(
                                    height: 130,
                                    child: ListView.builder(
                                        itemCount: orders[index].items!.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, listIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  "${orders[index].items![listIndex].productShowImage}",
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                      "${orders[index].items![listIndex].productName}",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    width: size.width,
                                    height: 40,
                                    child: AppButton(
                                      buttonTitle: "Order Details",
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ))
        ],
      )),
    );
  }
}

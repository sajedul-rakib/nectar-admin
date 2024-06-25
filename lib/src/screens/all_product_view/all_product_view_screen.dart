import 'package:admin_panel/controller/controller.dart';
import 'package:admin_panel/src/bloc/blocs.dart';
import 'package:admin_panel/src/routes/route.dart';
import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/utils/responsive/responsive.dart';
import 'package:admin_panel/src/widgets/circular_progress_indicator.dart';
import 'package:admin_panel/src/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_repo/product_repository.dart';

class AllProductViewScreen extends StatefulWidget {
  const AllProductViewScreen({super.key});

  @override
  State<AllProductViewScreen> createState() => _AllProductViewScreenState();
}

class _AllProductViewScreenState extends State<AllProductViewScreen> {
  final TextStyle _textStyle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );

  List<Product> allProduct = [];

  @override
  void initState() {
    context.read<ProductUploadBloc>().add(GetAllProductRequired());
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
              backgroundColor: AppColors.successGreen,
              title: const Text(
                "All Product",
                style: TextStyle(color: AppColors.whiteColor),
              ),
              elevation: 0.0,
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (AppResponsive.isDesktop(context))
              const Expanded(flex: 2, child: CustomMenuBar()),
            Expanded(
                flex: 8,
                child: Center(
                  child: SizedBox(
                    width: 600,
                    child: BlocConsumer<ProductUploadBloc, ProductUploadState>(
                      listener: (context, state) {
                        if (state is GetAllProductSuccess) {
                          allProduct = state.allProduct;
                          setState(() {});
                        }
                      },
                      builder: (context, state) {
                        if (state is GetAllProductProcess) {
                          return const CustomProgressIndicator();
                        }
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.shadowColor,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 600,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Product Name",
                                    style: _textStyle,
                                  ),
                                  Text(
                                    "Stock",
                                    style: _textStyle,
                                  ),
                                  Text(
                                    "Product Price",
                                    style: _textStyle,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: allProduct.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => context.push(
                                            RouteName.PRODUCTDETAILSCREEN,
                                            extra: allProduct[index]),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          margin: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              color: AppColors.shadowColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width: 600,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.network(
                                                    "${allProduct[index].productShowImage}",
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      "${allProduct[index].productName}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                  "${allProduct[index].productStock} ${allProduct[index].productUnit}"),
                                              Text(
                                                  "\$${allProduct[index].productPrice}"),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

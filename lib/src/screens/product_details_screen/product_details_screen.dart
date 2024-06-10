import 'dart:convert';
import 'dart:developer';

import 'package:admin_panel/src/bloc/product_upload_bloc/product_upload_bloc.dart';
import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/widgets/app_button.dart';
import 'package:admin_panel/src/widgets/app_form_field.dart';
import 'package:admin_panel/src/widgets/circular_progress_indicator.dart';
import 'package:admin_panel/src/widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_repo/model/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<String> images = [];
  //product category
  final List<Map<String, String>> _productCategory = [
    {"category": "Fresh Fruits & Vegetable", "value": "FreshFruits&Vegetable"},
    {"category": "Cooking Oil & Ghee", "value": "CookingOil&Ghee"},
    {"category": "Meat & Fish", "value": "Meat&Fish"},
    {"category": "Bakery & Snacks", "value": "Bakery&Snacks"},
    {"category": "Dairy & Eggs", "value": "Dairy&Eggs"},
    {"category": "Beverages", "value": "Beverages"}
  ];

  //product unit
  final List<Map<String, String>> _productUnit = [
    {"unit": "Kg", "value": "Kg"},
    {"unit": "Litre", "value": "Litre"},
    {"unit": "Piece", "value": "Piece"},
    {"unit": "Pair", "value": "Pair"},
  ];

  String selectedCategory = "";

  String selectedUnit = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameTEController =
      TextEditingController();

  final TextEditingController _productDescriptionTEController =
      TextEditingController();

  final TextEditingController _productPriceTEController =
      TextEditingController();

  final TextEditingController _productDiscountPercentageTEController =
      TextEditingController();

  final TextEditingController _productStockTEController =
      TextEditingController();

  final TextEditingController _productNutritionTEController =
      TextEditingController();

  //product variable
  late Product _product;

  @override
  void initState() {
    _product = widget.product;
    _productNameTEController.text = _product.productName ?? "";
    _productDescriptionTEController.text = _product.productDescription ?? "";
    _productPriceTEController.text = _product.productPrice.toString();
    _productDiscountPercentageTEController.text = _product.discount.toString();
    _productStockTEController.text = _product.productStock.toString();
    selectedUnit = _product.productUnit ?? "";
    _productNutritionTEController.text = _product.nutrition ?? "";
    selectedCategory = _product.productCategory ?? "";
    images = _product.productImages ?? [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryBackgroundColor,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Padding(
                padding: kIsWeb
                    ? EdgeInsets.zero
                    : const EdgeInsets.symmetric(horizontal: 8.0),
                child: BlocConsumer<ProductUploadBloc, ProductUploadState>(
                  listener: (context, state) {
                    if (state is UpdateProductDataSuccess) {
                      snackBar(
                          title: "Updated Successfully",
                          message: "Product update successfully",
                          contentType: ContentType.success,
                          context: context);
                      _product = state.product;
                      setState(() {});
                    } else if (state is UpdateProductDataFailure) {
                      snackBar(
                          title: "Failed",
                          message: state.errorMessage,
                          contentType: ContentType.failure,
                          context: context);
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdateProductDataProcess) {
                      return const CustomProgressIndicator();
                    }
                    return Column(
                      children: [
                        Form(
                            key: _formKey,
                            child: SizedBox(
                              width: 400,
                              child: Column(
                                children: [
                                  AppFormField(
                                    hintText: "Enter your product name",
                                    labelText: "Product name",
                                    textEditingController:
                                        _productNameTEController,
                                    validator: (value) {
                                      if (value!.isNotEmpty) {
                                        return null;
                                      } else {
                                        "Enter product name";
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  AppFormField(
                                    labelText: "Product Description",
                                    hintText: "Product description",
                                    maxLine: 4,
                                    textEditingController:
                                        _productDescriptionTEController,
                                    validator: (value) {
                                      if (value!.isNotEmpty) {
                                        return null;
                                      } else {
                                        "Enter product description";
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: AppFormField(
                                            labelText: "Product Price",
                                            suffixIcon: const Icon(
                                                CupertinoIcons.money_dollar),
                                            hintText: "Product price",
                                            textEditingController:
                                                _productPriceTEController,
                                            validator: (value) {
                                              if (value!.isNotEmpty) {
                                                return null;
                                              } else {
                                                "Enter product price";
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: AppFormField(
                                            labelText: "Discount",
                                            suffixIcon: const Icon(
                                                CupertinoIcons.percent),
                                            hintText: "Discount",
                                            textEditingController:
                                                _productDiscountPercentageTEController,
                                            validator: (value) {
                                              if (value!.isNotEmpty) {
                                                return null;
                                              } else {
                                                "Enter discount percentage";
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: AppFormField(
                                            labelText: "Stock",
                                            hintText: "Product stock",
                                            textEditingController:
                                                _productStockTEController,
                                            validator: (value) {
                                              if (value!.isNotEmpty) {
                                                return null;
                                              } else {
                                                "Enter product stock";
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: AppColors.whiteColor,
                                                contentPadding:
                                                    const EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                focusColor: Colors.transparent,
                                                isDense: true,
                                                isExpanded: true,
                                                value: selectedUnit,
                                                menuMaxHeight: 300,
                                                items: [
                                                  const DropdownMenuItem(
                                                    value: '',
                                                    child: Text("Select Unit"),
                                                  ),
                                                  ..._productUnit.map<
                                                      DropdownMenuItem<
                                                          String>>((data) {
                                                    return DropdownMenuItem(
                                                        value: data["value"],
                                                        child: Text(
                                                            data["unit"]!));
                                                  })
                                                ],
                                                onChanged: (String? value) {
                                                  if (selectedUnit != value) {
                                                    selectedUnit = value!;
                                                    setState(() {});
                                                  } else {
                                                    log("It was selected");
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 400,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: AppFormField(
                                            labelText: "Nutrition",
                                            hintText: "Nutrition",
                                            textEditingController:
                                                _productNutritionTEController,
                                            validator: (value) {
                                              if (value!.isNotEmpty) {
                                                return null;
                                              } else {
                                                "Enter product nutrition";
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: AppColors.whiteColor,
                                                contentPadding:
                                                    const EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                focusColor: Colors.transparent,
                                                isDense: true,
                                                isExpanded: true,
                                                value: selectedCategory,
                                                menuMaxHeight: 300,
                                                items: [
                                                  const DropdownMenuItem(
                                                    value: '',
                                                    child:
                                                        Text("Select Category"),
                                                  ),
                                                  ..._productCategory.map<
                                                      DropdownMenuItem<
                                                          String>>((data) {
                                                    return DropdownMenuItem(
                                                        value: data["value"],
                                                        child: Text(
                                                            data["category"]!));
                                                  })
                                                ],
                                                onChanged: (String? value) {
                                                  if (selectedCategory !=
                                                      value) {
                                                    selectedCategory = value!;
                                                    setState(() {});
                                                  } else {
                                                    log("It was selected");
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 400,
                                    height: 300,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: images.length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      mainAxisSpacing: 5,
                                                      crossAxisSpacing: 5),
                                              itemBuilder: (_, index) {
                                                return InkWell(
                                                  onTap: () =>
                                                      _showProductImageInBigScreen(
                                                          context, index),
                                                  child: Image.network(
                                                      images[index].toString()),
                                                );
                                              }),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          width: 400,
                          height: 40,
                          child: AppButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? true) {
                                  Product product = Product(
                                      id: _product.id ?? '',
                                      productName:
                                          _productNameTEController.text.trim(),
                                      productDescription:
                                          _productDescriptionTEController.text
                                              .trim(),
                                      productPrice: double.parse(
                                          _productPriceTEController.text
                                              .trim()),
                                      discount: int.parse(
                                          _productDiscountPercentageTEController
                                              .text
                                              .trim()),
                                      productStock: int.parse(
                                          _productStockTEController.text
                                              .trim()),
                                      productUnit: selectedUnit,
                                      productCategory: selectedCategory,
                                      nutrition: _productNutritionTEController
                                          .text
                                          .trim(),
                                      productImages: images,
                                      productShowImage: images.first,
                                      tag: "",
                                      rating: 0,
                                      brandName: '');

                                  log(jsonEncode(product.toJson()));

                                  context.read<ProductUploadBloc>().add(
                                      UpdateProductRequired(
                                          productId: _product.id ?? '',
                                          updatedProductData: product));
                                }
                              },
                              buttonTitle: "Update"),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//show product image in big screen for select or delete if the admin choose the wrong product image
  Future<dynamic> _showProductImageInBigScreen(
      BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: SizedBox(
              width: 300,
              height: 500,
              child: Column(
                children: [
                  Image.network(images[index]),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                      focusColor: AppColors.whiteColor,
                      hoverColor: AppColors.whiteColor,
                      onPressed: () => GoRouter.of(context).pop(),
                      icon: const Icon(
                        CupertinoIcons.multiply_circle,
                        size: 40,
                        color: AppColors.failureRed,
                      ))
                ],
              ),
            ),
          );
        });
  }
}

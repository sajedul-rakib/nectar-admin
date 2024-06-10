import 'dart:developer';
import 'dart:io';

import 'package:admin_panel/controller/controller.dart';
import 'package:admin_panel/src/bloc/blocs.dart';
import 'package:admin_panel/src/utils/app_colors/colors.dart';
import 'package:admin_panel/src/widgets/app_button.dart';
import 'package:admin_panel/src/widgets/app_form_field.dart';
import 'package:admin_panel/src/widgets/circular_progress_indicator.dart';
import 'package:admin_panel/src/widgets/menu.dart';
import 'package:admin_panel/src/widgets/snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_repo/product_repository.dart';
import 'package:uuid/uuid.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  late List<PlatformFile> images;

  @override
  void initState() {
    images = [];
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<DrawerMenuController>().scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundColor,
        title: const Text("Add new product"),
      ),
      drawer: const CustomMenuBar(),
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
                    if (state is ProductUploadSuccess) {
                      snackBar(
                          title: "Upload success",
                          message: "Product upload successfully",
                          contentType: ContentType.success,
                          context: context);

                      _productNameTEController.clear();
                      _productDescriptionTEController.clear();
                      _productPriceTEController.clear();
                      _productDiscountPercentageTEController.clear();
                      _productStockTEController.clear();
                      selectedUnit = '';
                      _productNutritionTEController.clear();
                      selectedCategory = '';
                      images.clear();
                      setState(() {});
                    } else if (state is ProductUploadFailure) {
                      snackBar(
                          title: "Upload Failed",
                          message: state.errorMessage,
                          contentType: ContentType.failure,
                          context: context);
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductUploadProccess) {
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
                                  const SizedBox(
                                    height: 10,
                                  ),
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
                                    child: InkWell(
                                        onTap: () {
                                          _pickProductImages();
                                        },
                                        child: images.isEmpty
                                            ? const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .photo_size_select_actual_rounded,
                                                    size: 100,
                                                    color: Colors.black12,
                                                  ),
                                                  Text("Add image here..."),
                                                ],
                                              )
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    GridView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            images.length,
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    3,
                                                                mainAxisSpacing:
                                                                    5,
                                                                crossAxisSpacing:
                                                                    5),
                                                        itemBuilder:
                                                            (_, index) {
                                                          return kIsWeb
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    _showProductImageInBigScreen(
                                                                        context,
                                                                        index);
                                                                  },
                                                                  child: Image.memory(
                                                                      Uint8List.fromList(
                                                                          images[index]
                                                                              .bytes!)),
                                                                )
                                                              : InkWell(
                                                                  onTap: () {
                                                                    _showProductImageInBigScreen(
                                                                        context,
                                                                        index);
                                                                  },
                                                                  child: Image.file(
                                                                      File(images[
                                                                              index]
                                                                          .path!)));
                                                        }),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          FilePickerResult?
                                                              pickImage =
                                                              await FilePicker.platform.pickFiles(
                                                                  allowMultiple:
                                                                      true,
                                                                  allowedExtensions: [
                                                                    "jpg",
                                                                    "jpeg",
                                                                    "png",
                                                                    "webp"
                                                                  ],
                                                                  type: FileType
                                                                      .custom);
                                                          if (pickImage !=
                                                              null) {
                                                            images.add(pickImage
                                                                .files.first);
                                                            setState(() {});
                                                          }
                                                        },
                                                        child: const Icon(
                                                            CupertinoIcons.add))
                                                  ],
                                                ),
                                              )),
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
                                // //product id
                                String productId = const Uuid().v1();
                                //product price after given discount
                                double productPrice = double.parse(
                                    _productPriceTEController.text.trim());
                                double discount = double.parse(
                                    _productDiscountPercentageTEController.text
                                        .trim());

                                double actualProductPrice = productPrice -
                                    ((discount / 100) * productPrice);

                                Product product = Product(
                                    id: productId,
                                    productName:
                                        _productNameTEController.text.trim(),
                                    productDescription:
                                        _productDescriptionTEController.text
                                            .trim(),
                                    productPrice: actualProductPrice,
                                    discount: discount,
                                    productStock: int.parse(
                                        _productStockTEController.text.trim()),
                                    productUnit: selectedUnit,
                                    productCategory: selectedCategory,
                                    nutrition: _productNutritionTEController
                                        .text
                                        .trim(),
                                    productImages: const [],
                                    productShowImage: "",
                                    tag: "",
                                    rating: 0,
                                    brandName: '');

                                context.read<ProductUploadBloc>().add(
                                    ProductUploadRequired(
                                        product: product, images: images));
                              }
                            },
                            buttonTitle: 'Upload',
                          ),
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
                  kIsWeb
                      ? Image.memory(Uint8List.fromList(images[index].bytes!))
                      : Image.file(File(images[index].path!)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        buttonTitle: "Cancel",
                        onPressed: () => GoRouter.of(context).pop(),
                        buttonBackgroundColor: AppColors.failureRed,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      AppButton(
                        buttonTitle: "Delete",
                        onPressed: () {
                          images.removeAt(index);
                          GoRouter.of(context).pop();
                          setState(() {});
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

//upload image from gallary
  Future<void> _pickProductImages() async {
    try {
      FilePickerResult? imagePicker = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ["jpg", "jpeg", "png", "webp"],
          allowMultiple: true);
      if (imagePicker != null) {
        images = imagePicker.files;
        setState(() {});
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

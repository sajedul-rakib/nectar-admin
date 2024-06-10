import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:product_repo/product_repository.dart';

part 'product_upload_event.dart';
part 'product_upload_state.dart';

class ProductUploadBloc extends Bloc<ProductUploadEvent, ProductUploadState> {
  final ProductRepo productRepo;
  ProductUploadBloc({required this.productRepo})
      : super(ProductUploadInitial()) {
    //upload a new product
    on<ProductUploadRequired>((event, emit) async {
      try {
        emit(ProductUploadProccess());
        await productRepo.addNewProduct(
            product: event.product, images: event.images);
        emit(ProductUploadSuccess());
      } catch (e) {
        emit(ProductUploadFailure(errorMessage: e.toString()));
        log(e.toString());
        rethrow;
      }
    });

    //get all product
    on<GetAllProductRequired>((event, emit) async {
      try {
        emit(GetAllProductProcess());
        List<Product> allProduct = await productRepo.getAllProduct();
        emit(GetAllProductSuccess(allProduct: allProduct));
      } catch (e) {
        emit(GetAllProductFailure(errorMessage: e.toString()));
        log(e.toString());
        rethrow;
      }
    });

    //update product data
    on<UpdateProductRequired>((event, emit) async {
      try {
        emit(UpdateProductDataProcess());
        Product product = await productRepo.updateProductData(
            productId: event.productId,
            updatedProductData: event.updatedProductData);
        emit(UpdateProductDataSuccess(product: product));
      } catch (e) {
        emit(UpdateProductDataFailure(errorMessage: e.toString()));
        log(e.toString());
        rethrow;
      }
    });
  }
}

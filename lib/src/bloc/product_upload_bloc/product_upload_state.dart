part of 'product_upload_bloc.dart';

abstract class ProductUploadState extends Equatable {
  const ProductUploadState();

  @override
  List<Object> get props => [];
}

//upload product state
final class ProductUploadInitial extends ProductUploadState {}

final class ProductUploadProccess extends ProductUploadState {}

final class ProductUploadSuccess extends ProductUploadState {}

final class ProductUploadFailure extends ProductUploadState {
  final String errorMessage;
  const ProductUploadFailure({required this.errorMessage});
}

//get all prduct state
final class GetAllProductProcess extends ProductUploadState {}

final class GetAllProductSuccess extends ProductUploadState {
  final List<Product> allProduct;
  const GetAllProductSuccess({required this.allProduct});
}

final class GetAllProductFailure extends ProductUploadState {
  final String errorMessage;
  const GetAllProductFailure({required this.errorMessage});
}

//update product data

final class UpdateProductDataProcess extends ProductUploadState {}

final class UpdateProductDataSuccess extends ProductUploadState {
  final Product product;
  const UpdateProductDataSuccess({required this.product});
}

final class UpdateProductDataFailure extends ProductUploadState {
  final String errorMessage;
  const UpdateProductDataFailure({required this.errorMessage});
}

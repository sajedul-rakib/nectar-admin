part of 'product_upload_bloc.dart';

abstract class ProductUploadEvent extends Equatable {
  const ProductUploadEvent();

  @override
  List<Object> get props => [];
}

//upload product event
class ProductUploadRequired extends ProductUploadEvent {
  final Product product;
  final List<PlatformFile> images;
  const ProductUploadRequired({required this.product, required this.images});
}

//get all product event
class GetAllProductRequired extends ProductUploadEvent {}

//update product event
class UpdateProductRequired extends ProductUploadEvent {
  final String productId;
  final Product updatedProductData;

  const UpdateProductRequired(
      {required this.productId, required this.updatedProductData});
}

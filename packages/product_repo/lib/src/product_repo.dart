import 'package:file_picker/file_picker.dart';
import 'package:product_repo/model/order_data_model.dart';
import 'package:product_repo/model/product.dart';
import 'package:product_repo/product_repository.dart';

abstract class ProductRepo {
  //upload product images
  Future<List<String>> uploadProductImage(List<PlatformFile> images);

  //add new product
  Future<bool> addNewProduct(
      {required Product product, required List<PlatformFile> images});

  //get all uploaded product
  Future<List<Product>> getAllProduct();

  //update product data
  Future<Product> updateProductData(
      {required String productId, required Product updatedProductData});

  //get order data
  Future<List<OrderDataModel>> getOrderData();
}

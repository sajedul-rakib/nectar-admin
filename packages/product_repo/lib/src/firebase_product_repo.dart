import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:product_repo/model/product.dart';
import 'package:product_repo/src/product_repo.dart';

class FirebaseProductRepo implements ProductRepo {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //upload product images
  @override
  Future<List<String>> uploadProductImage(List<PlatformFile> images) async {
    List<String> uploadedImagesUrl = [];
    UploadTask uploadTask;
    Reference rootDirectory = _firebaseStorage.ref();

    if (kIsWeb) {
      for (PlatformFile img in images) {
        Reference childDirectory =
            rootDirectory.child("products/${img.xFile.name}");
        final metaData = SettableMetadata(
            contentType: "image/jpeg",
            customMetadata: {'picked-file-path': img.xFile.path});
        uploadTask =
            childDirectory.putData(await img.xFile.readAsBytes(), metaData);
        final task = await uploadTask.whenComplete(() => null);

        String downloadUrl = await task.ref.getDownloadURL();

        uploadedImagesUrl.add(downloadUrl);
      }
      return uploadedImagesUrl;
    } else {
      try {
        for (PlatformFile img in images) {
          Reference childDirectory =
              rootDirectory.child("products/${img.xFile.name}");
          uploadTask = childDirectory.putFile(File(img.xFile.path));
          final task = await uploadTask.whenComplete(() => null);

          String downloadUrl = await task.ref.getDownloadURL();
          uploadedImagesUrl.add(downloadUrl);
        }
        return uploadedImagesUrl;
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    }
  }

  //add new product
  @override
  Future<bool> addNewProduct(
      {required Product product, required List<PlatformFile> images}) async {
    List<String> productImages = await uploadProductImage(images);
    try {
      if (productImages.isNotEmpty) {
        //product
        Map<String, dynamic> data = {
          ...product.toJson(),
          "productImages": productImages,
          "productShowImage": productImages.first
        };
        _firebaseFirestore.collection("products").add(data);
        return true;
      } else {
        log(productImages.toString());
        return false;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //get all uploaded prodcut
  @override
  Future<List<Product>> getAllProduct() async {
    List<Product> allProduct = [];
    try {
      final directory = await _firebaseFirestore
          .collection("products")
          .orderBy("productStock", descending: false)
          .get();

      for (var product in directory.docs) {
        allProduct.add(Product.fromJson(product.data()));
      }
      return allProduct;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Product> updateProductData(
      {required String productId, required Product updatedProductData}) async {
    try {
      final findThisProduct = await _firebaseFirestore
          .collection("products")
          .where("id", isEqualTo: productId)
          .get();
      String productDocument = findThisProduct.docs.first.id;
      _firebaseFirestore
          .collection("products")
          .doc(productDocument)
          .update(updatedProductData.toJson());
      final updatedProduct = await _firebaseFirestore
          .collection("products")
          .doc(productDocument)
          .get();
      return Product.fromJson(updatedProduct.data()!);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

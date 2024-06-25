class Product {
  String? id;
  String? productName;
  String? productDescription;
  num? productPrice;
  num? discount;
  num? productStock;
  String? productUnit;
  String? nutrition;
  String? productCategory;
  List<String>? productImages;
  String? productShowImage;
  String? tag;
  String? brandName;
  num? rating;

  Product(
      {this.id,
      this.productName,
      this.productDescription,
      this.productPrice,
      this.discount,
      this.productStock,
      this.productUnit,
      this.nutrition,
      this.productCategory,
      this.productImages,
      this.productShowImage,
      this.tag,
      this.brandName,
      this.rating});

  //from json to document
  Product.fromJson(Map<String, dynamic> data) {
    id = data["id"] as String;
    productName = data["productName"] as String;
    productDescription = data["productDescription"] as String;
    productPrice = data["productPrice"] as num;
    discount = data["discount"] as num;
    productStock = data["productStock"] as num;
    productUnit = data["productUnit"] as String;
    nutrition = data["nutrition"] as String;
    productCategory = data["productCategory"] as String;
    productShowImage = data["productShowImage"] as String;
    productImages = data["productImages"].cast<String>();
    tag = data["tag"] as String;
    brandName = data["brandName"] as String;
    rating = data["rating"] as num;
  }

  // dart to json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "productName": productName,
      "productDescription": productDescription,
      "productPrice": productPrice,
      "discount": discount,
      "productStock": productStock,
      "productUnit": productUnit,
      "nutrition": nutrition,
      "productCategory": productCategory,
      "productShowImage": productShowImage,
      "productImages": productImages,
      "tag": tag,
      "brandName": brandName,
      "rating": rating
    };
  }
}

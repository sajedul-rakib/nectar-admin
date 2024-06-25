class OrderDataModel {
  String? id;
  String? orderId;
  UserModel? customer;
  List<CartDataModel>? items;
  String? deliveryAddress;
  num? totalPrice;
  String? paymentMethod;
  bool? paymentDone;
  String? orderStatus;
  String? orderTime;

  OrderDataModel(
      {this.id,
      this.orderId,
      this.customer,
      this.items,
      this.deliveryAddress,
      this.totalPrice,
      this.paymentMethod,
      this.paymentDone,
      this.orderStatus,
      this.orderTime});

  OrderDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    customer = json['customer'] != null
        ? new UserModel.fromJson(json['customer'])
        : null;
    if (json['items'] != null) {
      items = <CartDataModel>[];
      json['items'].forEach((v) {
        items!.add(CartDataModel.fromJson(v));
      });
    }
    deliveryAddress = json['deliveryAddress'];
    totalPrice = json['totalPrice'];
    paymentMethod = json['paymentMethod'];
    paymentDone = json['paymentDone'];
    orderStatus = json['orderStatus'];
    orderTime = json['orderTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderId'] = orderId;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['deliveryAddress'] = deliveryAddress;
    data['totalPrice'] = totalPrice;
    data['paymentMethod'] = paymentMethod;
    data['paymentDone'] = paymentDone;
    data['orderStatus'] = orderStatus;
    data['orderTime'] = orderTime;
    return data;
  }
}

class CartDataModel {
  String? productShowImage;
  String? brandName;
  num? rating;
  int? productStock;
  num? discount;
  String? productUnit;
  String? userId;
  String? productName;
  String? productCategory;
  List<String>? productImages;
  String? nutrition;
  String? tag;
  String? id;
  String? productDescription;
  num? productPrice;
  int? totalOrderProduct;

  CartDataModel(
      {this.productShowImage,
      this.brandName,
      this.rating,
      this.productStock,
      this.discount,
      this.productUnit,
      this.userId,
      this.productName,
      this.productCategory,
      this.productImages,
      this.nutrition,
      this.tag,
      this.id,
      this.productDescription,
      this.productPrice,
      this.totalOrderProduct});

  CartDataModel.fromJson(Map<String, dynamic> json) {
    productShowImage = json['productShowImage'];
    brandName = json['brandName'];
    rating = json['rating'];
    productStock = json['productStock'];
    discount = json['discount'];
    productUnit = json['productUnit'];
    userId = json['userId'];
    productName = json['productName'];
    productCategory = json['productCategory'];
    productImages = json['productImages'].cast<String>();
    nutrition = json['nutrition'];
    tag = json['tag'];
    id = json['id'];
    productDescription = json['productDescription'];
    productPrice = json['productPrice'];
    totalOrderProduct = json['totalOrderProduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productShowImage'] = productShowImage;
    data['brandName'] = brandName;
    data['rating'] = rating;
    data['productStock'] = productStock;
    data['discount'] = discount;
    data['productUnit'] = productUnit;
    data['userId'] = userId;
    data['productName'] = productName;
    data['productCategory'] = productCategory;
    data['productImages'] = productImages;
    data['nutrition'] = nutrition;
    data['tag'] = tag;
    data['id'] = id;
    data['productDescription'] = productDescription;
    data['productPrice'] = productPrice;
    data['totalOrderProduct'] = totalOrderProduct;
    return data;
  }
}

class UserModel {
  String? address;
  String? phoneNumber;
  String? profilePic;
  String? fullName;
  String? email;
  String? token;
  String? fcmToken;

  UserModel(
      {this.address,
      this.phoneNumber,
      this.profilePic,
      this.fullName,
      this.email,
      this.token,
      this.fcmToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    fcmToken = json['fcmToken'];
    email = json['email'];
    token = json['token'];
  }

  static UserModel emptyUser = UserModel(
      fullName: '',
      email: '',
      profilePic: '',
      phoneNumber: '',
      address: '',
      token: '',
      fcmToken: '');

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['phoneNumber'] = phoneNumber;
    data['profilePic'] = profilePic;
    data['fullName'] = fullName;
    data['fcmToken'] = fcmToken;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}

import 'dart:convert';

class TailorAddressRes {
  bool? success;
  String? message;
  Data? data;

  TailorAddressRes({
    this.success,
    this.message,
    this.data,
  });

  factory TailorAddressRes.fromJson(String str) => TailorAddressRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TailorAddressRes.fromMap(Map<String, dynamic> json) => TailorAddressRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  dynamic accountType;
  dynamic email;
  dynamic mobileNumber;
  dynamic shopName;
  dynamic shopPhoto;
  dynamic street;
  dynamic city;
  dynamic state;
  dynamic pincode;
  dynamic landmark;
  dynamic aadhaarCard;
  dynamic panCard;
  dynamic gstNumber;
  dynamic productCategory;
  dynamic otherProduct;
  dynamic accountNumber;
  dynamic confirmAccountNumber;
  dynamic ifscCode;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  dynamic token;

  Data({
    this.accountType,
    this.email,
    this.mobileNumber,
    this.shopName,
    this.shopPhoto,
    this.street,
    this.city,
    this.state,
    this.pincode,
    this.landmark,
    this.aadhaarCard,
    this.panCard,
    this.gstNumber,
    this.productCategory,
    this.otherProduct,
    this.accountNumber,
    this.confirmAccountNumber,
    this.ifscCode,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    accountType: json["account_type"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
    shopName: json["shop_name"],
    shopPhoto: json["shop_photo"],
    street: json["street"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    landmark: json["landmark"],
    aadhaarCard: json["aadhaar_card"],
    panCard: json["pan_card"],
    gstNumber: json["gst_number"],
    productCategory: json["product_category"],
    otherProduct: json["other_product"],
    accountNumber: json["account_number"],
    confirmAccountNumber: json["confirm_account_number"],
    ifscCode: json["ifsc_code"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "account_type": accountType,
    "email": email,
    "mobile_number": mobileNumber,
    "shop_name": shopName,
    "shop_photo": shopPhoto,
    "street": street,
    "city": city,
    "state": state,
    "pincode": pincode,
    "landmark": landmark,
    "aadhaar_card": aadhaarCard,
    "pan_card": panCard,
    "gst_number": gstNumber,
    "product_category": productCategory,
    "other_product": otherProduct,
    "account_number": accountNumber,
    "confirm_account_number": confirmAccountNumber,
    "ifsc_code": ifscCode,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "token": token,
  };
}

import 'dart:convert';

class ProfileRes {
  bool? success;
  String? message;
  Data? data;

  ProfileRes({
    this.success,
    this.message,
    this.data,
  });

  factory ProfileRes.fromJson(String str) => ProfileRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileRes.fromMap(Map<String, dynamic> json) => ProfileRes(
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
  int? id;
  String? accountType;
  dynamic email;
  String? mobileNumber;
  String? shopName;
  String? shopPhoto;
  String? street;
  String? city;
  String? state;
  String? pincode;
  String? landmark;
  String? aadhaarCard;
  String? panCard;
  String? gstNumber;
  String? productCategory;
  dynamic otherProduct;
  int? accountNumber;
  int? confirmAccountNumber;
  String? ifscCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Data({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

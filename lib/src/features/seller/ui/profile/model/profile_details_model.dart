import 'dart:convert';

ProfileRes profileResFromJson(String str) =>
    ProfileRes.fromMap(json.decode(str));

class ProfileRes {
  bool? status;
  String? message;
  Data? data;

  ProfileRes({this.status, this.message, this.data});

  factory ProfileRes.fromMap(Map<String, dynamic> json) => ProfileRes(
    status: json["status"] ?? json["stauts"], // API typo fix
    message: json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );
}

class Data {
  int? id;
  String? accountType;
  String? email;
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
  String? otherProduct;
  String? bankName;
  String? accountNumber;
  String? confirmAccountNumber;
  String? ifscCode;
  int? isVerify;

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
    this.bankName,
    this.accountNumber,
    this.confirmAccountNumber,
    this.ifscCode,
    this.isVerify,
  });

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
    bankName: json["bank_name"],
    accountNumber: json["account_number"],
    confirmAccountNumber: json["confirm_account_number"],
    ifscCode: json["ifsc_code"],
    isVerify: json["is_verify"],
  );
}

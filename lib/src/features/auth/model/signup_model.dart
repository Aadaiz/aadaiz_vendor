import 'dart:convert';

class SignUpRes {
  bool? success;
  dynamic message;
  Data? data;

  SignUpRes({
    this.success,
    this.message,
    this.data,
  });

  factory SignUpRes.fromJson(String str) => SignUpRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignUpRes.fromMap(Map<String, dynamic> json) => SignUpRes(
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
  dynamic mobileNumber;
  dynamic otpCode;
  dynamic otpToken;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic id;
  dynamic isRegister;

  Data({
    this.mobileNumber,
    this.otpCode,
    this.otpToken,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.isRegister,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    mobileNumber: json["mobile_number"],
    otpCode: json["otp_code"],
    otpToken: json["otp_token"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    isRegister: json["is_register"],
  );

  Map<String, dynamic> toMap() => {
    "mobile_number": mobileNumber,
    "otp_code": otpCode,
    "otp_token": otpToken,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "is_register": id,
  };
}

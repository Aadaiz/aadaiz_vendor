import 'dart:convert';

class OtpVerifyRes {
  bool? success;
  dynamic message;
  Data? data;

  OtpVerifyRes({
    this.success,
    this.message,
    this.data,
  });

  factory OtpVerifyRes.fromJson(String str) => OtpVerifyRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtpVerifyRes.fromMap(Map<String, dynamic> json) => OtpVerifyRes(
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
  Otp? otp;
  dynamic isRegister;
  dynamic token;

  Data({
    this.otp,
    this.isRegister,
    this.token
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    otp: json["otp"] == null ? null : Otp.fromMap(json["otp"]),
    isRegister: json["is_register"],
    token: json["token"]
  );

  Map<String, dynamic> toMap() => {
    "otp": otp?.toMap(),
    "is_register": isRegister,
    "token":token,
  };
}

class Otp {
  dynamic id;
  dynamic mobileNumber;
  dynamic otpCode;
  dynamic otpToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  Otp({
    this.id,
    this.mobileNumber,
    this.otpCode,
    this.otpToken,
    this.createdAt,
    this.updatedAt,
  });

  factory Otp.fromJson(String str) => Otp.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Otp.fromMap(Map<String, dynamic> json) => Otp(
    id: json["id"],
    mobileNumber: json["mobile_number"],
    otpCode: json["otp_code"],
    otpToken: json["otp_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "mobile_number": mobileNumber,
    "otp_code": otpCode,
    "otp_token": otpToken,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

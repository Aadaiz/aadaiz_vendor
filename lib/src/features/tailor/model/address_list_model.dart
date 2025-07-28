import 'dart:convert';

class TailorAddressListRes {
  bool? success;
  String? message;
  List<Datum>? data;

  TailorAddressListRes({
    this.success,
    this.message,
    this.data,
  });

  factory TailorAddressListRes.fromJson(String str) => TailorAddressListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TailorAddressListRes.fromMap(Map<String, dynamic> json) => TailorAddressListRes(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? id;
  String? name;
  dynamic userId;
  dynamic sellerId;
  int? tailorId;
  String? address;
  String? landmark;
  String? city;
  String? state;
  String? country;
  int? pincode;
  String? mobile;
  String? role;
  int? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.userId,
    this.sellerId,
    this.tailorId,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.mobile,
    this.role,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    userId: json["user_id"],
    sellerId: json["seller_id"],
    tailorId: json["tailor_id"],
    address: json["address"],
    landmark: json["landmark"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pincode: json["pincode"],
    mobile: json["mobile"],
    role: json["role"],
    isDefault: json["is_default"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "user_id": userId,
    "seller_id": sellerId,
    "tailor_id": tailorId,
    "address": address,
    "landmark": landmark,
    "city": city,
    "state": state,
    "country": country,
    "pincode": pincode,
    "mobile": mobile,
    "role": role,
    "is_default": isDefault,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

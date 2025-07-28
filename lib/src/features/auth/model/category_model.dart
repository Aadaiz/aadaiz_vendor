import 'dart:convert';

class CategoryListRes {
  bool? success;
  dynamic message;
  List<Fabric>? fabric;

  CategoryListRes({
    this.success,
    this.message,
    this.fabric,
  });

  factory CategoryListRes.fromJson(String str) => CategoryListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryListRes.fromMap(Map<String, dynamic> json) => CategoryListRes(
    success: json["success"],
    message: json["message"],
    fabric: json["fabric"] == null ? [] : List<Fabric>.from(json["fabric"]!.map((x) => Fabric.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "fabric": fabric == null ? [] : List<dynamic>.from(fabric!.map((x) => x.toMap())),
  };
}

class Fabric {
  dynamic id;
  dynamic catName;
  dynamic catImage;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Fabric({
    this.id,
    this.catName,
    this.catImage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Fabric.fromJson(String str) => Fabric.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Fabric.fromMap(Map<String, dynamic> json) => Fabric(
    id: json["id"],
    catName: json["cat_name"],
    catImage: json["cat_image"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cat_name": catName,
    "cat_image": catImage,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

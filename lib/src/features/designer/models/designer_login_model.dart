import 'dart:convert';

class DesignerLoginRes {
  final dynamic message;
  Designer? designer;

  DesignerLoginRes({
    this.message,
    this.designer,
  });

  factory DesignerLoginRes.fromJson(String str) => DesignerLoginRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DesignerLoginRes.fromMap(Map<String, dynamic> json) => DesignerLoginRes(
    message: json['message'],
    designer: json["designer"] == null ? null : Designer.fromMap(json["designer"]),
  );

  Map<String, dynamic> toMap() => {
    'message': message,
    "designer": designer?.toMap(),
  };
}

class Designer {
  dynamic id;
  dynamic categoryId;
  dynamic designerPreferenceId;
  dynamic name;
  dynamic email;
  dynamic gender;
  dynamic category;
  dynamic profileImage;
  dynamic about;
  dynamic avgRate;
  dynamic totalRate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic token;

  Designer({
    this.id,
    this.categoryId,
    this.designerPreferenceId,
    this.name,
    this.email,
    this.gender,
    this.category,
    this.profileImage,
    this.about,
    this.avgRate,
    this.totalRate,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory Designer.fromJson(String str) => Designer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Designer.fromMap(Map<String, dynamic> json) => Designer(
    id: json["id"],
    categoryId: json["category_id"],
    designerPreferenceId: json["designer_preference_id"],
    name: json["name"],
    email: json["email"],
    gender: json["gender"],
    category: json["category"],
    profileImage: json["profile_image"],
    about: json["about"],
    avgRate: json["avg_rate"],
    totalRate: json["total_rate"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "designer_preference_id": designerPreferenceId,
    "name": name,
    "email": email,
    "gender": gender,
    "category": category,
    "profile_image": profileImage,
    "about": about,
    "avg_rate": avgRate,
    "total_rate": totalRate,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "token": token,
  };
}

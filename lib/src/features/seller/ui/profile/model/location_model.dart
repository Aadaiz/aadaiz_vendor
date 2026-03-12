import 'dart:convert';

class CountryStateCityModel {
  bool? status;
  List<Datum>? data;
  String? message;

  CountryStateCityModel({
    this.status,
    this.data,
    this.message,
  });

  factory CountryStateCityModel.fromJson(String str) => CountryStateCityModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CountryStateCityModel.fromMap(Map<String, dynamic> json) => CountryStateCityModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Datum {
  int? id;
  String? code;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Datum({
    this.id,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "code": code,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

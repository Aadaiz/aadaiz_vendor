import 'dart:convert';

class TailorOrderListRes {
  bool? success;
  dynamic message;
  List<Datum>? data;

  TailorOrderListRes({
    this.success,
    this.message,
    this.data,
  });

  factory TailorOrderListRes.fromJson(String str) => TailorOrderListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TailorOrderListRes.fromMap(Map<String, dynamic> json) => TailorOrderListRes(
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
  dynamic id;
  dynamic userId;
  dynamic address;
  dynamic status;
  dynamic orderId;
  dynamic tailorId;
  dynamic sellerId;
  dynamic total;
  dynamic gstPercentage;
  dynamic shipingCharge;
  dynamic shipOrderId;
  dynamic shipmentId;
  dynamic cancelStatus;
  dynamic cancelHours;
  dynamic paymentType;
  dynamic paymentToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.address,
    this.status,
    this.orderId,
    this.tailorId,
    this.sellerId,
    this.total,
    this.gstPercentage,
    this.shipingCharge,
    this.shipOrderId,
    this.shipmentId,
    this.cancelStatus,
    this.cancelHours,
    this.paymentType,
    this.paymentToken,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    address: json["address"],
    status: json["status"],
    orderId: json["order_id"],
    tailorId: json["tailor_id"],
    sellerId: json["seller_id"],
    total: json["total"],
    gstPercentage: json["gst_percentage"],
    shipingCharge: json["shiping_charge"],
    shipOrderId: json["ship_order_id"],
    shipmentId: json["shipment_id"],
    cancelStatus: json["cancel_status"],
    cancelHours: json["cancel_hours"],
    paymentType: json["payment_type"],
    paymentToken: json["payment_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "status": status,
    "order_id": orderId,
    "tailor_id": tailorId,
    "seller_id": sellerId,
    "total": total,
    "gst_percentage": gstPercentage,
    "shiping_charge": shipingCharge,
    "ship_order_id": shipOrderId,
    "shipment_id": shipmentId,
    "cancel_status": cancelStatus,
    "cancel_hours": cancelHours,
    "payment_type": paymentType,
    "payment_token": paymentToken,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

import 'dart:convert';

class MyPaymentRes {
  String? status;
  List<Datum>? data;

  MyPaymentRes({
    this.status,
    this.data,
  });

  factory MyPaymentRes.fromJson(String str) => MyPaymentRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyPaymentRes.fromMap(Map<String, dynamic> json) => MyPaymentRes(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  String? serviceName;
  String? amount;
  DateTime? paymentDate;

  Datum({
    this.serviceName,
    this.amount,
    this.paymentDate,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    serviceName: json["service_name"],
    amount: json["amount"],
    paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
  );

  Map<String, dynamic> toMap() => {
    "service_name": serviceName,
    "amount": amount,
    "payment_date": paymentDate?.toIso8601String(),
  };
}
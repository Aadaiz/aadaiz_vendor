import 'dart:convert';

class TailordashRes {
  bool? status;
  Data? data;
  String? message;

  TailordashRes({
    this.status,
    this.data,
    this.message,
  });

  factory TailordashRes.fromRawJson(String str) => TailordashRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TailordashRes.fromJson(Map<String, dynamic> json) => TailordashRes(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  dynamic? lastMonthOrderscount;
  dynamic? lastMonthPaymentReceived;
  Map<String, int>? monthlySales;
  WeeklySales? weeklySales;
  DailySales? dailySales;
  List<PaymentHistory>? paymentHistory;

  Data({
    this.lastMonthOrderscount,
    this.lastMonthPaymentReceived,
    this.monthlySales,
    this.weeklySales,
    this.dailySales,
    this.paymentHistory,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    lastMonthOrderscount: json["lastMonthOrderscount"],
    lastMonthPaymentReceived: json["lastMonthPaymentReceived"],
    monthlySales: Map.from(json["monthlySales"]!).map((k, v) => MapEntry<String, int>(k, v)),
    weeklySales: json["weeklySales"] == null ? null : WeeklySales.fromJson(json["weeklySales"]),
    dailySales: json["dailySales"] == null ? null : DailySales.fromJson(json["dailySales"]),
    paymentHistory: json["paymentHistory"] == null ? [] : List<PaymentHistory>.from(json["paymentHistory"]!.map((x) => PaymentHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lastMonthOrderscount": lastMonthOrderscount,
    "lastMonthPaymentReceived": lastMonthPaymentReceived,
    "monthlySales": Map.from(monthlySales!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "weeklySales": weeklySales?.toJson(),
    "dailySales": dailySales?.toJson(),
    "paymentHistory": paymentHistory == null ? [] : List<dynamic>.from(paymentHistory!.map((x) => x.toJson())),
  };
}

class DailySales {
  int? mon;
  int? tue;
  int? wed;
  int? thu;
  int? fri;
  int? sat;
  int? sun;

  DailySales({
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
    this.sun,
  });

  factory DailySales.fromRawJson(String str) => DailySales.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DailySales.fromJson(Map<String, dynamic> json) => DailySales(
    mon: json["Mon"],
    tue: json["Tue"],
    wed: json["Wed"],
    thu: json["Thu"],
    fri: json["Fri"],
    sat: json["Sat"],
    sun: json["Sun"],
  );

  Map<String, dynamic> toJson() => {
    "Mon": mon,
    "Tue": tue,
    "Wed": wed,
    "Thu": thu,
    "Fri": fri,
    "Sat": sat,
    "Sun": sun,
  };
}

class PaymentHistory {
  int? id;
  int? tailorId;
  int? amount;
  String? paymentDate;
  String? serviceName;

  PaymentHistory({
    this.id,
    this.tailorId,
    this.amount,
    this.paymentDate,
    this.serviceName,
  });

  factory PaymentHistory.fromRawJson(String str) => PaymentHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
    id: json["id"],
    tailorId: json["tailor_id"],
    amount: json["amount"],
    paymentDate: json["payment_date"],
    serviceName: json["service_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tailor_id": tailorId,
    "amount": amount,
    "payment_date": paymentDate,
    "service_name": serviceName,
  };
}

class WeeklySales {
  int? week1;
  int? week2;
  int? week3;
  int? week4;

  WeeklySales({
    this.week1,
    this.week2,
    this.week3,
    this.week4,
  });

  factory WeeklySales.fromRawJson(String str) => WeeklySales.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeeklySales.fromJson(Map<String, dynamic> json) => WeeklySales(
    week1: json["week1"],
    week2: json["week2"],
    week3: json["week3"],
    week4: json["week4"],
  );

  Map<String, dynamic> toJson() => {
    "week1": week1,
    "week2": week2,
    "week3": week3,
    "week4": week4,
  };
}

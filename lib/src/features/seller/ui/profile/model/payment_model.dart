import 'dart:convert';

class MyPaymentRes {
  bool? status;
  String? message;
  List<Datum>? data;
  Pagination? pagination;

  MyPaymentRes({
    this.status,
    this.message,
    this.data,
    this.pagination,
  });

  factory MyPaymentRes.fromJson(String str) =>
      MyPaymentRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyPaymentRes.fromMap(Map<String, dynamic> json) => MyPaymentRes(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromMap(json["pagination"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toMap())),
    "pagination": pagination?.toMap(),
  };
}

class Datum {
  String? amount;
  String? transactionId;
  String? date;
  String? time;
  String? month;
  String? day;

  Datum({
    this.amount,
    this.transactionId,
    this.date,
    this.time,
    this.month,
    this.day,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    amount: json["amount"],
    transactionId: json["transaction_id"],
    date: json["date"],
    time: json["time"],
    month: json["month"],
    day: json["day"],
  );

  Map<String, dynamic> toMap() => {
    "amount": amount,
    "transaction_id": transactionId,
    "date": date,
    "time": time,
    "month": month,
    "day": day,
  };
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
  };
}
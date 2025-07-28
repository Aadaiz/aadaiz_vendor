import 'dart:convert';

class SellerOrderRes {
  bool? status;
  Data? data;
  String? message;

  SellerOrderRes({
    this.status,
    this.data,
    this.message,
  });

  factory SellerOrderRes.fromRawJson(String str) => SellerOrderRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerOrderRes.fromJson(Map<String, dynamic> json) => SellerOrderRes(
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
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int? id;
  int? orderId;
  int? patternId;
  int? sellerId;
  dynamic tailorId;
  String? price;
  dynamic quantity;
  String? fabricMetre;
  dynamic size;
  String? measurement;
  String? cancelStatus;
  String? cancelHours;
  String? orderStatus;
  dynamic materialStatus;
  dynamic trackingStatus;
  dynamic receivedImage;
  dynamic completedImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? orderDate;
  Products? products;

  Datum({
    this.id,
    this.orderId,
    this.patternId,
    this.sellerId,
    this.tailorId,
    this.price,
    this.quantity,
    this.fabricMetre,
    this.size,
    this.measurement,
    this.cancelStatus,
    this.cancelHours,
    this.orderStatus,
    this.materialStatus,
    this.trackingStatus,
    this.receivedImage,
    this.completedImage,
    this.createdAt,
    this.updatedAt,
    this.orderDate,
    this.products,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderId: json["order_id"],
    patternId: json["pattern_id"],
    sellerId: json["seller_id"],
    tailorId: json["tailor_id"],
    price: json["price"],
    quantity: json["quantity"],
    fabricMetre: json["fabric_metre"],
    size: json["size"],
    measurement: json["measurement"],
    cancelStatus: json["cancel_status"],
    cancelHours: json["cancel_hours"],
    orderStatus: json["order_status"],
    materialStatus: json["material_status"],
    trackingStatus: json["tracking_status"],
    receivedImage: json["received_image"],
    completedImage: json["completed_image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    orderDate: json["order_date"],
    products: json["products"] == null ? null : Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "pattern_id": patternId,
    "seller_id": sellerId,
    "tailor_id": tailorId,
    "price": price,
    "quantity": quantity,
    "fabric_metre": fabricMetre,
    "size": size,
    "measurement": measurement,
    "cancel_status": cancelStatus,
    "cancel_hours": cancelHours,
    "order_status": orderStatus,
    "material_status": materialStatus,
    "tracking_status": trackingStatus,
    "received_image": receivedImage,
    "completed_image": completedImage,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "order_date": orderDate,
    "products": products?.toJson(),
  };
}

class Products {
  int? id;
  String? title;
  String? category;
  String? image;
  String? price;
  String? color;

  Products({
    this.id,
    this.title,
    this.category,
    this.image,
    this.price,
    this.color,
  });

  factory Products.fromRawJson(String str) => Products.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    image: json["image"],
    price: json["price"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "image": image,
    "price": price,
    "color": color,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

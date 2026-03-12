
import 'dart:convert';

class SellerOrderRes {
  bool? status;
  Data? data;
  dynamic? message;

  SellerOrderRes({
    this.status,
    this.data,
    this.message,
  });

  factory SellerOrderRes.fromRawJson(dynamic str) => SellerOrderRes.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory SellerOrderRes.fromJson(Map<dynamic, dynamic> json) => SellerOrderRes(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<dynamic, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  dynamic? currentPage;
  List<Datum>? data;
  dynamic? firstPageUrl;
  dynamic? from;
  dynamic? lastPage;
  dynamic? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  dynamic? path;
  dynamic? perPage;
  dynamic prevPageUrl;
  dynamic? to;
  dynamic? total;

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

  factory Data.fromRawJson(dynamic str) => Data.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
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

  Map<dynamic, dynamic> toJson() => {
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
  dynamic? id;
  dynamic? userId; // NEW
  dynamic? orderId;
  dynamic patternId;
  dynamic? materialId;
  dynamic? sellerId;
  dynamic tailorId;

  dynamic? price;
  dynamic? quantity;

  dynamic? discount; // NEW
  dynamic? tax; // NEW
  dynamic? deliveryCharge; // NEW
  dynamic? total; // NEW

  dynamic fabricMetre;
  dynamic size;
  dynamic measurement;

  dynamic cancelStatus;
  dynamic cancelHours;

  dynamic orderStatus;
  dynamic materialStatus;
  dynamic trackingStatus;

  dynamic receivedImage;
  dynamic completedImage;

  dynamic shiprocketOrderId; // NEW
  dynamic shiprocketShipmentId; // NEW
  dynamic awbCode; // NEW
  dynamic courierName; // NEW

  DateTime? createdAt;
  DateTime? updatedAt;

  Order? order;
  Product? product;

  Datum({
    this.id,
    this.userId,
    this.orderId,
    this.patternId,
    this.materialId,
    this.sellerId,
    this.tailorId,
    this.price,
    this.quantity,
    this.discount,
    this.tax,
    this.deliveryCharge,
    this.total,
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
    this.shiprocketOrderId,
    this.shiprocketShipmentId,
    this.awbCode,
    this.courierName,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.product,
  });

  factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"], // NEW
    orderId: json["order_id"],
    patternId: json["pattern_id"],
    materialId: json["material_id"],
    sellerId: json["seller_id"],
    tailorId: json["tailor_id"],
    price: json["price"],
    quantity: json["quantity"],
    discount: json["discount"], // NEW
    tax: json["tax"], // NEW
    deliveryCharge: json["delivery_charge"], // NEW
    total: json["total"], // NEW
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
    shiprocketOrderId: json["shiprocket_order_id"], // NEW
    shiprocketShipmentId: json["shiprocket_shipment_id"], // NEW
    awbCode: json["awb_code"], // NEW
    courierName: json["courier_name"], // NEW
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    product:
    json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_id": orderId,
    "pattern_id": patternId,
    "material_id": materialId,
    "seller_id": sellerId,
    "tailor_id": tailorId,
    "price": price,
    "quantity": quantity,
    "discount": discount,
    "tax": tax,
    "delivery_charge": deliveryCharge,
    "total": total,
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
    "shiprocket_order_id": shiprocketOrderId,
    "shiprocket_shipment_id": shiprocketShipmentId,
    "awb_code": awbCode,
    "courier_name": courierName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "order": order?.toJson(),
    "product": product?.toJson(),
  };
}

class Order {
  dynamic? id;
  dynamic? userId;
  dynamic? address;
  dynamic? status;
  dynamic orderId;
  dynamic tailorId;
  dynamic? sellerId;
  dynamic total;
  dynamic gstPercentage;
  dynamic shipingCharge;
  dynamic shipOrderId;
  dynamic shipmentId;
  dynamic? cancelStatus;
  dynamic? cancelHours;
  dynamic paymentType;
  dynamic paymentToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  Order({
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

  factory Order.fromRawJson(dynamic str) => Order.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<dynamic, dynamic> json) => Order(
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

  Map<dynamic, dynamic> toJson() => {
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

class Product {
  dynamic? id;
  dynamic? sellerId;
  dynamic? title;
  dynamic? subtitle;
  dynamic? category;
  dynamic? image;
  dynamic? color;
  dynamic? price;
  dynamic? aadaizPrice;
  dynamic? meter;
  dynamic? description;
  dynamic rating;
  dynamic? status;
  dynamic peopleView;
  dynamic? stockStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.sellerId,
    this.title,
    this.subtitle,
    this.category,
    this.image,
    this.color,
    this.price,
    this.aadaizPrice,
    this.meter,
    this.description,
    this.rating,
    this.status,
    this.peopleView,
    this.stockStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromRawJson(dynamic str) => Product.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<dynamic, dynamic> json) => Product(
    id: json["id"],
    sellerId: json["seller_id"],
    title: json["title"],
    subtitle: json["subtitle"],
    category: json["category"],
    image: json["image"],
    color: json["color"],
    price: json["price"],
    aadaizPrice: json["aadaiz_price"],
    meter: json["meter"],
    description: json["description"],
    rating: json["rating"],
    status: json["status"],
    peopleView: json["people_view"],
    stockStatus: json["stock_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "seller_id": sellerId,
    "title": title,
    "subtitle": subtitle,
    "category": category,
    "image": image,
    "color": color,
    "price": price,
    "aadaiz_price": aadaizPrice,
    "meter": meter,
    "description": description,
    "rating": rating,
    "status": status,
    "people_view": peopleView,
    "stock_status": stockStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Link {
  dynamic? url;
  dynamic? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromRawJson(dynamic str) => Link.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<dynamic, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<dynamic, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
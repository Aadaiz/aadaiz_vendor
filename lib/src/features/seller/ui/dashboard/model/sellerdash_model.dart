import 'dart:convert';

// class SellerdashRes {
//   bool? status;
//   Data? data;
//   String? message;
//
//   SellerdashRes({
//     this.status,
//     this.data,
//     this.message,
//   });
//
//   factory SellerdashRes.fromRawJson(String str) => SellerdashRes.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory SellerdashRes.fromJson(Map<String, dynamic> json) => SellerdashRes(
//     status: json["status"],
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     message: json["message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": data?.toJson(),
//     "message": message,
//   };
// }
//
// class Data {
//   int? lastMonthRevenue;
//   int? lastMonthProductSold;
//   int? lastMonthCustomersCount;
//   Map<String, int>? monthlySales;
//   WeeklySales? weeklySales;
//   DailySales? dailySales;
//   List<ThisProductsSold>? thisYearProductsSold;
//   List<ThisProductsSold>? thisMonthProductsSold;
//   List<ThisProductsSold>? thisWeekProductsSold;
//
//   Data({
//     this.lastMonthRevenue,
//     this.lastMonthProductSold,
//     this.lastMonthCustomersCount,
//     this.monthlySales,
//     this.weeklySales,
//     this.dailySales,
//     this.thisYearProductsSold,
//     this.thisMonthProductsSold,
//     this.thisWeekProductsSold,
//   });
//
//   factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     lastMonthRevenue: json["lastMonthRevenue"],
//     lastMonthProductSold: json["lastMonthProductSold"],
//     lastMonthCustomersCount: json["lastMonthCustomersCount"],
//     monthlySales: Map.from(json["monthlySales"]!).map((k, v) => MapEntry<String, int>(k, v)),
//     weeklySales: json["weeklySales"] == null ? null : WeeklySales.fromJson(json["weeklySales"]),
//     dailySales: json["dailySales"] == null ? null : DailySales.fromJson(json["dailySales"]),
//     thisYearProductsSold: json["thisYearProductsSold"] == null ? [] : List<ThisProductsSold>.from(json["thisYearProductsSold"]!.map((x) => ThisProductsSold.fromJson(x))),
//     thisMonthProductsSold: json["thisMonthProductsSold"] == null ? [] : List<ThisProductsSold>.from(json["thisMonthProductsSold"]!.map((x) => ThisProductsSold.fromJson(x))),
//     thisWeekProductsSold: json["thisWeekProductsSold"] == null ? [] : List<ThisProductsSold>.from(json["thisWeekProductsSold"]!.map((x) => ThisProductsSold.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "lastMonthRevenue": lastMonthRevenue,
//     "lastMonthProductSold": lastMonthProductSold,
//     "lastMonthCustomersCount": lastMonthCustomersCount,
//     "monthlySales": Map.from(monthlySales!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "weeklySales": weeklySales?.toJson(),
//     "dailySales": dailySales?.toJson(),
//     "thisYearProductsSold": thisYearProductsSold == null ? [] : List<dynamic>.from(thisYearProductsSold!.map((x) => x.toJson())),
//     "thisMonthProductsSold": thisMonthProductsSold == null ? [] : List<dynamic>.from(thisMonthProductsSold!.map((x) => x.toJson())),
//     "thisWeekProductsSold": thisWeekProductsSold == null ? [] : List<dynamic>.from(thisWeekProductsSold!.map((x) => x.toJson())),
//   };
// }
//
// class DailySales {
//   int? mon;
//   int? tue;
//   int? wed;
//   int? thu;
//   int? fri;
//   int? sat;
//   int? sun;
//
//   DailySales({
//     this.mon,
//     this.tue,
//     this.wed,
//     this.thu,
//     this.fri,
//     this.sat,
//     this.sun,
//   });
//
//   factory DailySales.fromRawJson(String str) => DailySales.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory DailySales.fromJson(Map<String, dynamic> json) => DailySales(
//     mon: json["Mon"],
//     tue: json["Tue"],
//     wed: json["Wed"],
//     thu: json["Thu"],
//     fri: json["Fri"],
//     sat: json["Sat"],
//     sun: json["Sun"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Mon": mon,
//     "Tue": tue,
//     "Wed": wed,
//     "Thu": thu,
//     "Fri": fri,
//     "Sat": sat,
//     "Sun": sun,
//   };
// }
//
// class ThisProductsSold {
//   Product? product;
//   int? totalSold;
//
//   ThisProductsSold({
//     this.product,
//     this.totalSold,
//   });
//
//   factory ThisProductsSold.fromRawJson(String str) => ThisProductsSold.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory ThisProductsSold.fromJson(Map<String, dynamic> json) => ThisProductsSold(
//     product: json["product"] == null ? null : Product.fromJson(json["product"]),
//     totalSold: json["total_sold"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "product": product?.toJson(),
//     "total_sold": totalSold,
//   };
// }
//
// class Product {
//   int? id;
//   String? title;
//   String? category;
//   String? image;
//   String? price;
//   String? color;
//
//   Product({
//     this.id,
//     this.title,
//     this.category,
//     this.image,
//     this.price,
//     this.color,
//   });
//
//   factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     title: json["title"],
//     category: json["category"],
//     image: json["image"],
//     price: json["price"],
//     color: json["color"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "category": category,
//     "image": image,
//     "price": price,
//     "color": color,
//   };
// }
//
// class WeeklySales {
//   int? week1;
//   int? week2;
//   int? week3;
//   int? week4;
//
//   WeeklySales({
//     this.week1,
//     this.week2,
//     this.week3,
//     this.week4,
//   });
//
//   factory WeeklySales.fromRawJson(String str) => WeeklySales.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory WeeklySales.fromJson(Map<String, dynamic> json) => WeeklySales(
//     week1: json["week1"],
//     week2: json["week2"],
//     week3: json["week3"],
//     week4: json["week4"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "week1": week1,
//     "week2": week2,
//     "week3": week3,
//     "week4": week4,
//   };
// }

class SellerDashRes {
  bool? status;
  int? revenue;
  int? customer;
  int? productSold;
  int? totalSales;
  int? totalOrders;
  List<SalesChart>? salesChart;
  List<TopProducts>? topProducts;

  SellerDashRes({
    this.status,
    this.revenue,
    this.customer,
    this.productSold,
    this.totalSales,
    this.totalOrders,
    this.salesChart,
    this.topProducts,
  });

  factory SellerDashRes.fromRawJson(String str) =>
      SellerDashRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerDashRes.fromJson(Map<String, dynamic> json) => SellerDashRes(
    status: json["status"],
    revenue: json["revenue"],
    customer: json["customer"],
    productSold: json["product_sold"],
    totalSales: json["total_sales"],
    totalOrders: json["total_orders"],
    salesChart: json["sales_chart"] == null
        ? []
        : List<SalesChart>.from(
        json["sales_chart"].map((x) => SalesChart.fromJson(x))),
    topProducts: json["top_products"] == null
        ? []
        : List<TopProducts>.from(
        json["top_products"].map((x) => TopProducts.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "revenue": revenue,
    "customer": customer,
    "product_sold": productSold,
    "total_sales": totalSales,
    "total_orders": totalOrders,
    "sales_chart":
    salesChart == null ? [] : salesChart!.map((x) => x.toJson()).toList(),
    "top_products": topProducts == null
        ? []
        : topProducts!.map((x) => x.toJson()).toList(),
  };
}

class SalesChart {
  String? label;
  int? totalSales;

  SalesChart({
    this.label,
    this.totalSales,
  });

  factory SalesChart.fromJson(Map<String, dynamic> json) => SalesChart(
    label: json["label"],
    totalSales: json["total_sales"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "total_sales": totalSales,
  };
}

class TopProducts {
  int? materialId;
  int? totalOrders;
  int? totalUnitsSold;
  Product? product;

  TopProducts({
    this.materialId,
    this.totalOrders,
    this.totalUnitsSold,
    this.product,
  });

  factory TopProducts.fromJson(Map<String, dynamic> json) => TopProducts(
    materialId: json["material_id"],
    totalOrders: json["total_orders"],
    totalUnitsSold: json["total_units_sold"],
    product:
    json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "material_id": materialId,
    "total_orders": totalOrders,
    "total_units_sold": totalUnitsSold,
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  String? title;
  String? color;
  String? price;
  String? image;

  Product({
    this.id,
    this.title,
    this.color,
    this.price,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    color: json["color"],
    price: json["price"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "color": color,
    "price": price,
    "image": image,
  };
}
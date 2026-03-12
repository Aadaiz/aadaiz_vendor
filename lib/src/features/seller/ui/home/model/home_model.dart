class ProductResponse {
  final bool success;
  final String message;
  final Pagination data;

  ProductResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'],
      message: json['message'],
      data: Pagination.fromJson(json['data']),
    );
  }
}

class Product {
  final int sellerId;
  final String title;
  final String subtitle;
  final String category;
  final String image;
  final String color;
  final String price;
  final double aadaizPrice;
  final String meter;
  final String description;
  final String updatedAt;
  final String createdAt;
  final int id;
  final dynamic rating;
  final dynamic? status;
  final dynamic? peopleView;
  final dynamic stockStatus;
  final Coupon? coupon;

  Product({
    required this.sellerId,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.image,
    required this.color,
    required this.price,
    required this.aadaizPrice,
    required this.meter,
    required this.description,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    this.rating,
    this.status,
    this.peopleView,
    this.stockStatus,
    this.coupon,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      sellerId: json['seller_id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      color: json['color'] as String,
      price: json['price'] as String,
      aadaizPrice: (json['aadaiz_price'] as num).toDouble(),
      meter: json['meter'] as String,
      description: json['description'] as String,
      updatedAt: json['updated_at'] as String,
      createdAt: json['created_at'] as String,
      id: json['id'] as int,
      rating: json['rating'],
      status: json['status'],
      peopleView: json['people_view'] as int?,
      stockStatus: json['stock_status'] as String?,
      coupon: json['coupon'] != null ? Coupon.fromJson(json['coupon']) : null,
    );
  }
}

class Coupon {
  final int id;
  final int materialId;
  final int sellerId;
  final String title;
  final String description;
  final String? imageUrl;
  final String couponCode;
  final String couponType;
  final String discount;
  final String validFrom;
  final String validTo;
  final String createdAt;
  final String updatedAt;

  Coupon({
    required this.id,
    required this.materialId,
    required this.sellerId,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.couponCode,
    required this.couponType,
    required this.discount,
    required this.validFrom,
    required this.validTo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'] as int,
      materialId: json['material_id'] as int,
      sellerId: json['seller_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String?,
      couponCode: json['coupon_code'] as String,
      couponType: json['coupon_type'] as String,
      discount: json['discount'] as String,
      validFrom: json['valid_from'] as String,
      validTo: json['valid_to'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'material_id': materialId,
      'seller_id': sellerId,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'coupon_code': couponCode,
      'coupon_type': couponType,
      'discount': discount,
      'valid_from': validFrom,
      'valid_to': validTo,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Pagination {
  final int currentPage;
  final List<Product> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  Pagination({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] as int,
      data: (json['data'] as List<dynamic>).map((item) => Product.fromJson(item)).toList(),
      firstPageUrl: json['first_page_url'] as String,
      from: json['from'] as int,
      lastPage: json['last_page'] as int,
      lastPageUrl: json['last_page_url'] as String,
      links: (json['links'] as List<dynamic>).map((item) => Link.fromJson(item)).toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String,
      perPage: json['per_page'] as int,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int,
      total: json['total'] as int,
    );
  }
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'] as String?,
      label: json['label'] as String,
      active: json['active'] as bool,
    );
  }
}
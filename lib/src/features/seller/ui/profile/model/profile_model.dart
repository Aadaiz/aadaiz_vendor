class MyProfileRes {
  final bool success;
  final String message;
  final List<Datum>? data;

  MyProfileRes({
    required this.success,
    required this.message,
    this.data,
  });

  factory MyProfileRes.fromMap(Map<String, dynamic> map) {
    List<Datum>? dataList;
    if (map['data'] != null) {
      // Check if data is a list or a single object
      if (map['data'] is List) {
        dataList = (map['data'] as List)
            .map((item) => Datum.fromMap(item as Map<String, dynamic>))
            .toList();
      } else if (map['data'] is Map<String, dynamic>) {
        // If it's a single object, wrap it in a list
        dataList = [Datum.fromMap(map['data'] as Map<String, dynamic>)];
      }
    }

    return MyProfileRes(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
      data: dataList,
    );
  }
}

class Datum {
  final int id;
  final String? name;
  final String? userId;
  final int? sellerId;
  final String? tailorId;
  final String? address;
  final String? landmark;
  final String? city;
  final String? state;
  final String? country;
  final dynamic? pincode;
  final String? mobile;
  final String? role;
  final int? isDefault;
  final String? createdAt;
  final String? updatedAt;

  Datum({
    required this.id,
    this.name,
    this.userId,
    this.sellerId,
    this.tailorId,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.mobile,
    this.role,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromMap(Map<String, dynamic> map) {
    return Datum(
      id: map['id'] ?? 0,
      name: map['name'],
      userId: map['user_id']?.toString(),
      sellerId: map['seller_id'],
      tailorId: map['tailor_id']?.toString(),
      address: map['address'],
      landmark: map['landmark'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      pincode: map['pincode'],
      mobile: map['mobile'],
      role: map['role'],
      isDefault: map['is_default'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
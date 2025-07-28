import 'dart:convert';

class DesignerNotificationRes {
  bool? status;
  dynamic message;
  Data? data;

  DesignerNotificationRes({
    this.status,
    this.message,
    this.data,
  });

  factory DesignerNotificationRes.fromJson(String str) => DesignerNotificationRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DesignerNotificationRes.fromMap(Map<String, dynamic> json) => DesignerNotificationRes(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  dynamic currentPage;
  List<DesignerNotification>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

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

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<DesignerNotification>.from(json["data"]!.map((x) => DesignerNotification.fromMap(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toMap())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class DesignerNotification {
  dynamic id;
  dynamic userId;
  dynamic designerId;
  dynamic entityType;
  dynamic entityId;
  dynamic title;
  dynamic message;
  dynamic readAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  DesignerNotification({
    this.id,
    this.userId,
    this.designerId,
    this.entityType,
    this.entityId,
    this.title,
    this.message,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory DesignerNotification.fromJson(String str) => DesignerNotification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DesignerNotification.fromMap(Map<String, dynamic> json) => DesignerNotification(
    id: json["id"],
    userId: json["user_id"],
    designerId: json["desinger_id"],
    entityType: json["entity_type"],
    entityId: json["entity_id"],
    title: json["title"],
    message: json["message"],
    readAt: json["read_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "desinger_id": designerId,
    "entity_type": entityType,
    "entity_id": entityId,
    "title": title,
    "message": message,
    "read_at": readAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Link {
  dynamic url;
  dynamic label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

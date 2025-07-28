import 'dart:convert';

class SupportListRes {
  Tickets? tickets;

  SupportListRes({
    this.tickets,
  });

  factory SupportListRes.fromJson(String str) => SupportListRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SupportListRes.fromMap(Map<String, dynamic> json) => SupportListRes(
    tickets: json["tickets"] == null ? null : Tickets.fromMap(json["tickets"]),
  );

  Map<String, dynamic> toMap() => {
    "tickets": tickets?.toMap(),
  };
}

class Tickets {
  dynamic currentPage;
  List<Datum>? data;
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

  Tickets({
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

  factory Tickets.fromJson(String str) => Tickets.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tickets.fromMap(Map<String, dynamic> json) => Tickets(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
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

class Datum {
  dynamic id;
  dynamic ticketNumber;
  dynamic title;
  dynamic description;
  dynamic type;
  dynamic status;
  dynamic attachment;
  dynamic deleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.ticketNumber,
    this.title,
    this.description,
    this.type,
    this.status,
    this.attachment,
    this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    ticketNumber: json["ticket_number"],
    title: json["title"],
    description: json["description"],
    type: json["type"],
    status: json["status"],
    attachment: json["attachment"],
    deleted: json["deleted"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "ticket_number": ticketNumber,
    "title": title,
    "description": description,
    "type": type,
    "status": status,
    "attachment": attachment,
    "deleted": deleted,
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

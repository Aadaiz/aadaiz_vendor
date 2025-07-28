import 'dart:convert';

class DesignerAppointmentRes {
  bool? status;
  dynamic message;
  Data? data;

  DesignerAppointmentRes({
    this.status,
    this.message,
    this.data,
  });

  factory DesignerAppointmentRes.fromJson(String str) => DesignerAppointmentRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DesignerAppointmentRes.fromMap(Map<String, dynamic> json) => DesignerAppointmentRes(
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
  List<DesignerAppointment>? data;
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
    data: json["data"] == null ? [] : List<DesignerAppointment>.from(json["data"]!.map((x) => DesignerAppointment.fromMap(x))),
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

class DesignerAppointment {
  dynamic appointmentId;
  dynamic username;
  dynamic profileImage;
  dynamic date;
  dynamic time;
  dynamic status;
  dynamic amount;
  dynamic zoomMeetingId;
  dynamic zoomJoinUrl;

  DesignerAppointment({
    this.appointmentId,
    this.username,
    this.profileImage,
    this.date,
    this.time,
    this.status,
    this.amount,
    this.zoomMeetingId,
    this.zoomJoinUrl,
  });

  factory DesignerAppointment.fromJson(String str) => DesignerAppointment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DesignerAppointment.fromMap(Map<String, dynamic> json) => DesignerAppointment(
    appointmentId: json["appointment_id"],
    username: json["username"],
    profileImage: json["profile_image"],
    date: json["date"],
    time: json["time"],
    status: json["status"],
    amount: json["amount"],
    zoomMeetingId: json["zoom_meeting_id"],
    zoomJoinUrl: json["zoom_join_url"],
  );

  Map<String, dynamic> toMap() => {
    "appointment_id": appointmentId,
    "username": username,
    "profile_image": profileImage,
    "date": date,
    "time": time,
    "status": status,
    "amount": amount,
    "zoom_meeting_id": zoomMeetingId,
    "zoom_join_url": zoomJoinUrl,
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

import 'dart:convert';

class DesignerProfileRes {
  bool? status;
  String? message;
  DesignerProfile? data;

  DesignerProfileRes({
    this.status,
    this.message,
    this.data,
  });

  factory DesignerProfileRes.fromJson(String str) => DesignerProfileRes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DesignerProfileRes.fromMap(Map<String, dynamic> json) => DesignerProfileRes(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : DesignerProfile.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data?.toMap(),
  };
}

class DesignerProfile {
  String? name;
  String? email;
  String? avatarUrl;
  List<ScheduleData>? scheduleData;

  DesignerProfile({
    this.name,
    this.email,
    this.avatarUrl,
    this.scheduleData,
  });

  factory DesignerProfile.fromJson(String str) => DesignerProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DesignerProfile.fromMap(Map<String, dynamic> json) => DesignerProfile(
    name: json["name"],
    email: json["email"],
    avatarUrl: json["avatar_url"],
    scheduleData: json["timings"] == null ? [] : List<ScheduleData>.from(json["timings"]!.map((x) => ScheduleData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "avatar_url": avatarUrl,
    "timings": scheduleData == null ? [] : List<dynamic>.from(scheduleData!.map((x) => x.toMap())),
  };
}


class ScheduleData {
  int? dateOfWeek;
  String? morStartTime;
  String? morEndTime;
  String? eveStartTime;
  String? eveEndTime;

  ScheduleData({
    this.dateOfWeek,
    this.morStartTime,
    this.morEndTime,
    this.eveStartTime,
    this.eveEndTime,
  });

  factory ScheduleData.fromJson(String str) => ScheduleData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScheduleData.fromMap(Map<String, dynamic> json) => ScheduleData(
    dateOfWeek: json["day_of_week"],
    morStartTime: json["mor_start_time"],
    morEndTime: json["mor_end_time"],
    eveStartTime: json["eve_start_time"],
    eveEndTime: json["eve_end_time"],
  );

  Map<String, dynamic> toMap() => {
    "day_of_week": dateOfWeek,
    "mor_start_time": morStartTime,
    "mor_end_time": morEndTime,
    "eve_start_time": eveStartTime,
    "eve_end_time": eveEndTime,
  };
}

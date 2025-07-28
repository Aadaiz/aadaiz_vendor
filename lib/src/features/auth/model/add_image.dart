import 'dart:convert';

class AddImage {
  dynamic url;

  AddImage({
    this.url,
  });

  factory AddImage.fromRawJson(String str) => AddImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddImage.fromJson(Map<String, dynamic> json) => AddImage(
    url: json["url"]??"",
  );

  Map<String, dynamic> toJson() => {
    "url": url??"",
  };
}
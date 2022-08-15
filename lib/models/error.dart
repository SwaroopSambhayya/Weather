import 'dart:convert';

Error errorFromJson(String str) {
  final jsonData = json.decode(str);
  return Error.fromJson(jsonData);
}

String errorToJson(Error data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Error {
  String title;
  String subtitle;
  String asset;

  Error({
    required this.title,
    required this.subtitle,
    required this.asset,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        title: json["title"],
        subtitle: json["subtitle"],
        asset: json["asset"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "asset": asset,
      };
}

import 'package:flutter/rendering.dart';

class OnboaridngData {
  String? title;
  String? description;
  String? assetUrl;
  Color? textColors;
  Color? buttonColor;

  OnboaridngData({
    this.title,
    this.description,
    this.assetUrl,
    this.textColors,
    this.buttonColor,
  });

  factory OnboaridngData.fromJson(Map<String, dynamic> json) {
    return OnboaridngData(
      title: json['title'] as String?,
      description: json['description'] as String?,
      assetUrl: json['assetUrl'] as String?,
      textColors: json['textColors'] as Color?,
      buttonColor: json['buttonColor'] as Color?,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'assetUrl': assetUrl,
        'textColors': textColors,
        'buttonColor': buttonColor,
      };
}

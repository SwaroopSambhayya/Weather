import 'dart:convert';

PlaceDetail placeDetailFromJson(String str) {
  final jsonData = json.decode(str);
  return PlaceDetail.fromJson(jsonData);
}

String placeDetailToJson(PlaceDetail data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class PlaceDetail {
  List<Prediction> predictions;

  PlaceDetail({
    required this.predictions,
  });

  factory PlaceDetail.fromJson(Map<String, dynamic> json) => PlaceDetail(
        predictions: List<Prediction>.from(
            json["predictions"].map((x) => Prediction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "predictions": List<dynamic>.from(predictions.map((x) => x.toJson())),
      };
}

class Prediction {
  String description;
  List<MatchedSubstring>? matchedSubstrings;
  String placeId;
  String reference;
  StructuredFormatting? structuredFormatting;
  List<Term>? terms;
  List<String>? types;

  Prediction({
    this.description = "",
    this.matchedSubstrings,
    this.placeId = "",
    this.reference = "",
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        description: json["description"] ?? "",
        matchedSubstrings: List<MatchedSubstring>.from(
            json["matched_substrings"]
                .map((x) => MatchedSubstring.fromJson(x))),
        placeId: json["place_id"] ?? "",
        reference: json["reference"] ?? "",
        structuredFormatting:
            StructuredFormatting.fromJson(json["structured_formatting"]),
        terms: List<Term>.from(json["terms"].map((x) => Term.fromJson(x))),
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "matched_substrings":
            List<dynamic>.from(matchedSubstrings!.map((x) => x.toJson())),
        "place_id": placeId,
        "reference": reference,
        "structured_formatting": structuredFormatting!.toJson(),
        "terms": List<dynamic>.from(terms!.map((x) => x.toJson())),
        "types": List<dynamic>.from(types!.map((x) => x)),
      };
}

class MatchedSubstring {
  int length;
  int offset;

  MatchedSubstring({
    required this.length,
    required this.offset,
  });

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      MatchedSubstring(
        length: json["length"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "offset": offset,
      };
}

class StructuredFormatting {
  String mainText;
  List<MatchedSubstring> mainTextMatchedSubstrings;
  String secondaryText;

  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      StructuredFormatting(
        mainText: json["main_text"] ?? "",
        mainTextMatchedSubstrings: List<MatchedSubstring>.from(
            json["main_text_matched_substrings"]
                .map((x) => MatchedSubstring.fromJson(x))),
        secondaryText: json["secondary_text"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "main_text": mainText,
        "main_text_matched_substrings": List<dynamic>.from(
            mainTextMatchedSubstrings.map((x) => x.toJson())),
        "secondary_text": secondaryText,
      };
}

class Term {
  int offset;
  String value;

  Term({
    required this.offset,
    required this.value,
  });

  factory Term.fromJson(Map<String, dynamic> json) => Term(
        offset: json["offset"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "value": value,
      };
}

Location locationFromJson(String str) {
  final jsonData = json.decode(str);
  return Location.fromJson(jsonData);
}

String locationToJson(Location data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

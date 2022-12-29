// To parse this JSON data, do
//
//     final semModel = semModelFromJson(jsonString);

import 'dart:convert';

List<SemModel> semModelFromJson(String str) =>
    List<SemModel>.from(json.decode(str).map((x) => SemModel.fromJson(x)));

String semModelToJson(List<SemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SemModel {
  SemModel({
    required this.semId,
    required this.semName,
    required this.schemeId,
  });

  String semId;
  String semName;
  String schemeId;

  factory SemModel.fromJson(Map<String, dynamic> json) => SemModel(
        semId: json["sem_id"],
        semName: json["sem_name"],
        schemeId: json["scheme_id"],
      );

  Map<String, dynamic> toJson() => {
        "sem_id": semId,
        "sem_name": semName,
        "scheme_id": schemeId,
      };
}

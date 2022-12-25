// To parse this JSON data, do
//
//     final schemeModel = schemeModelFromJson(jsonString);

import 'dart:convert';

List<SchemeModel> schemeModelFromJson(String str) => List<SchemeModel>.from(
    json.decode(str).map((x) => SchemeModel.fromJson(x)));

String schemeModelToJson(List<SchemeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchemeModel {
  SchemeModel({
    required this.schemeId,
    required this.schemeName,
    required this.branchId,
    required this.downloadSchemeUrl,
    required this.downloadSyllabusUrl,
  });

  String schemeId;
  String schemeName;
  String branchId;
  String downloadSchemeUrl;
  String downloadSyllabusUrl;

  factory SchemeModel.fromJson(Map<String, dynamic> json) => SchemeModel(
        schemeId: json["scheme_id"],
        schemeName: json["scheme_name"],
        branchId: json["branch_id"],
        downloadSchemeUrl: json["download_ scheme_Url"],
        downloadSyllabusUrl: json["download_syllabus_url"],
      );

  Map<String, dynamic> toJson() => {
        "scheme_id": schemeId,
        "scheme_name": schemeName,
        "branch_id": branchId,
        "download_ scheme_Url": downloadSchemeUrl,
        "download_syllabus_url": downloadSyllabusUrl,
      };
}

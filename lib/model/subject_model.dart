// To parse this JSON data, do
//
//     final subModel = subModelFromJson(jsonString);

import 'dart:convert';

List<SubModel> subModelFromJson(String str) =>
    List<SubModel>.from(json.decode(str).map((x) => SubModel.fromJson(x)));

String subModelToJson(List<SubModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubModel {
  SubModel({
    required this.subId,
    required this.subCode,
    required this.subName,
    required this.semId,
  });

  String subId;
  String subCode;
  String subName;
  String semId;

  factory SubModel.fromJson(Map<dynamic, dynamic> json) => SubModel(
        subId: json["sub_id"],
        subCode: json["sub_code"],
        subName: json["sub_name"],
        semId: json["sem_id"],
      );

  Map<String, dynamic> toJson() => {
        "sub_id": subId,
        "sub_code": subCode,
        "sub_name": subName,
        "sem_id": semId,
      };
}

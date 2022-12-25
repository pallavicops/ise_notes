import 'dart:convert';

List<BranchModel> branchModelFromJson(String str) => List<BranchModel>.from(
    json.decode(str).map((x) => BranchModel.fromJson(x)));

String branchModelToJson(List<BranchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchModel {
  BranchModel({
    required this.branchId,
    required this.branchName,
  });

  String branchId;
  String branchName;

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        branchId: json["branch_id"],
        branchName: json["branch_name"],
      );

  Map<String, dynamic> toJson() => {
        "branch_id": branchId,
        "branch_name": branchName,
      };
}

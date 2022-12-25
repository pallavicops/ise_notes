import 'package:http/http.dart' as http;
import 'package:notes_management_system/model/branch_model.dart';

class BranchControl {
  Future<List<BranchModel>> getBranches() async {
    final response = await http.get(
      Uri.parse(
        "http://127.0.0.1:80/nms-server/api-branches.php",
      ),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return branchModelFromJson(response.body);
    } else {
      return [];
    }
  }
}

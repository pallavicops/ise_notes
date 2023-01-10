import 'package:http/http.dart ' as http;
import 'package:notes_management_system/model/scheme_model.dart';

class SchemeControl {
  Future<List<SchemeModel>> getSchemes(String branchId) async {
    final response = await http.get(
      Uri.parse(
        "http://127.0.0.1:80/nms-server/api/schemes.php?branch_id=$branchId",
      ),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return schemeModelFromJson(response.body);
    } else {
      return [];
    }
  }
}

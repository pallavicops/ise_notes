import 'package:http/http.dart' as http;
import 'package:notes_management_system/model/semester_model.dart';

class SemesterControl {
  Future<List<SemModel>> getSemesters(String schemeId) async {
    final response = await http.get(
      Uri.parse(
          "http://127.0.0.1:80/nms-server/api/semesters.php?scheme_id=$schemeId"),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return semModelFromJson(response.body);
    } else {
      return [];
    }
  }
}

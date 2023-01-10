import 'package:http/http.dart' as http;
import 'package:notes_management_system/model/subject_model.dart';

class SubjectControl {
  Future<List<SubModel>> getSubjects(String semId) async {
    final response = await http.get(Uri.parse(
        "http://127.0.0.1:80/nms-server/api/subjects.php?sem_id=$semId"));
    if (response.statusCode == 200) {
      print(response.body);
      return subModelFromJson(response.body);
    } else {
      return [];
    }
  }
}

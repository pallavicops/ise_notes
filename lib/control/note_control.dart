import 'package:http/http.dart' as http;

import '../model/note_model.dart';

class NoteControl {
  Future<List<NoteModel>> getNotes(String subCode) async {
    print("http://127.0.0.1:80/nms-server/api/notes.php?sub_code=$subCode");
    final response = await http.get(
      Uri.parse(
        "http://127.0.0.1:80/nms-server/api/notes.php?sub_code=$subCode",
      ),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return noteModelFromJson(response.body);
    } else {
      return [];
    }
  }
}

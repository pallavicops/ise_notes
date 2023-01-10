// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

import 'dart:convert';

List<NoteModel> noteModelFromJson(String str) => json.decode(str) == null
    ? []
    : List<NoteModel>.from(
        json.decode(str)!.map(
              (x) => NoteModel.fromJson(x),
            ),
      );

String noteModelToJson(List<NoteModel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class NoteModel {
  NoteModel({
    required this.noteId,
    required this.subCode,
    required this.title,
    required this.downloadNoteUrl,
    required this.authorName,
  });

  String? noteId;
  String? subCode;
  String? title;
  String? downloadNoteUrl;
  String? authorName;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        noteId: json["note_id"],
        subCode: json["sub_code"],
        title: json["title"],
        downloadNoteUrl: json["download_note_url"],
        authorName: json["author_name"],
      );

  Map<String, dynamic> toJson() => {
        "note_id": noteId,
        "sub_code": subCode,
        "title": title,
        "download_note_url": downloadNoteUrl,
        "author_name": authorName,
      };
}

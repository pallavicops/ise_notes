import 'package:flutter/material.dart';
import 'package:notes_management_system/control/note_control.dart';
import 'package:notes_management_system/model/note_model.dart';
import 'package:notes_management_system/model/subject_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    Key? key,
    required this.subject,
  }) : super(key: key);
  final SubModel subject;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late final SubModel subject;
  @override
  void initState() {
    subject = widget.subject;
    super.initState();
  }

  final NoteControl _noteControl = NoteControl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5F5),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              width: 245,
              height: 85,
              image: AssetImage("assets/logo.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              subject.subName,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            Text(
              '(${subject.subCode})',
              style: const TextStyle(fontSize: 30.0),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              color: Colors.black,
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<List<NoteModel>>(
                future: _noteControl.getNotes(subject.subCode),
                builder: (BuildContext context,
                    AsyncSnapshot<List<NoteModel>> snapshot) {
                  if (snapshot.hasData) {
                    final notes = snapshot.data!;
                    return ListView.separated(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notes.elementAt(index).title!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0)),
                                Text(
                                  'Author_name',
                                  style: const TextStyle(
                                      fontSize: 15.0, color: Colors.grey),
                                ),
                              ],
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                try {
                                  final uri = Uri.parse(
                                    notes.elementAt(index).downloadNoteUrl!,
                                  );
                                  launchUrl(uri);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('VIEW'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00194C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: Colors.black,
                          height: 30,
                          indent: 100,
                          endIndent: 100,
                          thickness: 1,
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:notes_management_system/control/semester_control.dart';
import 'package:notes_management_system/control/subject_control.dart';
import 'package:notes_management_system/model/scheme_model.dart';
import 'package:notes_management_system/model/semester_model.dart';
import 'package:notes_management_system/model/subject_model.dart';
import 'package:notes_management_system/view/notes_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../control/branch_control.dart';
import '../control/scheme_control.dart';
import '../model/branch_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final BranchControl _branchControl = BranchControl();
  final SchemeControl _schemeControl = SchemeControl();
  final SemesterControl _semesterControl = SemesterControl();
  final SubjectControl _subjectControl = SubjectControl();

  String? selectedBranchId;
  String? selectedSchemeId;
  List<SchemeModel> schemes = [];
  List<SemModel> semesters = [];
  String? selectedSemId;
  List<SubModel> subjects = [];
  String? selectedSubId;
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5F5),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Image(
                  width: 245,
                  height: 85,
                  image: AssetImage("assets/logo.png"),
                ),
                const SizedBox(
                  width: 180,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 505,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: TextFormField(
                    obscureText: false,
                    controller: _searchController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search by Subject Code(eg: 18CSL67)',
                      prefixIcon: const Icon(
                        Icons.subject,
                        color: Color(0xFF00194C),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (_searchController.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotePage(
                                  subject: SubModel(
                                    subCode: _searchController.text,
                                    subId: '',
                                    subName: '',
                                    semId: '',
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Color(0xFF00194C),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              child: FutureBuilder(
                future: _branchControl.getBranches(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<BranchModel>> snapshot) {
                  if (snapshot.hasData) {
                    final branches = snapshot.data!;
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                          onPressed: () {
                            selectedBranchId =
                                branches.elementAt(index).branchId;

                            // Other selection should return to default
                            selectedSubId = null;
                            selectedSchemeId = null;
                            selectedSemId = null;
                            setState(() {});
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              branches.elementAt(index).branchId ==
                                      selectedBranchId
                                  ? const Color(0xFF00194C)
                                  : Colors.grey,
                            ),
                            shape: const MaterialStatePropertyAll(
                              StadiumBorder(),
                            ),
                          ),
                          child: Text(
                            branches.elementAt(index).branchName,
                            style: const TextStyle().copyWith(
                              color: branches.elementAt(index).branchId ==
                                      selectedBranchId
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: branches.length,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: selectedBranchId != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select your Scheme",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future:
                          _schemeControl.getSchemes(selectedBranchId ?? '0'),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<SchemeModel>> snapshot) {
                        if (snapshot.hasData) {
                          schemes.clear();
                          schemes = snapshot.data!;
                          return Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: List.generate(
                              schemes.length,
                              (index) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: schemes.elementAt(index).schemeId ==
                                          selectedSchemeId
                                      ? const Color(0xFF00194C)
                                      : Colors.grey,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          selectedSchemeId =
                                              schemes.elementAt(index).schemeId;

                                          selectedSubId = null;
                                          selectedSemId = null;
                                          setState(() {});
                                        },
                                        child: Text(
                                          schemes.elementAt(index).schemeName,
                                          style: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold)
                                              .copyWith(
                                            color: schemes
                                                        .elementAt(index)
                                                        .schemeId ==
                                                    selectedSchemeId
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Visibility(
                                        visible: selectedSchemeId ==
                                            schemes.elementAt(index).schemeId,
                                        child: Column(
                                          children: [
                                            OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                shape: const StadiumBorder(),
                                                side: const BorderSide(
                                                    width: 2,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                try {
                                                  final uri = Uri.parse(
                                                    schemes
                                                        .elementAt(index)
                                                        .downloadSchemeUrl,
                                                  );
                                                  launchUrl(uri);
                                                } catch (e) {
                                                  print(e);
                                                }
                                              },
                                              child: const Text(
                                                'Download Scheme',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                shape: const StadiumBorder(),
                                                side: const BorderSide(
                                                    width: 2,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                try {
                                                  final uri = Uri.parse(
                                                    schemes
                                                        .elementAt(index)
                                                        .downloadSyllabusUrl,
                                                  );
                                                  launchUrl(uri);
                                                } catch (e) {
                                                  print(e);
                                                }
                                              },
                                              child: const Text(
                                                'Download Syllabus',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: selectedSchemeId != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select your Semester",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future:
                        _semesterControl.getSemesters(selectedSchemeId ?? '0'),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<SemModel>> snapshot) {
                      if (snapshot.hasData) {
                        semesters.clear();
                        semesters = snapshot.data!;
                        return Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: List.generate(
                            semesters.length,
                            (index) => ElevatedButton(
                              onPressed: () {
                                selectedSemId =
                                    semesters.elementAt(index).semId;
                                setState(() {});
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  semesters.elementAt(index).semId ==
                                          selectedSemId
                                      ? const Color(0xFF00194C)
                                      : Colors.grey,
                                ),
                                shape: const MaterialStatePropertyAll(
                                  StadiumBorder(),
                                ),
                              ),
                              child: Text(
                                semesters.elementAt(index).semName,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: selectedSemId != null,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select your Subject",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 250,
                      child: FutureBuilder(
                        future:
                            _subjectControl.getSubjects(selectedSemId ?? '0'),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<SubModel>> snapshot) {
                          if (snapshot.hasData) {
                            subjects.clear();
                            subjects = snapshot.data!;
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Wrap(
                                spacing: 20.0,
                                runSpacing: 20.0,
                                children: List.generate(
                                  subjects.length,
                                  (index) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NotePage(
                                            subject: subjects.elementAt(index),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color:
                                            subjects.elementAt(index).subId ==
                                                    selectedSubId
                                                ? const Color(0xFF00194C)
                                                : Colors.grey,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            subjects.elementAt(index).subCode,
                                            style: const TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold)
                                                .copyWith(
                                              color: subjects
                                                          .elementAt(index)
                                                          .subId ==
                                                      selectedSubId
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            subjects.elementAt(index).subName,
                                            style: const TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold)
                                                .copyWith(
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

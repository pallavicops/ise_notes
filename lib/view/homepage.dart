import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> branches = ['ISE', 'M-Tech'];
  String? selectedItem;
  int? selectedSchemeIndex;
  List<String> schemes = [];
  List<String> iseSchemes = ['2018-Scheme', '2021-Scheme'];
  List<String> mTechSchemes = ['MTech-2018-Scheme', 'MTech-2021-Scheme'];
  String? selectedSem;
  List<String> semesters = [
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th'
  ];
  List<String> subjects = [
    'First',
    'second',
    'Third',
    'Fourth',
    'Fifth',
    'Sixth',
    'Seventh',
    'Eight'
  ];

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
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      selectedItem = branches.elementAt(index);
                      if (selectedItem == 'ISE') {
                        schemes = iseSchemes;
                      } else if (selectedItem == 'M-Tech') {
                        schemes = mTechSchemes;
                      }
                      setState(() {});
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        branches.elementAt(index) == selectedItem
                            ? const Color(0xFF00194C)
                            : Colors.grey,
                      ),
                      shape: const MaterialStatePropertyAll(
                        StadiumBorder(),
                      ),
                    ),
                    child: Text(
                      branches.elementAt(index),
                      style: const TextStyle().copyWith(
                        color: branches.elementAt(index) == selectedItem
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
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: selectedItem != null,
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
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(
                      schemes.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: index == selectedSchemeIndex
                              ? const Color(0xFF00194C)
                              : Colors.grey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  selectedSchemeIndex = index;
                                  setState(() {});
                                },
                                child: Text(
                                  schemes.elementAt(index),
                                  style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)
                                      .copyWith(
                                    color: index == selectedSchemeIndex
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Visibility(
                                visible: selectedSchemeIndex == index,
                                child: Column(
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        side: const BorderSide(
                                            width: 2, color: Colors.white),
                                      ),
                                      onPressed: () {},
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
                                            width: 2, color: Colors.white),
                                      ),
                                      onPressed: () {},
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
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: selectedSchemeIndex != null,
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
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(
                      semesters.length,
                      (index) => ElevatedButton(
                        onPressed: () {
                          selectedSem = semesters.elementAt(index);
                          setState(() {});
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            semesters.elementAt(index) == selectedSem
                                ? const Color(0xFF00194C)
                                : Colors.grey,
                          ),
                          shape: const MaterialStatePropertyAll(
                            StadiumBorder(),
                          ),
                        ),
                        child: Text(
                          semesters.elementAt(index),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: List.generate(
                  subjects.length,
                  (index) => Container(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(subjects.elementAt(index)),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }

  schemasBasedOnSelectedBranch() {}
}

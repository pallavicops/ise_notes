import 'package:flutter/material.dart';
import 'package:ise_notes/view/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ISE_NOTES',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: Homepage(),
    );
  }
}

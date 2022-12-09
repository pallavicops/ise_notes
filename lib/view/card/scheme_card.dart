import 'package:flutter/material.dart';

class SchemeCard extends StatefulWidget {
  const SchemeCard({Key? key}) : super(key: key);

  @override
  State<SchemeCard> createState() => _SchemeCardState();
}

class _SchemeCardState extends State<SchemeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Text('2018\nScheme'),
          ),
          Container(
            child: Text('2021\nScheme'),
          )
        ],
      ),
    );
  }
}

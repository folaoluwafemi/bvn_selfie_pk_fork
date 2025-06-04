import 'dart:io';

import 'package:flutter/material.dart';

class ShowResult extends StatefulWidget {
  final String path;
  const ShowResult({super.key, required this.path});

  @override
  State<ShowResult> createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Image.file(File(widget.path))]),
    );
  }
}

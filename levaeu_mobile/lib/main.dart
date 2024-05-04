import 'package:flutter/material.dart';
import 'package:levaeu_mobile/ui/home.dart';

void main() {
  runApp(MaterialApp(
    title: "LevaEu",
    home: Home(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(57, 96, 143, 0)),
      useMaterial3: true,
    ),
  ));
}

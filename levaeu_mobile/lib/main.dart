import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/start.dart';

void main() {
  runApp(MaterialApp(
    title: "LevaEu",
    home: Start(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(57, 96, 143, 0)),
      scaffoldBackgroundColor: const Color.fromRGBO(184, 184, 184, 1),
      fontFamily: 'Roboto',
      useMaterial3: true,
    ),
  ));
}

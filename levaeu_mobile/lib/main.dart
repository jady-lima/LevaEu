import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/home.dart';
import 'package:levaeu_mobile/screens/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LevaEu",
      //home: Start(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(57, 96, 143, 0)),
        scaffoldBackgroundColor: const Color.fromRGBO(184, 184, 184, 1),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => const Start(),
        '/home': (context) => const Home(),
      },
    );
  }
}

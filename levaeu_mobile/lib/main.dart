import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/userData.dart';
import 'package:levaeu_mobile/screens/navigation/home_state.dart';
import 'package:levaeu_mobile/screens/navigation/settings/profile.dart';
import 'package:levaeu_mobile/screens/register/registration.dart';
import 'package:levaeu_mobile/screens/start.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData()),
      ],
      child: MyApp()
  ));
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
        scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 247, 1),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      initialRoute: '/userRegistration',
      routes: {
        '/': (context) => const Start(),
        '/home': (context) => const HomeState(),
        '/profile': (context) => const Profile(),
        '/userRegistration': (context) => const Registration(),
      },
    );
  }
}

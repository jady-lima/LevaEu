import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:levaeu_mobile/controllers/race_controller.dart';
import 'package:levaeu_mobile/model/driver_car.dart';
import 'package:levaeu_mobile/model/driver_license.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/screens/navigation/chats/chats.dart';
import 'package:levaeu_mobile/screens/navigation/home_state.dart';
import 'package:levaeu_mobile/screens/navigation/settings/profile.dart';
import 'package:levaeu_mobile/screens/register/registration.dart';
import 'package:levaeu_mobile/screens/start.dart';
import 'package:provider/provider.dart';

void main()  async{
  await dotenv.load(fileName:"lib/.env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData()),
        ChangeNotifierProvider(create: (_) => DriverLicense()),
        ChangeNotifierProvider(create: (_) => DriverCar()),
        ChangeNotifierProvider(create: (_) => RaceController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LevaEu",
      //home: Start(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(57, 96, 143, 0)),
        scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 247, 1),
        fontFamily: 'Roboto',
        useMaterial3: true,
        
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Start(),
        '/home': (context) => const HomeState(),
        '/profile': (context) => const Profile(),
        '/userRegistration': (context) => const Registration(),
        '/chats': (context) => const Chats(),
      },
    );
  }
}

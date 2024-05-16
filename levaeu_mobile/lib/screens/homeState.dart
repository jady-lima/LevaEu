import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/chats.dart';
import 'package:levaeu_mobile/screens/homeContent.dart';
import 'package:levaeu_mobile/screens/myRaces.dart';
import 'package:levaeu_mobile/screens/newRace.dart';
import 'package:levaeu_mobile/screens/settings.dart';
import 'package:levaeu_mobile/utils/drawer_menu.dart';
import 'package:levaeu_mobile/utils/navigation_bar_menu.dart';

class HomeState extends StatefulWidget {
  const HomeState({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeState> {
  final List<GlobalKey<NavigatorState>> _screensKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        iconTheme: const IconThemeData(color: Color.fromRGBO(255, 255, 255, 1.0)),
      ),
      drawer: DrawerMenu.buildDrawerMenu(context),
      bottomNavigationBar: NavigationBarMenu(
        initialIndex: 0,
        onItemTapped: _onItemTapped,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Navigator(
      key: _screensKeys[_selectedIndex],
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => [
              HomeContent(),
              Chats(),
              NewRace(),
              MyRaces(),
              Settings(),
            ][_selectedIndex];
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

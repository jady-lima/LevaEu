import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/navigation/chats/chats.dart';
import 'package:levaeu_mobile/screens/navigation/home/home_content.dart';
import 'package:levaeu_mobile/screens/navigation/history/my_races.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/new_race.dart';
import 'package:levaeu_mobile/screens/navigation/settings/settings.dart';
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
      body: Container(
        child: _buildBody(),
        color: Theme.of(context).colorScheme.onInverseSurface,
      ),
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
              const HomeContent(),
              const Chats(),
              const NewRace(),
              const MyRaces(),
              const Settings(),
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

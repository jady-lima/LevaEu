import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/userData.dart';
import 'package:levaeu_mobile/screens/navigation/chats/chats.dart';
import 'package:levaeu_mobile/screens/navigation/home/home_content.dart';
import 'package:levaeu_mobile/screens/navigation/history/my_races.dart';
import 'package:levaeu_mobile/screens/navigation/new_races/new_race.dart';
import 'package:levaeu_mobile/screens/navigation/settings/settings.dart';
import 'package:levaeu_mobile/utils/drawer_menu.dart';
import 'package:levaeu_mobile/utils/navigation_bar_menu.dart';
import 'package:provider/provider.dart';

class HomeState extends StatefulWidget {
  const HomeState({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeState> {
   int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeContent(onItemTapped: _onItemTapped), //0
      const Chats(), //1
      const NewRace(), //2
      const MyRaces(), //3
      const Settings(), //4
    ];
  
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        iconTheme: const IconThemeData(color: Color.fromRGBO(255, 255, 255, 1.0)),
      ),
      drawer: DrawerMenu.buildDrawerMenu(context),
      bottomNavigationBar: NavigationBarMenu(
        initialIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body:IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ), 
    );
  }
}

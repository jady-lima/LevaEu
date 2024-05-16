import 'package:flutter/material.dart';
import 'package:levaeu_mobile/utils/drawer_menu.dart';

class Settings extends StatefulWidget{
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          
          Container(
            height: 200,
            color: Colors.yellow,
            child: Center(child: Text('Tela de configurações')),
          ),

        ],
      ),
    );
  }
}
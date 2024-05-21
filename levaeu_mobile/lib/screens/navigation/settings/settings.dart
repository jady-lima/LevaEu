import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/login/login.dart';
import 'package:levaeu_mobile/screens/navigation/settings/help.dart';
import 'package:levaeu_mobile/screens/navigation/settings/payment/payment_screen.dart';
import 'package:levaeu_mobile/screens/navigation/settings/profile.dart';
import 'package:levaeu_mobile/screens/navigation/settings/security/security_screen.dart';
import 'package:levaeu_mobile/screens/navigation/settings/share.dart';
import 'package:levaeu_mobile/utils/elevated_buttons.dart';

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
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(
              Icons.person_sharp, 
              "Minha conta", 
              context, 
              () => const Profile(), 
              rootNavigator: true
            ),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(
              Icons.security, 
              "Segurança", 
              context, 
              () => const Security(), 
              rootNavigator: true
            ),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(
              Icons.pix, 
              "Formas de pagamento", 
              context, 
              () => const Payment(), 
              rootNavigator: true
            ),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(
              Icons.supervised_user_circle, 
              "Indique um amigo", 
              context, 
              () => const Share(), 
              rootNavigator: true
            ),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(
              Icons.help, 
              "Suporte", 
              context, 
              () => const Help(), 
              rootNavigator: true 
            ),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(
              Icons.exit_to_app, 
              "Sair", 
              context, 
              () => const Login(), 
              rootNavigator: true
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/login/login.dart';
import 'package:levaeu_mobile/screens/navigation/settings/help.dart';
import 'package:levaeu_mobile/screens/navigation/settings/payment.dart';
import 'package:levaeu_mobile/screens/navigation/settings/profile.dart';
import 'package:levaeu_mobile/screens/navigation/settings/security.dart';
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
            child: ElevatedButtonsForms.buildElevatedButtonIcon(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 100, Icons.person_sharp, "Minha conta", context, const Profile()),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 100, Icons.security, "Segurança", context, const Security()),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 100, Icons.pix, "Formas de pagamento", context, const Payment()),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 100, Icons.supervised_user_circle, "Indique um amigo", context, const Security()),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 100, Icons.help, "Suporte", context, const Help()),
          ),

          Container(
            constraints: const BoxConstraints(maxWidth: 380, minWidth: 200, maxHeight: 100, minHeight: 50),
            alignment: Alignment.center,
            child: ElevatedButtonsForms.buildElevatedButtonIcon(Colors.white, const Color.fromRGBO(90, 90, 90, 1.0), const Color.fromRGBO(196, 198, 208, 1.0), 100, Icons.exit_to_app, "Sair", context, const Login()),
          ),
        ],
      ),
    );
  }
}
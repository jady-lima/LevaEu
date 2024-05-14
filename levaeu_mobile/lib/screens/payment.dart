import 'package:flutter/material.dart';
import 'package:levaeu_mobile/utils/drawer_menu.dart';

class Payment extends StatefulWidget{
  const Payment({super.key});

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(184, 184, 184, 0),
        iconTheme: const IconThemeData(color: Color.fromRGBO(57, 96, 143, 1.0)),
      ),

      //Menu lateral
      drawer: DrawerMenu.buildDrawerMenu(context),

      body: const Text("Tela de Pagamento"),
    );
  }
}
import 'package:flutter/material.dart';

class Money extends StatefulWidget {
  const Money({super.key});

  @override
  _MoneyState createState() => _MoneyState();
}

class _MoneyState extends State<Money> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Dinheiro",
          style: TextStyle(color: Colors.white),
        ),
      ),
      
      body: const Text("Tela de dinheiro"),
    );
  }
}

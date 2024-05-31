import 'package:flutter/material.dart';

class Share extends StatefulWidget {
  const Share({Key? key}) : super(key: key);

  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Indique um amigo",
          style: TextStyle(color: Colors.white),
        ),
      ),
      
      
      body: Container(
        constraints: const BoxConstraints(maxWidth: 300, minWidth: 240),
        margin: const EdgeInsets.all(30),
        alignment: Alignment.topCenter,
        child: const Text(
          "Segue o link de compatilhamento: ",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
      ),

    );
  }
}

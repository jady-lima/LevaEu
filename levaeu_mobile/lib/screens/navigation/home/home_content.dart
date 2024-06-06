import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/utils/titles_screens.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatefulWidget {
  final Function(int) onItemTapped;

  const HomeContent({Key? key, required this.onItemTapped}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            constraints: const BoxConstraints(maxWidth: 300, minWidth: 240),
            margin: const EdgeInsets.only(top: 20, left: 25, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              "Olá, ${userData.name}!",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color.fromRGBO(0, 0, 0, 1),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            constraints: const BoxConstraints(maxWidth: 350, minWidth: 240),
            color: Colors.black,
            width: 350,
            height: 0.8,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            constraints: const BoxConstraints(maxWidth: 350, minWidth: 240),
            child: TitlesScreens.buildHomeMainTitle("Corrida marcada: "),
          ),
          const Center(
            child: Card(
              color: Colors.white,
              child: SizedBox(
                width: 350,
                height: 100,
                child: Center(
                  child: Text(
                    "Sem corridas até o momento",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            constraints: const BoxConstraints(maxWidth: 350, minWidth: 240),
            child: TitlesScreens.buildHomeMainTitle("Saindo logo: "),
          ),
          Center(
            child: Card(
              color: Colors.white,
              child: SizedBox(
                width: 350,
                height: 175,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.car_crash_rounded),
                      title: const Text('Tempo: 5 min. \nPara: Ponta Negra'),
                      subtitle: const Text('Motorista 1'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onTap: () {
                        widget.onItemTapped(2);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.car_crash_rounded),
                      title: const Text('Tempo: 8 min. \nPara: Parnamirim'),
                      subtitle: const Text('Motorista 2'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onTap: () {
                        widget.onItemTapped(2);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
            padding: const EdgeInsets.only(left: 10),
            constraints: const BoxConstraints(maxWidth: 350, minWidth: 240),
            child: TitlesScreens.buildHomeMainTitle("Discussões recentes: "),
          ),
          Center(
            child: Card(
              color: Colors.white,
              child: SizedBox(
                width: 350,
                height: 150,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.car_crash_rounded),
                      title: const Text('Buscando carona para N34'),
                      subtitle: const Text('Aluna 1'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onTap: () {
                        widget.onItemTapped(1);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.car_crash_rounded),
                      title: const Text('Tenho 3 vagas para o M12'),
                      subtitle: const Text('Motorista 3'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      onTap: () {
                        widget.onItemTapped(1);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

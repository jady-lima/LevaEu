import 'package:flutter/material.dart';

class NavigationBarMenu extends StatefulWidget {
  final int initialIndex;
  final Function(int) onItemTapped;

  const NavigationBarMenu({
    super.key,
    required this.initialIndex,
    required this.onItemTapped,
  });

  @override
  _NavigationBarMenuState createState() => _NavigationBarMenuState();
}

class _NavigationBarMenuState extends State<NavigationBarMenu> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Color.fromRGBO(57, 96, 143, 1.0),
          ),
          label: 'Home',
        ),
        /*
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_bubble,
            color: Color.fromRGBO(57, 96, 143, 1.0),
          ),
          label: 'Fóruns',
        ),*/
        BottomNavigationBarItem(
          icon: Icon(
            Icons.drive_eta,
            color: Color.fromRGBO(57, 96, 143, 1.0),
          ),
          label: 'Corridas',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
            color: Color.fromRGBO(57, 96, 143, 1.0),
          ),
          label: 'Histórico',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Color.fromRGBO(57, 96, 143, 1.0),
          ),
          label: 'Confi.',
        ),
      ],
    );
  }
}

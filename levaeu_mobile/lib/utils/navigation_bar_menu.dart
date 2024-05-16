import 'package:flutter/material.dart';

class NavigationBarMenu extends StatefulWidget {
  final int initialIndex;
  final Function(int) onItemTapped;

  const NavigationBarMenu({
    Key? key,
    required this.initialIndex,
    required this.onItemTapped,
  }) : super(key: key);

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
          icon: Text('Home'),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Text('Fóruns'),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Text('Corrida'),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Text('Histórico'),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Text('Confi.'),
          label: '',
        ),
      ],
    );
  }
}

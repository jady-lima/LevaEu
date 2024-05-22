import 'package:flutter/material.dart';

class Chats extends StatefulWidget{
  const Chats({super.key});

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final List<Map<String, String>> discussions = [
    {'title': 'Buscando caronas para 35T56', 'author': 'Edvaldo Silva'},
    {'title': 'Alguém saindo de PN de seg a qui?', 'author': 'César Silvirino'},
    // Add more discussions as needed
  ];
  
  get itemBuilder => null;

  void _openNewDiscussion() {
    // Handle opening a new discussion (e.g., navigate to a new screen)
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: discussions.length,
            itemBuilder: (context, index) {
              final discussion = discussions[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(discussion['title']!),
                  subtitle: Text('Autor: ${discussion['author']}'),
                  onTap: () {
                    // Handle opening the discussion (e.g., navigate to a new screen)
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: _openNewDiscussion,
            icon: Icon(Icons.add),
            label: Text('Abrir nova discussão'),
          ),
        ),
      ],
    );
  }
}
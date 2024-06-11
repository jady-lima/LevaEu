import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:intl/intl.dart';

class ParticipantsList extends StatelessWidget {
  final String title;
  final String author;
  final DateTime createdAt;
  final List<types.User> participants;

  const ParticipantsList({super.key, 
    required this.title,
    required this.author,
    required this.createdAt,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy - HH:mm').format(createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Participantes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Título: $title',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Autor: $author',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Criado em: $formattedDate',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Participantes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: participants.length,
                itemBuilder: (context, index) {
                  final participant = participants[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(participant.firstName![0]), // Placeholder para avatar
                    ),
                    title: Text(participant.firstName!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

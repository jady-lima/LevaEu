import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:levaeu_mobile/screens/navigation/chats/participantsList.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String author;
  final DateTime createdAt;

  ChatPage({required this.title, required this.author, required this.createdAt});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = types.User(id: 'user-id', firstName: 'Current User');
  final _otherUser = types.User(id: 'other-user-id', firstName: 'Other User');
  final _anotherUser = types.User(id: 'another-user-id', firstName: 'Another User');


  @override
  void initState() {
    super.initState();
    _loadMockMessages();
  }

  void _loadMockMessages() {
    setState(() {
      _messages = [
        types.TextMessage(
          author: _anotherUser,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: Uuid().v4(),
          text: 'Não quero muita conversa com vcs não e.e',
        ),
        types.TextMessage(
          author: _user,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: Uuid().v4(),
          text: 'Estou bem, obrigado!',
        ),
        types.TextMessage(
          author: _otherUser,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: Uuid().v4(),
          text: 'Olá, como você está?',
        ),
      ];
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });
  }

  void _openParticipantsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParticipantsList(
          title: widget.title,
          author: widget.author,
          createdAt: widget.createdAt,
          participants: [_user, _otherUser, _anotherUser],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _openParticipantsPage,
          ),
        ],
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
        showUserAvatars: true,
        showUserNames: true,
      ),
    );
  }
}

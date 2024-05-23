import 'package:flutter/material.dart';
import 'package:levaeu_mobile/screens/navigation/chats/chat_page.dart';

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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: NewDiscussionForm(
            onCreate: (title, author) {
              setState(() {
                discussions.add({'title': title, 'author': author});
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  void _openChatPage(String title, String author) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(title: title, author: author),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Discussões abertas',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
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
                    _openChatPage(discussion['title']!, discussion['author']!);
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


class NewDiscussionForm extends StatefulWidget {
  final void Function(String title, String author) onCreate;

  NewDiscussionForm({required this.onCreate});

  @override
  _NewDiscussionFormState createState() => _NewDiscussionFormState();
}

class _NewDiscussionFormState extends State<NewDiscussionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onCreate(_titleController.text, _authorController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Autor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o autor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Criar Discussão'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

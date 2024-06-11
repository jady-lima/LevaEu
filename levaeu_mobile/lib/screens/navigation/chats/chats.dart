import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/screens/navigation/chats/chat_page.dart';
import 'package:provider/provider.dart';

class Chats extends StatefulWidget{
  const Chats({super.key});

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  final List<Map<String, dynamic>> discussions = [
    {'title': 'Buscando caronas para 35T56', 'author': 'Edvaldo Silva', 'createdAt': DateTime.now().subtract(Duration(days: 1))},
    {'title': 'Alguém saindo de PN de seg a qui?', 'author': 'César Silvirino', 'createdAt': DateTime.now().subtract(Duration(days: 2))},
    // Add more discussions as needed
  ];
  

  void _openNewDiscussion(String author) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: NewDiscussionForm(
            onCreate: (title) {
              setState(() {
                discussions.add({
                  'title': title,
                  'author': author,
                  'createdAt': DateTime.now(),
                });
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  void _openChatPage(Map<String, dynamic> discussion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          title: discussion['title'],
          author: discussion['author'],
          createdAt: discussion['createdAt'],),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

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

              return Container(
                width: MediaQuery.of(context).size.width * 0.5,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    trailing: const CircleAvatar(
                      backgroundColor: Color.fromRGBO(57, 96, 143, 1.0),
                      child: Icon(
                        Icons.message_outlined,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(discussion['title']!),
                    subtitle: Text('Autor: ${discussion['author']}'),
                    onTap: () {
                      _openChatPage(discussion);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Builder(
            builder: (context) {
              return ElevatedButton.icon(
                onPressed: () => _openNewDiscussion(userData.name),
                icon: Icon(Icons.add),
                label: Text('Abrir nova discussão'),
              );
            },
          )
        ),
      ],
    );
  }
}


class NewDiscussionForm extends StatefulWidget {
  final void Function(String title) onCreate;

  NewDiscussionForm({required this.onCreate});

  @override
  _NewDiscussionFormState createState() => _NewDiscussionFormState();
}

class _NewDiscussionFormState extends State<NewDiscussionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  //final _authorController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    //_authorController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onCreate(_titleController.text);
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
              // TextFormField(
              // controller: _authorController,
              // decoration: InputDecoration(labelText: 'Autor'),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Por favor, insira um autor';
              //   }
              //   return null;
              // },
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

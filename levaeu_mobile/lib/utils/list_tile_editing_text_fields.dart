import 'package:flutter/material.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';

class ListTileEditingTextField extends StatefulWidget {
  final String title;
  final String user;
  final TextEditingController controller;
  final Function(String) function;
  final TextInputType inputType;
  final ValidationType validationType;

  const ListTileEditingTextField({
    super.key,
    required this.title,
    required this.user,
    required this.controller,
    required this.function,
    required this.inputType,
    required this.validationType,
  });

  @override
  _ListTileEditingTextFieldState createState() => _ListTileEditingTextFieldState();
}

class _ListTileEditingTextFieldState extends State<ListTileEditingTextField> {
  bool _isEditing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      setState(() {
        _isEditing = false;
        widget.function(widget.controller.text);
      });
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      subtitle: Form(
        key: _formKey,
        child: _isEditing
            ? TextFieldsForms.buildTextFormField(
                widget.title,
                widget.inputType,
                widget.controller,
                false,
                widget.validationType,
                (value) => widget.controller.text = value ?? '',
              )
            : Text(widget.controller.text),
      ),
      trailing: _isEditing
          ? TextButton(
              onPressed: _submit,
              child: const Text('Salvar'),
            )
          : IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _toggleEditing,
            ),
    );
  }
}

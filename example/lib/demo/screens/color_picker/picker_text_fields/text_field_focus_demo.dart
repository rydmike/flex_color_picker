import 'package:flutter/material.dart';

class TextFieldFocusDemo extends StatefulWidget {
  const TextFieldFocusDemo({Key? key}) : super(key: key);

  @override
  State<TextFieldFocusDemo> createState() => _TextFieldFocusDemoState();
}

class _TextFieldFocusDemoState extends State<TextFieldFocusDemo> {
  late TextEditingController _textController;
  bool _errorState = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const ListTile(
          title: Text('Demo of picker auto focus setting'),
          subtitle: Text('If picker auto focus is OFF or if neither keyboard '
              'copy-paste shortcut is enabled, this field will be autofocus in '
              'this demo. To try it, change settings, go back to main screen '
              'and come back to this screen, to see the focus result.'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: TextField(
            autofocus: true,
            onChanged: (String text) {
              setState(() {
                if (text.contains('a') | text.isEmpty) {
                  _errorState = false;
                } else {
                  _errorState = true;
                }
              });
            },
            controller: _textController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'If Picker autofocus is OFF field will have focus',
              labelText: 'Focus demo entry',
              errorText: _errorState
                  ? "Any entry without an 'a' will trigger this error"
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

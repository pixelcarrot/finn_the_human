import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  const InputDialog({
    Key? key,
    required this.title,
    required this.hint,
    required this.onOkPressed,
    required this.onCancelPressed,
  }) : super(key: key);

  final String title;
  final String hint;
  final Function onOkPressed;
  final Function onCancelPressed;

  @override
  State<StatefulWidget> createState() => _InputDialogImpl();
}

class _InputDialogImpl extends State<InputDialog> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        onChanged: (value) {
          setState(() {
            _text = value;
          });
        },
        decoration: InputDecoration(hintText: widget.hint),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            widget.onCancelPressed();
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            widget.onOkPressed(_text);
          },
        ),
      ],
    );
  }
}

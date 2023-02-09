import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  final Color? color;
  const ErrorDialog({
    Key? key,
    required this.message,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xff6655D6),
          ),
          child: const Center(child: Text("OK")),
        ),
      ],
    );
  }
}

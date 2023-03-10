import 'package:flutter/material.dart';

import '../theme/gradient_theme.dart';

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
      content: Text(
        message,
        style: kBodyText3Style().copyWith(color: blackColor),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xff6655D6),
          ),
          child: Center(
              child: Text(
            "OK",
            style: kBodyText3Style(),
          )),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

circularProgress() {
  return Container(
    padding: const EdgeInsets.only(top: 12.0),
    alignment: Alignment.center,
    child: const CircularProgressIndicator(
      backgroundColor: Colors.green,
      color: Colors.white,
    ),
  );
}

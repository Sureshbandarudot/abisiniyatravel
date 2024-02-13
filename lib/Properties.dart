import 'package:flutter/material.dart';
//add new code
class ScreenB extends StatelessWidget {
  const ScreenB({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Screen B',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class FlightScreen extends StatelessWidget {
  const FlightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Flights Screen',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
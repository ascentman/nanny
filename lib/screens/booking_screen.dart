import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  static String id = 'booking';

  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Підвердження бронювання'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

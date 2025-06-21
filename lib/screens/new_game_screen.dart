// lib/screens/game_screen.dart
import 'package:flutter/material.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Text(
          'New Game Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
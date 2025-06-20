// lib/screens/game_screen.dart
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Game Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
// lib/screens/statistics_screen.dart
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Statistics Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
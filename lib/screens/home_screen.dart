
import 'package:dartly/screens/game_screen.dart';
import 'package:dartly/screens/new_game_screen.dart';
import 'package:dartly/screens/settings_screen.dart';
import 'package:dartly/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import '../models/game_settings.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selected_index = 1;
  void _navigateBottombar(int selected_index){
    setState(() {
      _selected_index = selected_index;
    });
  }

  final List sites = [
    StatisticsScreen(),
    NewGameScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body: sites[_selected_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selected_index,
          onTap: _navigateBottombar,
          items: [
            //stats
            BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart), label: "Stats"),
            //play
            BottomNavigationBarItem(icon: Icon(Icons.games), label: "Play",),
            //settings
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          ]),
    );
  }
}
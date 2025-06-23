// lib/screens/game_screen.dart
import 'package:dartly/utils/constants.dart';
import 'package:flutter/material.dart';

enum GameMode { x01, cricket }
enum X01OutMode { straight, double, master }

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  _NewGameScreenState createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  GameMode selectedGameMode = GameMode.x01;
  int selectedStartingScore = 501;
  X01OutMode selectedOutMode = X01OutMode.double;
  List<String> players = ['Player 1', 'Player 2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.vintageBeige,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Game Mode Selection
              _buildGameModeSection(),

              SizedBox(height: AppConstants.largePadding),

              // Game Settings
              _buildGameSettingsSection(),

              SizedBox(height: AppConstants.largePadding),

              // Player Selection
              _buildPlayerSection(),

              SizedBox(height: AppConstants.largePadding * 2),

              // Start Game Button
              _buildStartGameButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameModeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Game Mode',
        ),
        SizedBox(height: AppConstants.smallPadding),
        Row(
          children: [
            Expanded(
              child: _buildGameModeCard(
                GameMode.x01,
                'X01',
                'Classic 301, 501, etc.',
                Icons.adjust,
              ),
            ),
            SizedBox(width: AppConstants.smallPadding),
            Expanded(
              child: _buildGameModeCard(
                GameMode.cricket,
                'Cricket',
                'Hit numbers 20, 19, 18...',
                Icons.sports,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGameModeCard(GameMode mode, String title, String subtitle, IconData icon) {
    bool isSelected = selectedGameMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGameMode = mode;
        });
      },
      child: Container(
        padding: EdgeInsets.all(AppConstants.defaultPadding),
        decoration: BoxDecoration(
          color: isSelected ? AppConstants.vintageGreenLight : AppConstants.vintageWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppConstants.vintageGreen : AppConstants.vintageGreenLighter,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? AppConstants.vintageWhite : AppConstants.vintageGreen,
            ),
            SizedBox(height: AppConstants.smallPadding),
            Text(
              title,
            ),
            SizedBox(height: AppConstants.tinyPadding),
            Text(
              subtitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Game Settings',
        ),
        SizedBox(height: AppConstants.smallPadding),
        if (selectedGameMode == GameMode.x01) _buildX01Settings(),
        if (selectedGameMode == GameMode.cricket) _buildCricketSettings(),
      ],
    );
  }

  Widget _buildX01Settings() {
    return Container(
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppConstants.vintageWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppConstants.vintageGreenLighter),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Starting Score',

          ),
          SizedBox(height: AppConstants.smallPadding),
          Wrap(
            spacing: AppConstants.smallPadding,
            children: AppConstants.commonStartingScores.map((score) {
              bool isSelected = selectedStartingScore == score;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedStartingScore = score;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding,
                    vertical: AppConstants.smallPadding,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppConstants.vintageGreen : AppConstants.vintageBeige,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppConstants.vintageGreen,
                    ),
                  ),
                  child: Text(
                    score.toString(),

                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: AppConstants.defaultPadding),
          Text(
            'Out Mode',

          ),
          SizedBox(height: AppConstants.smallPadding),
          Row(
            children: X01OutMode.values.map((mode) {
              bool isSelected = selectedOutMode == mode;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOutMode = mode;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: AppConstants.smallPadding),
                    padding: EdgeInsets.symmetric(vertical: AppConstants.smallPadding),
                    decoration: BoxDecoration(
                      color: isSelected ? AppConstants.vintageGreen : AppConstants.vintageBeige,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppConstants.vintageGreen),
                    ),
                    child: Text(
                      mode.name.toUpperCase(),
                      textAlign: TextAlign.center,

                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCricketSettings() {
    return Container(
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppConstants.vintageWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppConstants.vintageGreenLighter),
      ),
      child: Text(
        'Standard Cricket rules: Hit 20, 19, 18, 17, 16, 15, and Bull',

      ),
    );
  }

  Widget _buildPlayerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Players (${players.length})',

            ),
            Row(
              children: [
                IconButton(
                  onPressed: players.length > AppConstants.minPlayers
                      ? () {
                    setState(() {
                      players.removeLast();
                    });
                  }
                      : null,
                  icon: Icon(
                    Icons.remove_circle,
                    color: players.length > AppConstants.minPlayers
                        ? AppConstants.vintageAccent
                        : AppConstants.vintageGreenLighter,
                  ),
                ),
                IconButton(
                  onPressed: players.length < AppConstants.maxPlayers
                      ? () {
                    setState(() {
                      players.add('Player ${players.length + 1}');
                    });
                  }
                      : null,
                  icon: Icon(
                    Icons.add_circle,
                    color: players.length < AppConstants.maxPlayers
                        ? AppConstants.vintageAccent
                        : AppConstants.vintageGreenLighter,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: AppConstants.smallPadding),
        Container(
          padding: EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: AppConstants.vintageWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppConstants.vintageGreenLighter),
          ),
          child: Column(
            children: players.asMap().entries.map((entry) {
              int index = entry.key;
              String player = entry.value;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < players.length - 1 ? AppConstants.smallPadding : 0,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppConstants.vintageGreen,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',

                        ),
                      ),
                    ),
                    SizedBox(width: AppConstants.defaultPadding),
                    Expanded(
                      child: TextFormField(
                        initialValue: player,
                        onChanged: (value) {
                          setState(() {
                            players[index] = value.isEmpty ? 'Player ${index + 1}' : value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppConstants.vintageGreenLighter),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppConstants.vintageGreen, width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.defaultPadding,
                            vertical: AppConstants.smallPadding,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildStartGameButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _startGame,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.vintageAccent,
          foregroundColor: AppConstants.vintageWhite,
          padding: EdgeInsets.symmetric(vertical: AppConstants.defaultPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Start Game',
        ),
      ),
    );
  }

  void _startGame() {
    // TODO: Navigate to game screen with selected settings
    print('Starting game:');
    print('Mode: $selectedGameMode');
    if (selectedGameMode == GameMode.x01) {
      print('Starting Score: $selectedStartingScore');
      print('Out Mode: $selectedOutMode');
    }
    print('Players: $players');
  }
}
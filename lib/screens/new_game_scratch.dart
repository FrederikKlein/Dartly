import 'package:dartly/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum GameMode { x01, cricket }
enum X01OutMode { straight, double, triple }
enum X01InMode { straight, double, triple}
var currentMode = GameMode.x01; // Default mode

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  _NewGameScreenState createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.vintageWhite,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.appPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTitleSection(),

              SizedBox(height: AppConstants.defaultPadding),
              // Game Mode Selection
              _buildGameModeSection(),

              SizedBox(height: AppConstants.defaultPadding),

              // Game Settings
              _buildGameOptionsSection(),

              SizedBox(height: AppConstants.defaultPadding),

              // Player Selection
              _buildPlayerSection(),

              SizedBox(height: AppConstants.defaultPadding),

              // Start Game Button
              _buildStartGameButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection(){
    return Text("New Game", style: AppConstants.headingStyle);
  }
  Widget _buildGameModeSection(){
    var _segmentsMap = <GameMode, Widget>{
      GameMode.x01: Text("X01", style: AppConstants.buttonTextStyle),
      GameMode.cricket: Padding(child: Text("Cricket", style: AppConstants.buttonTextStyle), padding: EdgeInsetsGeometry.symmetric(vertical: AppConstants.verySmallPadding)),
    };
    return Container(
      width: double.infinity, // Make it full width
      child: CupertinoSegmentedControl<GameMode>(
        children: _segmentsMap,
        groupValue: currentMode, // Default selected value
        onValueChanged: (GameMode? value) {
          if (value != null) {
            setState(() {
              currentMode = value;
            });
          }
        },
        borderColor: AppConstants.vintageGreen,
        selectedColor: AppConstants.vintageGreen,
        unselectedColor: AppConstants.vintageBeige,

      ),
    );
    return Text("mode selection");
  }

  Widget _buildGameOptionsSection(){
    return Text("option selection");
  }

  Widget _buildPlayerSection(){
    return Text("player selection");
  }

  Widget _buildStartGameButton(){
    return Container(
      width: double.infinity, // Make it full width
      padding: EdgeInsets.symmetric(horizontal: AppConstants.extraLargePadding),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOutCubicEmphasized,
          // move the button up and to the left by 2.5 when hovered, down and to the right when clicked
          transform: _isHovering
              ? Matrix4.translationValues(-2.5, -2.5, 0)
              : Matrix4.translationValues(0, 0, 0),
          decoration: BoxDecoration(
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(5, 5),
                      blurRadius: 0,
                    ),
                  ]
                : [],
            borderRadius: BorderRadius.circular(AppConstants.edgesFullRounding),
          ),
          child: TextButton(
            onPressed: () {
              // Handle start game logic
              Navigator.pushNamed(context, '/game');
            },
            style: TextButton.styleFrom(
              backgroundColor: AppConstants.vintageAccentDark,
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.largePadding,
                  vertical: AppConstants.defaultPadding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.edgesFullRounding),
              ),
            ),
            child: Text(
              "Start",
              style: AppConstants.startGameButtonTextStyle
                  ?.copyWith(color: AppConstants.vintageBeige),
            ),
          ),
        ),
      )
    );
  }
}
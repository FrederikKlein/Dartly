import 'package:dartly/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum GameMode { x01, cricket }
enum X01OutMode { straight, double, triple }
enum X01InMode { straight, double, triple}
const X01StartValue = [301,401,501,601,701,801,901,1001];
var currentMode = GameMode.x01; // Default mode
var currentX01OutMode = X01OutMode.triple; // Default out mode
var currentX01InMode = X01InMode.double; // Default in mode
var currentX01StartValue = X01StartValue[0]; // Default start value

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: Container(
        width: double.infinity,
        child: CupertinoSegmentedControl<GameMode>(
          children: _segmentsMap,
          groupValue: currentMode,
          onValueChanged: (GameMode? value) {
            if (value != null) {
              setState(() {
                currentMode = value;
              });
            }
          },
          borderColor: Colors.transparent,
          selectedColor: AppConstants.vintageGreen,
          unselectedColor: AppConstants.vintageBeige,
          pressedColor: AppConstants.vintageGreen.withOpacity(0.2),
          padding: const EdgeInsets.all(0),
          // disable the game mode cricket
          disabledChildren: <GameMode>{
            GameMode.cricket,
          },
        ),
      ),
    );
  }

  Widget _buildGameOptionsSection(){
    switch (currentMode) {
      case GameMode.x01:
        return _buildX01Options();
      case GameMode.cricket:
        return _buildX01Options();
    }
  }

  Widget _buildX01Options(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: StatefulBuilder(
            builder: (context, setState) {
              final GlobalKey _containerKey = GlobalKey();
              return GestureDetector(
                onTap: () async {
                  final RenderBox? renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
                  final Offset? offset = renderBox?.localToGlobal(Offset.zero);
                  final Size? size = renderBox?.size;

                  final selected = await showDialog<X01OutMode>(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (context) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 200),
                            left: offset?.dx ?? 0,
                            top: offset?.dy ?? X01OutMode.values.indexOf(currentX01OutMode) * 48.0 + 48,
                            width: size?.width ?? 60,
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                width: size?.width ?? 60,
                                constraints: BoxConstraints(
                                  maxHeight: 144,
                                ),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: X01OutMode.values.length,
                                    itemExtent: 48,
                                    itemBuilder: (context, index) {
                                      final value = X01OutMode.values[index];
                                      return ListTile(
                                        title: Text(value.name[0].toUpperCase() + value.name.substring(1), style: AppConstants.buttonTextStyle, textAlign: TextAlign.center,),
                                        selected: value == currentX01OutMode,
                                        onTap: () => Navigator.pop(context, value),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  if (selected != null) {
                    setState(() {
                      currentX01OutMode = selected;
                    });
                  }
                },
                child: Container(
                  key: _containerKey,
                  margin: EdgeInsets.symmetric(horizontal: AppConstants.smallPadding),
                  padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppConstants.vintageBeige
                  ),
                  width: double.infinity,
                  child: Text(
                    currentX01OutMode.name[0].toUpperCase() + currentX01OutMode.name.substring(1),
                    style: AppConstants.buttonTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: StatefulBuilder(
            builder: (context, setState) {
              return GestureDetector(
                onTap: () async {
                  final selected = await showDialog<X01OutMode>(
                    context: context,
                    builder: (context) {
                      final controller = ScrollController(
                        initialScrollOffset: X01OutMode.values.indexOf(currentX01OutMode) * 48.0 - 48.0,
                      );
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: SizedBox(
                          height: 144,
                          width: 60,
                          child: ListView.builder(
                            controller: controller,
                            itemCount: X01OutMode.values.length,
                            itemExtent: 48,
                            itemBuilder: (context, index) {
                              final value = X01OutMode.values[index];
                              return ListTile(
                                title: Text(value.name[0].toUpperCase() + value.name.substring(1)),
                                selected: value == currentX01OutMode,
                                onTap: () => Navigator.pop(context, value),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                  if (selected != null) {
                    setState(() {
                      currentX01OutMode = selected;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: AppConstants.mediumPadding),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: Text(
                    currentX01OutMode.name[0].toUpperCase() + currentX01OutMode.name.substring(1),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
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
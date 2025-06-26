import 'package:dartly/services/player_service.dart';
import 'package:dartly/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/settings_service.dart';

enum GameMode { x01, cricket }
var currentMode = GameMode.x01; // Default mode

class NewGameScreen extends ConsumerStatefulWidget {
  const NewGameScreen({super.key});

  @override
  _NewGameScreenState createState() => _NewGameScreenState();
}

class _NewGameScreenState extends ConsumerState<NewGameScreen> {
  bool _isHovering = false;
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(optionsServiceProvider);
    ref.read(playersProvider);
  }
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
    var segmentsMap = <GameMode, Widget>{
      GameMode.x01: Text("X01", style: AppConstants.buttonTextStyle),
      GameMode.cricket: Padding(padding: EdgeInsetsGeometry.symmetric(vertical: AppConstants.verySmallPadding), child: Text("Cricket", style: AppConstants.buttonTextStyle)),
    };
    return ClipRRect(
      borderRadius: BorderRadius.circular(500),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoSegmentedControl<GameMode>(
          children: segmentsMap,
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
      spacing: AppConstants.defaultPadding,
      children: [
        _buildOptionItem('x01InMode'),
        _buildOptionItem('x01StartValue'),
        _buildOptionItem('x01OutMode'),
      ],
    );
  }

  Widget _buildPlayerSection(){
    return Card(
      elevation: 0,
      color: AppConstants.vintageBeige,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          ReorderableListView.builder(
            buildDefaultDragHandles: false,
            shrinkWrap: true,
            itemCount: ref.watch(playersProvider).length,
            itemExtent: 48,
            itemBuilder: (context, index) {
              final value = ref.watch(playersProvider)[index];
              return ListTile(
                key: ValueKey(value.id),
                title: Text(value.name, style: AppConstants.buttonTextStyle, textAlign: TextAlign.center, ),
                selectedColor: AppConstants.vintageAccentDark,
                enabled: ref.watch(playersProvider)[index].isEnabled,
                trailing: IconButton(
                  icon: Icon(value.isEnabled ? Icons.check_circle : Icons.circle),
                  color: value.isEnabled ? AppConstants.vintageGreenLight : Colors.grey,
                  onPressed: () {
                    ref.read(playersProvider.notifier).togglePlayerEnabled(value.id);
                  },
                ),
                leading: ReorderableDragStartListener(
                  index: index, // The index of the item in the current list view
                  child: const Icon(Icons.drag_handle),
                ),
              );
            }, onReorder: (int oldIndex, int newIndex) {
              ref.read(playersProvider.notifier).reorderPlayers(oldIndex, newIndex);
          },
          ),
          ListTile(
            onTap: () {
              // accept text input for new player name
              String? newPlayerName = '';
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Add Player", style: AppConstants.subheadingStyle, textAlign: TextAlign.center,),
                    backgroundColor: AppConstants.vintageBeige,
                    content: TextField(
                      autofocus: true,
                      decoration: InputDecoration(hintText: "Enter player name", fillColor: AppConstants.vintageWhite,focusColor: AppConstants.vintageGreenLight),
                      cursorColor: AppConstants.vintageGreenLight,
                      style: AppConstants.buttonTextStyle,
                      onChanged: (value) {
                        newPlayerName = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Cancel", style: AppConstants.buttonTextStyle!.copyWith(color: AppConstants.vintageBlack.withAlpha(180))),
                      ),
                      TextButton(
                        onPressed: () {
                          if (newPlayerName != null && newPlayerName!.isNotEmpty) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Add", style: AppConstants.buttonTextStyle!.copyWith(color: AppConstants.vintageGreen)),
                      ),
                    ],
                  );
                },
              ).then((_) {
                if (newPlayerName != null && newPlayerName!.isNotEmpty) {
                  ref.read(playersProvider.notifier).addPlayer(newPlayerName!);
                }
              });
              //ref.read(playersProvider.notifier).addPlayer(newPlayerName);
            },
            key: ValueKey('addPlayer'),
            title: Text("+", style: AppConstants.buttonTextExtraBigStyle!.copyWith(color: AppConstants.vintageBlack.withAlpha(180)), textAlign: TextAlign.center, ),
          )
        ],
      ),
    );
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

  _buildOptionItem(String optionType) {
    String optionType0 = optionType;
    return Expanded(
      flex: 1,
      child: StatefulBuilder(
        builder: (context, setState) {
          final GlobalKey containerKey = GlobalKey();
          return GestureDetector(
            onTap: () async {
              final RenderBox? renderBox = containerKey.currentContext?.findRenderObject() as RenderBox?;
              final Offset? offset = renderBox?.localToGlobal(Offset.zero);
              final Size? size = renderBox?.size;

              final selected = await showDialog(
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
                      Positioned(
                        left: offset?.dx ?? 0,
                        top: offset?.dy ?? 48,
                        width: size?.width ?? 60,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: size?.width ?? 60,
                            constraints: BoxConstraints(
                              maxHeight: 48*ref.watch(optionsServiceProvider).getOptions(optionType).length.toDouble(),
                            ),
                            child: Card(
                              color: AppConstants.vintageBeige,
                              margin: EdgeInsets.zero,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: ref.watch(optionsServiceProvider).getOptions(optionType).length,
                                itemExtent: 48,
                                itemBuilder: (context, index) {
                                  final value = ref.watch(optionsServiceProvider).getOptions(optionType)[index];
                                  return ListTile(
                                    title: Text(value.toString(), style: AppConstants.buttonTextStyle, textAlign: TextAlign.center, ),
                                    selected: value == ref.watch(optionsServiceProvider).getCurrentOption(optionType),
                                    selectedColor: AppConstants.vintageAccentDark,
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
                  ref.read(optionsServiceProvider).setOption(optionType0, selected);
                });
              }
            },
            child: Container(
              key: containerKey,
              padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppConstants.vintageBeige
              ),
              width: double.infinity,
              child: Text(
                ref.watch(optionsServiceProvider).getCurrentOption(optionType).toString(),
                style: AppConstants.buttonTextStyle,
                textAlign: TextAlign.center,
              ),

            ),
          );
        },
      ),
    );
  }
}
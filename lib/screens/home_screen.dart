
import 'package:dartly/screens/new_game_scratch.dart';
import 'package:dartly/screens/settings_screen.dart';
import 'package:dartly/screens/statistics_screen.dart';
import 'package:dartly/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';

// Navigation enum for our screens
enum AppScreen { stats, home, settings }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppScreen _selectedScreen = AppScreen.home;
  int _animationKey = 0;

  // Screen colors for the sliding effect
  final Map<AppScreen, Color> _screenColors = {
    AppScreen.stats: AppConstants.vintageGreenLighter, // Blue
    AppScreen.home: AppConstants.vintageGreenLight, // Green
    AppScreen.settings: AppConstants.vintageGreenLighter, // Purple
  };

  // Get the current screen widget
  Widget _getCurrentScreen() {
    switch (_selectedScreen) {
      case AppScreen.stats:
        return const StatisticsScreen();
      case AppScreen.home:
        return NewGameScreen();
      case AppScreen.settings:
        return const SettingsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children: [
          // Main content (full screen)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            color: _screenColors[_selectedScreen],
            child: _getCurrentScreen(),
          ),
          // Floating navbar positioned at bottom
          Positioned(
            bottom: AppConstants.defaultPadding,
            left: AppConstants.getNavBarPadding(context),
            right: AppConstants.getNavBarPadding(context),
            child: _buildFloatingNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    return Container(
      margin: const EdgeInsets.only(top:AppConstants.smallPadding, bottom: AppConstants.smallPadding),
      decoration: BoxDecoration(
        color: AppConstants.vintageWhite.withOpacity(0.95),
        borderRadius: SmoothBorderRadius(cornerRadius: AppConstants.edgesFullRounding,cornerSmoothing: 100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias, // Add this line
      child: Stack(
        children: [
          // Animated sliding background
          // Enhanced fluid animation with morphing effect
          AnimatedPositioned(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOutCubicEmphasized, // expressive easing
            left: _getSelectedPosition(),
            top: 0,
            bottom: 0,
            width: _getItemWidth(context),
            child: TweenAnimationBuilder<double>(
              key: ValueKey(_animationKey),
              duration: const Duration(milliseconds: 300),
              tween: Tween(begin: -1.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scaleX: 1.0 + (0.05 * _getInterpolationForValue(value)), // Squeeze and release effect
                  scaleY: 1.0 + (-0.03 * _getInterpolationForValue(value)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _screenColors[_selectedScreen]!,
                      borderRadius:BorderRadius.all(
                        Radius.elliptical(
                          AppConstants.edgesFullRounding * (0.6 + 0.05 * _getInterpolationForValue(value)), // Even more squircle-like
                          AppConstants.edgesFullRounding,
                        ),
                      ), //Static border radius
                      //borderRadius: BorderRadius.circular(20.0 + (5 * (1 - value))), // Dynamic border radius
                      boxShadow: [
                        BoxShadow(
                          color: _screenColors[_selectedScreen]!.withOpacity(0.4),
                          //blurRadius: 8 + (4 * (1 - value)), // Dynamic shadow
                          blurRadius: 0,
                          offset: Offset(2 + (2 * (1 - value)), 2 + (2 * (1 - value))),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Navigation items
          Row(
            children: AppScreen.values.map((screen) {
              bool isSelected = _selectedScreen == screen;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _selectedScreen = screen;
                      _animationKey++;
                    });
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: AppConstants.navBarHeight,
                    child: _buildNavItem(
                      icon: _getIconForScreen(screen),
                      label: _getLabelForScreen(screen),
                      isSelected: isSelected,
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

// Helper method to calculate the position of the sliding indicator
  double _getSelectedPosition() {
    double totalWidth = _getTotalWidth(context);
    switch (_selectedScreen) {
      case AppScreen.stats:
        return 0; // First item
      case AppScreen.home:
        return totalWidth/4 ; // Second item
      case AppScreen.settings:
        return totalWidth/4 * 3 ; // Third item
    }
  }

  double _getTotalWidth(BuildContext context){
    return MediaQuery.of(context).size.width - 2*AppConstants.getNavBarPadding(context) - AppConstants.smallPadding; // screen margins + container padding
  }
// Helper method to calculate item width
  double _getItemWidth(BuildContext context) {
    // Account for container padding and margins
    double totalWidth = _getTotalWidth(context);
    if(_selectedScreen==AppScreen.home){
      return totalWidth/2 + AppConstants.smallPadding;
    }
    return totalWidth / 4 + AppConstants.smallPadding; // divided by number of items
  }

  double _getInterpolationForValue(double x) {
    return 0.75 - x - 0.416667*x*x + x*x*x - 0.333333*x*x*x*x;
    // 1-x^2
    return (-(x*x) +1);
  }

  IconData _getIconForScreen(AppScreen screen) {
    switch (screen) {
      case AppScreen.stats:
        return Icons.bar_chart;
      case AppScreen.home:
        return Icons.games_outlined;
      case AppScreen.settings:
        return Icons.settings;
    }
  }

  String _getLabelForScreen(AppScreen screen) {
    switch (screen) {
      case AppScreen.stats:
        return 'Stats';
      case AppScreen.home:
        return 'Play';
      case AppScreen.settings:
        return 'Settings';
    }
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding, vertical: AppConstants.smallPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey.shade600,
            size: AppConstants.iconSize,
          ),
          const SizedBox(height: 4),
          Visibility(visible: false,child:
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
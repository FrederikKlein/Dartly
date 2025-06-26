import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const double phoneBreakpoint = 900.0;
  static const double tabletBreakpoint = 1024.0;

  static bool isPhone(BuildContext context) {
    return MediaQuery.of(context).size.width < phoneBreakpoint;
  }
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= phoneBreakpoint && MediaQuery.of(context).size.width < tabletBreakpoint;
  }
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }
  // Game constants
  static const List<int> commonStartingScores = [301, 501, 701, 901];
  static const int maxDartsPerTurn = 3;
  static const int maxPlayers = 8;
  static const int minPlayers = 2;

  // UI constants
  static const double defaultPadding = 16.0;
  static const double mediumPadding = 12.0;
  static const double smallPadding = 8.0;
  static const double verySmallPadding = 4.0;
  static const double tinyPadding = 2.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;
  static const double edgesFullRounding = 48;
  static const double edgesSmallRounding = 4;
  static const double navBarHeight = 64;

  static double getAppPadding(BuildContext context) {
    return isPhone(context) ? 32.0 : 64.0;
  }
  static double getNavBarPadding(BuildContext context) {
    return isPhone(context) ? 64.0 : 128.0;
  }

  static const double iconSize = 20;
  // Colors (you can customize these)
  static const Color vintageGreen = Color(0xFF304D29); // Highlight color
  static const Color vintageGreenLight = Color(0xFF6C855A); // lighter shade of Highlight color
  static const Color vintageGreenLighter = Color(0xFFA8BC8B); // even lighter shade of Highlight color
  static const Color vintageGreenDark = Color(0xFF273822); // darker shade of Highlight color
  static const Color vintageBeige = Color(0xFFFFF8DC); // Soft bright beige background (Cornsilk)
  static const Color vintageAccent = Color(0xFFF1A67E); // Special things color
  static const Color vintageAccentLight = Color(0xFFF6D4BA); // lighter shade of Special things color
  static const Color vintageAccentDark = Color(0xFFDB9773); // darker shade of Special things color
  static const Color vintageWhite = Color(0xFFFFFDEB);
  static const Color vintageBlack = Color(0xFF1B1B18);

  // Text styles
  static TextStyle? get headingStyle => TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );
  static TextStyle? get subheadingStyle => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );
  static TextStyle? get buttonTextStyle => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );
  static TextStyle? get buttonTextSmallStyle => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );
  static TextStyle? get buttonTextExtraBigStyle => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );
  static TextStyle? get bodyStyle => TextStyle(
    fontSize: 16,
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );
  static TextStyle? get startGameButtonTextStyle => TextStyle(
    fontSize: 24,
    fontFamily: GoogleFonts.pressStart2p().fontFamily,
    fontWeight: FontWeight.w900
  );
}
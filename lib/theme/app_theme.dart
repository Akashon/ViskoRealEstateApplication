// // now this is my theme/app_theme.dart page code and i want to added my bottom_nav_bar_page.dart in it this color code according set color dont' user any custom code

// // this is my theme/app_theme.dart page code and i want to added this theme according my home page color don't user my home page init any custom color use only my theme color glass theme light dark so added my home page init my theme color

// import 'package:flutter/material.dart';
// import 'package:visko_rocky_flutter/config/colors.dart';

// @immutable
// class GlassColors extends ThemeExtension<GlassColors> {
//   final Color glassBackground;
//   final Color glassBorder;

//   final Color cardBackground;

//   final Color chipSelectedGradientStart;
//   final Color chipSelectedGradientEnd;
//   final Color chipUnselectedStart;
//   final Color chipUnselectedEnd;

//   final Color textPrimary;
//   final Color textSecondary;

//   const GlassColors({
//     required this.glassBackground,
//     required this.glassBorder,
//     required this.cardBackground,
//     required this.chipSelectedGradientStart,
//     required this.chipSelectedGradientEnd,
//     required this.chipUnselectedStart,
//     required this.chipUnselectedEnd,
//     required this.textPrimary,
//     required this.textSecondary,
//   });

//   @override
//   GlassColors copyWith({
//     Color? glassBackground,
//     Color? glassBorder,
//     Color? cardBackground,
//     Color? chipSelectedGradientStart,
//     Color? chipSelectedGradientEnd,
//     Color? chipUnselectedStart,
//     Color? chipUnselectedEnd,
//     Color? textPrimary,
//     Color? textSecondary,
//   }) {
//     return GlassColors(
//       glassBackground: glassBackground ?? this.glassBackground,
//       glassBorder: glassBorder ?? this.glassBorder,
//       cardBackground: cardBackground ?? this.cardBackground,
//       chipSelectedGradientStart:
//           chipSelectedGradientStart ?? this.chipSelectedGradientStart,
//       chipSelectedGradientEnd:
//           chipSelectedGradientEnd ?? this.chipSelectedGradientEnd,
//       chipUnselectedStart: chipUnselectedStart ?? this.chipUnselectedStart,
//       chipUnselectedEnd: chipUnselectedEnd ?? this.chipUnselectedEnd,
//       textPrimary: textPrimary ?? this.textPrimary,
//       textSecondary: textSecondary ?? this.textSecondary,
//     );
//   }

//   @override
//   GlassColors lerp(ThemeExtension<GlassColors>? other, double t) {
//     if (other is! GlassColors) return this;

//     return GlassColors(
//       glassBackground: Color.lerp(glassBackground, other.glassBackground, t)!,
//       glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
//       cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
//       chipSelectedGradientStart: Color.lerp(
//           chipSelectedGradientStart, other.chipSelectedGradientStart, t)!,
//       chipSelectedGradientEnd: Color.lerp(
//           chipSelectedGradientEnd, other.chipSelectedGradientEnd, t)!,
//       chipUnselectedStart:
//           Color.lerp(chipUnselectedStart, other.chipUnselectedStart, t)!,
//       chipUnselectedEnd:
//           Color.lerp(chipUnselectedEnd, other.chipUnselectedEnd, t)!,
//       textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
//       textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
//     );
//   }
// }

// class AppTheme {
//   // ---------------- LIGHT THEME ----------------
//   static final lightTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: Colors.white,
//     primaryColor: kPrimaryOrange,
//     extensions: <ThemeExtension<dynamic>>[
//       const GlassColors(
//         glassBackground: Color.fromRGBO(255, 255, 255, 0.55),
//         glassBorder: Color(0xFFFFE0B2),
//         cardBackground: Color.fromRGBO(255, 255, 255, 0.55),
//         chipSelectedGradientStart: kPrimaryOrange,
//         chipSelectedGradientEnd: Color(0xFFFFC68A),
//         chipUnselectedStart: Color.fromRGBO(255, 255, 255, 0.65),
//         chipUnselectedEnd: Color.fromRGBO(255, 255, 255, 0.45),
//         textPrimary: Colors.black87,
//         textSecondary: Colors.black54,
//       ),
//     ],
//   );

//   // ---------------- DARK THEME ----------------
//   static final darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: Colors.black,
//     primaryColor: kPrimaryOrange,
//     extensions: <ThemeExtension<dynamic>>[
//       const GlassColors(
//         glassBackground: Color.fromRGBO(255, 255, 255, 0.06),
//         glassBorder: Colors.white24,
//         cardBackground: Color.fromRGBO(255, 255, 255, 0.06),
//         chipSelectedGradientStart: kPrimaryOrange,
//         chipSelectedGradientEnd: Color(0x99F26A33),
//         chipUnselectedStart: Color.fromRGBO(255, 255, 255, 0.10),
//         chipUnselectedEnd: Color.fromRGBO(255, 255, 255, 0.06),
//         textPrimary: Colors.white,
//         textSecondary: Colors.white70,
//       ),
//     ],
//   );
// }

// now this is my theme/app_theme.dart page code and i want to added my bottom_nav_bar_page.dart in it this color code according set color dont' user any custom code

// this is my theme/app_theme.dart page code and i want to added this theme according my home page color don't user my home page init any custom color use only my theme color glass theme light dark so added my home page init my theme color

import 'package:flutter/material.dart';
import 'package:visko_rocky_flutter/config/colors.dart';

@immutable
class GlassColors extends ThemeExtension<GlassColors> {
  final Color glassBackground;
  final Color glassBorder;
  final Color cardBackground;

  final Color solidSurface;

  final Color chipSelectedGradientStart;
  final Color chipSelectedGradientEnd;
  final Color chipUnselectedStart;
  final Color chipUnselectedEnd;

  final Color textPrimary;
  final Color textSecondary;

  const GlassColors({
    required this.glassBackground,
    required this.glassBorder,
    required this.cardBackground,
    required this.solidSurface,
    required this.chipSelectedGradientStart,
    required this.chipSelectedGradientEnd,
    required this.chipUnselectedStart,
    required this.chipUnselectedEnd,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  GlassColors copyWith({
    Color? glassBackground,
    Color? glassBorder,
    Color? cardBackground,
    Color? solidSurface,
    Color? chipSelectedGradientStart,
    Color? chipSelectedGradientEnd,
    Color? chipUnselectedStart,
    Color? chipUnselectedEnd,
    Color? textPrimary,
    Color? textSecondary,
  }) {
    return GlassColors(
      glassBackground: glassBackground ?? this.glassBackground,
      glassBorder: glassBorder ?? this.glassBorder,
      cardBackground: cardBackground ?? this.cardBackground,
      solidSurface: solidSurface ?? this.solidSurface,
      chipSelectedGradientStart:
          chipSelectedGradientStart ?? this.chipSelectedGradientStart,
      chipSelectedGradientEnd:
          chipSelectedGradientEnd ?? this.chipSelectedGradientEnd,
      chipUnselectedStart: chipUnselectedStart ?? this.chipUnselectedStart,
      chipUnselectedEnd: chipUnselectedEnd ?? this.chipUnselectedEnd,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  GlassColors lerp(ThemeExtension<GlassColors>? other, double t) {
    if (other is! GlassColors) return this;

    return GlassColors(
      glassBackground: Color.lerp(glassBackground, other.glassBackground, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      solidSurface: Color.lerp(solidSurface, other.solidSurface, t)!,
      chipSelectedGradientStart: Color.lerp(
          chipSelectedGradientStart, other.chipSelectedGradientStart, t)!,
      chipSelectedGradientEnd: Color.lerp(
          chipSelectedGradientEnd, other.chipSelectedGradientEnd, t)!,
      chipUnselectedStart:
          Color.lerp(chipUnselectedStart, other.chipUnselectedStart, t)!,
      chipUnselectedEnd:
          Color.lerp(chipUnselectedEnd, other.chipUnselectedEnd, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}

class AppTheme {
  // ---------------- LIGHT THEME ----------------
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: kPrimaryOrange,
    extensions: <ThemeExtension<dynamic>>[
      const GlassColors(
        glassBackground: Color.fromRGBO(255, 255, 255, 0.55),
        cardBackground: Color.fromRGBO(255, 255, 255, 0.55),
        glassBorder: Color(0xFFFFE0B2),
        solidSurface: Color(0xFFFFF3E8),
        chipSelectedGradientStart: kPrimaryOrange,
        chipSelectedGradientEnd: Color(0xFFFFC68A),
        chipUnselectedStart: Color.fromRGBO(255, 255, 255, 0.65),
        chipUnselectedEnd: Color.fromRGBO(255, 255, 255, 0.45),
        textPrimary: Colors.black87,
        textSecondary: Colors.black54,
      ),
    ],
  );

  // ---------------- DARK THEME ----------------
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: kPrimaryOrange,
    extensions: <ThemeExtension<dynamic>>[
      const GlassColors(
        glassBackground: Color.fromRGBO(18, 18, 18, 0.75),
        cardBackground: Color.fromRGBO(18, 18, 18, 0.85),
        glassBorder: Color.fromRGBO(242, 106, 51, 0.25),
        solidSurface: Color(0xFF121212),
        chipSelectedGradientStart: kPrimaryOrange,
        chipSelectedGradientEnd: Color(0x99F26A33),
        chipUnselectedStart: Color.fromRGBO(255, 255, 255, 0.10),
        chipUnselectedEnd: Color.fromRGBO(255, 255, 255, 0.06),
        textPrimary: Colors.white,
        textSecondary: Colors.white70,
      ),
    ],
  );
}

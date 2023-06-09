import 'package:flutter/material.dart';
import '../helpers/custom_route.dart';

ThemeData myTheme({required ColorScheme type}) {
  return ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CustomPageTransitionBuilder(),
        TargetPlatform.android: CustomPageTransitionBuilder(),
      },
    ),
    useMaterial3: true,
    colorScheme: type,
    fontFamily: 'Poppins',
    iconTheme: const IconThemeData(color: Colors.pink),
    snackBarTheme: SnackBarThemeData(
      actionTextColor: MaterialStateColor.resolveWith((states) => Colors.red),
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 23,
        letterSpacing: 2,
        color: type == darkColorScheme
            ? const Color(0xffa5cc33)
            : const Color(0xFF093110),
      ),
    ),
  );
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF176D32),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFA2F6AC),
  onPrimaryContainer: Color(0xFF002109),
  secondary: Color(0xFF516351),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD4E8D1),
  onSecondaryContainer: Color(0xFF0F1F11),
  tertiary: Color(0xFF39656D),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFBDEAF3),
  onTertiaryContainer: Color(0xFF001F24),
  error: Color(0xFFF34B4B),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF7FFEE),
  onBackground: Color(0xFF002200),
  surface: Color(0xffa5cc33),
  onSurface: Color(0xFF002200),
  surfaceVariant: Color(0xFFDDE5D9),
  onSurfaceVariant: Color(0xFF414941),
  outline: Color(0xFF727970),
  onInverseSurface: Color(0xFFCAFFB9),
  inverseSurface: Color(0xFF003A01),
  inversePrimary: Color(0xFF86D992),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF176D32),
  outlineVariant: Color(0xFFC1C9BE),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF86D992),
  onPrimary: Color(0xFF003915),
  primaryContainer: Color(0xFF005321),
  onPrimaryContainer: Color(0xFFA2F6AC),
  secondary: Color(0xFFB8CCB6),
  onSecondary: Color(0xFF243425),
  secondaryContainer: Color(0xFF3A4B3A),
  onSecondaryContainer: Color(0xFFD4E8D1),
  tertiary: Color(0xFFA1CED7),
  onTertiary: Color(0xFF00363D),
  tertiaryContainer: Color(0xFF1F4D54),
  onTertiaryContainer: Color(0xFFBDEAF3),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF121212),
  onBackground: Color(0xFFB0F49E),
  surface: Color(0xFF666666),
  onSurface: Color(0xFFB0F49E),
  surfaceVariant: Color(0xFF414941),
  onSurfaceVariant: Color(0xFFC1C9BE),
  outline: Color(0xFF8B9389),
  onInverseSurface: Color(0xFF002200),
  inverseSurface: Color(0xFFB0F49E),
  inversePrimary: Color(0xFF176D32),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF86D992),
  outlineVariant: Color(0xFF414941),
  scrim: Color(0xFF000000),
);

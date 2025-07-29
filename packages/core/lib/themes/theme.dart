import 'package:core/themes/theme_config.dart';
import 'package:flutter/material.dart';

ThemeData themeDataLight = ThemeData(
  useMaterial3: false,
).copyWith(
  // Primary Colors
  primaryColor: primaryColor,

  // Background Colors
  scaffoldBackgroundColor: backgroundLight,
  canvasColor: surfaceLight,

  // Surface Colors
  // backgroundColor: deprecated, now uses colorScheme.background
  // bottomAppBarColor: deprecated, now uses colorScheme.surface

  // Accent & Secondary Colors
  hoverColor: neutralMist,
  focusColor: primaryColor.withOpacity(0.12),
  highlightColor: primaryColor.withOpacity(0.12),
  splashColor: primaryColor.withOpacity(0.24),

  // Selection Colors
  unselectedWidgetColor: neutralStone,

  // Disabled Colors
  disabledColor: neutralStone,

  // Divider Colors
  dividerColor: neutralMist,

  // Indicator Colors
  indicatorColor: primaryColor,

  // Shadow Color
  shadowColor: neutralOnyx.withOpacity(0.16),

  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    background: backgroundLight,
    onBackground: neutralOnyx,
    surface: surfaceLight,
    onSurface: neutralOnyx,
    outline: neutralMist,
    primary: primaryColor,
    onPrimary: neutralPure,
    secondary: neutralSilver,
    onSecondary: neutralCharcoal,
    tertiary: primaryColor,
    onTertiary: neutralPure,
    error: errorFresh,
    onError: neutralPure,
    primaryContainer: green50,
    onPrimaryContainer: green800,
    secondaryContainer: yellow50,
    onSecondaryContainer: yellow800,
    tertiaryContainer: blue50,
    onTertiaryContainer: blue800,
    errorContainer: red50,
    onErrorContainer: red800,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: neutralPure,
    elevation: 0,
    shadowColor: neutralOnyx.withOpacity(0.1),
    surfaceTintColor: Colors.transparent,
    titleTextStyle: myTextThemeLight.headlineSmall?.copyWith(
      color: neutralPure,
    ),
    iconTheme: const IconThemeData(
      color: neutralPure,
      size: 24,
    ),
    actionsIconTheme: const IconThemeData(
      color: neutralPure,
      size: 24,
    ),
  ),

  // Card Theme - using cardTheme instead of deprecated cardColor
  cardTheme: const CardTheme(
    color: surfaceLight,
    shadowColor: neutralOnyx,
    elevation: 2,
    margin: EdgeInsets.all(4),
  ),

  // Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: neutralPure,
      shadowColor: neutralOnyx.withOpacity(0.3),
      elevation: 2,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: BorderSide(color: primaryColor),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: neutralGhost,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: neutralMist),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: neutralMist),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: errorFresh),
    ),
    labelStyle: const TextStyle(color: neutralSlate),
    hintStyle: const TextStyle(color: neutralStone),
  ),

  // Checkbox Theme
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return surfaceLight;
    }),
    checkColor: MaterialStateProperty.all(neutralPure),
  ),

  // Radio Theme
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return neutralStone;
    }),
  ),

  // Switch Theme
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return neutralStone;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor.withOpacity(0.5);
      }
      return neutralMist;
    }),
  ),

  // Progress Indicator Theme
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: primaryColor,
    linearTrackColor: neutralMist,
    circularTrackColor: neutralMist,
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: surfaceLight,
    selectedItemColor: primaryColor,
    unselectedItemColor: neutralStone,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Bottom App Bar Theme - replacement for deprecated bottomAppBarColor
  bottomAppBarTheme: const BottomAppBarTheme(
    color: surfaceLight,
    elevation: 8,
    height: 60,
  ),

  // Tab Bar Theme
  tabBarTheme: TabBarTheme(
    labelColor: primaryColor,
    unselectedLabelColor: neutralStone,
    indicatorColor: primaryColor,
  ),

  // Drawer Theme
  drawerTheme: DrawerThemeData(
    backgroundColor: surfaceLight,
    scrimColor: neutralOnyx.withOpacity(0.54),
    elevation: 16,
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: neutralPure,
    elevation: 6,
  ),

  // Snack Bar Theme
  snackBarTheme: SnackBarThemeData(
    backgroundColor: neutralOnyx,
    contentTextStyle: const TextStyle(color: neutralPure),
    actionTextColor: primaryColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  // Dialog Theme - using dialogTheme instead of deprecated dialogBackgroundColor
  dialogTheme: DialogTheme(
    backgroundColor: surfaceLight,
    elevation: 24,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: myTextThemeLight.headlineMedium,
    contentTextStyle: myTextThemeLight.bodyMedium,
  ),

  // Tooltip Theme
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: neutralOnyx.withOpacity(0.9),
      borderRadius: BorderRadius.circular(4),
    ),
    textStyle: const TextStyle(
      color: neutralPure,
      fontSize: 12,
    ),
  ),

  // Menu Theme
  menuTheme: MenuThemeData(
    style: MenuStyle(
      backgroundColor: MaterialStateProperty.all(surfaceLight),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(neutralOnyx),
      elevation: MaterialStateProperty.all(8),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  ),

  // List Tile Theme
  listTileTheme: ListTileThemeData(
    tileColor: Colors.transparent,
    selectedTileColor: primaryColor,
    selectedColor: neutralPure,
    textColor: neutralOnyx,
    iconColor: neutralSlate,
  ),

  textTheme: myTextThemeLight,
);

ThemeData themeDataDark = ThemeData.dark(
  useMaterial3: false,
).copyWith(
  // Primary Colors
  primaryColor: primaryColor,

  // Background Colors
  scaffoldBackgroundColor: backgroundDark,
  canvasColor: surfaceDark,

  // Surface Colors
  // backgroundColor: deprecated, now uses colorScheme.background
  // bottomAppBarColor: deprecated, now uses colorScheme.surface

  // Accent & Secondary Colors
  hoverColor: neutralGraphite,
  focusColor: primaryColor.withOpacity(0.24),
  highlightColor: primaryColor.withOpacity(0.24),
  splashColor: primaryColor.withOpacity(0.32),

  // Selection Colors
  unselectedWidgetColor: neutralSlate,

  // Disabled Colors
  disabledColor: neutralSlate,

  // Divider Colors
  dividerColor: neutralCharcoal,

  // Indicator Colors
  indicatorColor: primaryColor,

  // Shadow Color
  shadowColor: neutralEbony.withOpacity(0.4),

  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    background: backgroundDark,
    onBackground: neutralPure,
    surface: surfaceDark,
    onSurface: neutralPure,
    outline: neutralCharcoal,
    primary: primaryColor,
    onPrimary: neutralPure,
    secondary: neutralOnyx,
    onSecondary: neutralLight,
    tertiary: primaryColor,
    onTertiary: neutralPure,
    error: errorFresh,
    onError: neutralPure,
    primaryContainer: neutralOnyx,
    onPrimaryContainer: primaryColor,
    secondaryContainer: neutralOnyx,
    onSecondaryContainer: primaryAmber,
    tertiaryContainer: neutralOnyx,
    onTertiaryContainer: primaryColor,
    errorContainer: neutralOnyx,
    onErrorContainer: errorFresh,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: neutralPure,
    elevation: 0,
    shadowColor: neutralEbony.withOpacity(0.2),
    surfaceTintColor: Colors.transparent,
    titleTextStyle: myTextThemeDark.headlineSmall?.copyWith(
      color: neutralPure,
    ),
    iconTheme: const IconThemeData(
      color: neutralPure,
      size: 24,
    ),
    actionsIconTheme: const IconThemeData(
      color: neutralPure,
      size: 24,
    ),
  ),

  // Card Theme - using cardTheme instead of deprecated cardColor
  cardTheme: const CardTheme(
    color: surfaceDark,
    shadowColor: neutralEbony,
    elevation: 4,
    margin: EdgeInsets.all(4),
  ),

  // Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: neutralPure,
      shadowColor: neutralEbony.withOpacity(0.5),
      elevation: 3,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: BorderSide(color: primaryColor),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
    ),
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: neutralOnyx,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: neutralCharcoal),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: neutralCharcoal),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: errorFresh),
    ),
    labelStyle: const TextStyle(color: neutralSilver),
    hintStyle: const TextStyle(color: neutralSlate),
  ),

  // Checkbox Theme
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return surfaceDark;
    }),
    checkColor: MaterialStateProperty.all(neutralPure),
    side: const BorderSide(color: neutralCharcoal),
  ),

  // Radio Theme
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return neutralSlate;
    }),
  ),

  // Switch Theme
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor;
      }
      return neutralSlate;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor.withOpacity(0.5);
      }
      return neutralCharcoal;
    }),
  ),

  // Progress Indicator Theme
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: primaryColor,
    linearTrackColor: neutralCharcoal,
    circularTrackColor: neutralCharcoal,
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: surfaceDark,
    selectedItemColor: primaryColor,
    unselectedItemColor: neutralSlate,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  ),

  // Bottom App Bar Theme - replacement for deprecated bottomAppBarColor
  bottomAppBarTheme: const BottomAppBarTheme(
    color: surfaceDark,
    elevation: 8,
    height: 60,
  ),

  // Tab Bar Theme
  tabBarTheme: TabBarTheme(
    labelColor: primaryColor,
    unselectedLabelColor: neutralSlate,
    indicatorColor: primaryColor,
  ),

  // Drawer Theme
  drawerTheme: const DrawerThemeData(
    backgroundColor: surfaceDark,
    scrimColor: neutralEbony,
    elevation: 16,
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: neutralPure,
    elevation: 6,
  ),

  // Snack Bar Theme
  snackBarTheme: SnackBarThemeData(
    backgroundColor: neutralGraphite,
    contentTextStyle: const TextStyle(color: neutralPure),
    actionTextColor: primaryColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),

  // Dialog Theme - using dialogTheme instead of deprecated dialogBackgroundColor
  dialogTheme: DialogTheme(
    backgroundColor: surfaceDark,
    elevation: 24,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: myTextThemeDark.headlineMedium,
    contentTextStyle: myTextThemeDark.bodyMedium,
  ),

  // Tooltip Theme
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: neutralCharcoal.withOpacity(0.95),
      borderRadius: BorderRadius.circular(4),
    ),
    textStyle: const TextStyle(
      color: neutralPure,
      fontSize: 12,
    ),
  ),

  // Menu Theme
  menuTheme: MenuThemeData(
    style: MenuStyle(
      backgroundColor: MaterialStateProperty.all(surfaceDark),
      surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(neutralEbony),
      elevation: MaterialStateProperty.all(8),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  ),

  // List Tile Theme
  listTileTheme: ListTileThemeData(
    tileColor: Colors.transparent,
    selectedTileColor: primaryColor,
    selectedColor: neutralPure,
    textColor: neutralPure,
    iconColor: neutralSilver,
  ),

  textTheme: myTextThemeDark,
);

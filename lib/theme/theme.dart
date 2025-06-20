import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0058be),
      surfaceTint: Color(0xff005ac2),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2170e4),
      onPrimaryContainer: Color(0xfffefcff),
      secondary: Color(0xff495e8a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb6ccff),
      onSecondaryContainer: Color(0xff405682),
      tertiary: Color(0xff8c34a2),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa84fbe),
      onTertiaryContainer: Color(0xfffffbff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff191b23),
      onSurfaceVariant: Color(0xff424754),
      outline: Color(0xff727785),
      outlineVariant: Color(0xffc2c6d6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3038),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a42),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff004395),
      secondaryFixed: Color(0xffd8e2ff),
      onSecondaryFixed: Color(0xff001a42),
      secondaryFixedDim: Color(0xffb1c6f9),
      onSecondaryFixedVariant: Color(0xff304671),
      tertiaryFixed: Color(0xfffdd6ff),
      onTertiaryFixed: Color(0xff340042),
      tertiaryFixedDim: Color(0xfff4aeff),
      onTertiaryFixedVariant: Color(0xff74198b),
      surfaceDim: Color(0xffd8d9e3),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3fd),
      surfaceContainer: Color(0xffecedf7),
      surfaceContainerHigh: Color(0xffe6e7f2),
      surfaceContainerHighest: Color(0xffe1e2ec),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003475),
      surfaceTint: Color(0xff005ac2),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0e69dc),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1f355f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff576d9a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5f0075),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa047b5),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff0e1118),
      onSurfaceVariant: Color(0xff313642),
      outline: Color(0xff4d5260),
      outlineVariant: Color(0xff686d7b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3038),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xff0e69dc),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff0051b0),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff576d9a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3f5480),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffa047b5),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff842b9b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c6d0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f3fd),
      surfaceContainer: Color(0xffe6e7f2),
      surfaceContainerHigh: Color(0xffdbdce6),
      surfaceContainerHighest: Color(0xffd0d1db),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002a62),
      surfaceTint: Color(0xff005ac2),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004699),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff132b55),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff334974),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4f0062),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff771c8e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff272c38),
      outlineVariant: Color(0xff444956),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3038),
      inversePrimary: Color(0xffadc6ff),
      primaryFixed: Color(0xff004699),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00306e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff334974),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1b325c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff771c8e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff59006e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb7b8c2),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff0fa),
      surfaceContainer: Color(0xffe1e2ec),
      surfaceContainerHigh: Color(0xffd3d4de),
      surfaceContainerHighest: Color(0xffc4c6d0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadc6ff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff002e6a),
      primaryContainer: Color(0xff4d8eff),
      onPrimaryContainer: Color(0xff001c46),
      secondary: Color(0xffb1c6f9),
      onSecondary: Color(0xff182f59),
      secondaryContainer: Color(0xff304671),
      onSecondaryContainer: Color(0xff9fb5e7),
      tertiary: Color(0xfff4aeff),
      onTertiary: Color(0xff55006a),
      tertiaryContainer: Color(0xffc86cdd),
      onTertiaryContainer: Color(0xff380046),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff10131a),
      onSurface: Color(0xffe1e2ec),
      onSurfaceVariant: Color(0xffc2c6d6),
      outline: Color(0xff8c909f),
      outlineVariant: Color(0xff424754),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2ec),
      inversePrimary: Color(0xff005ac2),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff001a42),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff004395),
      secondaryFixed: Color(0xffd8e2ff),
      onSecondaryFixed: Color(0xff001a42),
      secondaryFixedDim: Color(0xffb1c6f9),
      onSecondaryFixedVariant: Color(0xff304671),
      tertiaryFixed: Color(0xfffdd6ff),
      onTertiaryFixed: Color(0xff340042),
      tertiaryFixedDim: Color(0xfff4aeff),
      onTertiaryFixedVariant: Color(0xff74198b),
      surfaceDim: Color(0xff10131a),
      surfaceBright: Color(0xff363941),
      surfaceContainerLowest: Color(0xff0b0e15),
      surfaceContainerLow: Color(0xff191b23),
      surfaceContainer: Color(0xff1d2027),
      surfaceContainerHigh: Color(0xff272a31),
      surfaceContainerHighest: Color(0xff32353c),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcfdcff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff002455),
      primaryContainer: Color(0xff4d8eff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffcfdcff),
      onSecondary: Color(0xff0a244e),
      secondaryContainer: Color(0xff7b90c0),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffbceff),
      onTertiary: Color(0xff440055),
      tertiaryContainer: Color(0xffc86cdd),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff10131a),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd8dcec),
      outline: Color(0xffadb1c1),
      outlineVariant: Color(0xff8b909f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2ec),
      inversePrimary: Color(0xff004597),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff00102e),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff003475),
      secondaryFixed: Color(0xffd8e2ff),
      onSecondaryFixed: Color(0xff00102e),
      secondaryFixedDim: Color(0xffb1c6f9),
      onSecondaryFixedVariant: Color(0xff1f355f),
      tertiaryFixed: Color(0xfffdd6ff),
      onTertiaryFixed: Color(0xff24002e),
      tertiaryFixedDim: Color(0xfff4aeff),
      onTertiaryFixedVariant: Color(0xff5f0075),
      surfaceDim: Color(0xff10131a),
      surfaceBright: Color(0xff42444c),
      surfaceContainerLowest: Color(0xff05070e),
      surfaceContainerLow: Color(0xff1b1d25),
      surfaceContainer: Color(0xff25282f),
      surfaceContainerHigh: Color(0xff30323a),
      surfaceContainerHighest: Color(0xff3b3d45),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffecefff),
      surfaceTint: Color(0xffadc6ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa7c2ff),
      onPrimaryContainer: Color(0xff000a22),
      secondary: Color(0xffecefff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffadc2f5),
      onSecondaryContainer: Color(0xff000a22),
      tertiary: Color(0xffffeafd),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfff2a8ff),
      onTertiaryContainer: Color(0xff1a0022),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff10131a),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffecefff),
      outlineVariant: Color(0xffbec2d2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2ec),
      inversePrimary: Color(0xff004597),
      primaryFixed: Color(0xffd8e2ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffadc6ff),
      onPrimaryFixedVariant: Color(0xff00102e),
      secondaryFixed: Color(0xffd8e2ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb1c6f9),
      onSecondaryFixedVariant: Color(0xff00102e),
      tertiaryFixed: Color(0xfffdd6ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfff4aeff),
      onTertiaryFixedVariant: Color(0xff24002e),
      surfaceDim: Color(0xff10131a),
      surfaceBright: Color(0xff4d5058),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d2027),
      surfaceContainer: Color(0xff2e3038),
      surfaceContainerHigh: Color(0xff393b43),
      surfaceContainerHighest: Color(0xff44474f),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

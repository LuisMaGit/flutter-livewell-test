import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:core/core_export.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';
import 'package:livewell_test/locator.dart';

class ThemeNotifier extends StateNotifier<LiveWellTheme> {
  ThemeNotifier()
      : super(
          LiveWellTheme(
            colors: LiveWellColorsByTheme.light(),
            theme: AppTheme.light,
            themeData: ThemeData(),
            textStyles: const LiveWellTextStyles(),
          ),
        ) {
    _setTheme(AppTheme.light);
    _themeService.themeController.stream.listen((event) {
      _setTheme(event);
    });
  }

  //di
  final _themeService = locator<ThemeService>();

  LiveWellTextStyles _getTextByColors(
    LiveWellColorsByTheme color,
  ) {
    final base = TextStyle(
      color: color.inverseBackground,
      decoration: TextDecoration.none,
    );
    return LiveWellTextStyles(
      caption: base.copyWith(fontSize: 8),
      body1: base.copyWith(fontSize: 16),
      h1: base.copyWith(fontSize: 32),
    );
  }

  void _setTheme(AppTheme theme) {
    final colors = theme == AppTheme.light
        ? LiveWellColorsByTheme.light()
        : LiveWellColorsByTheme.dark();
    state = state.copyWith(
      colors: colors,
      themeData: ThemeData(
        primaryColor: colors.principal,
        backgroundColor: colors.background,
        canvasColor: colors.background,
        scaffoldBackgroundColor: colors.background,
      ),
      textStyles: _getTextByColors(colors),
    );
  }
}

class LiveWellTheme {
  const LiveWellTheme({
    required this.colors,
    required this.theme,
    required this.themeData,
    required this.textStyles,
  });
  final LiveWellColorsByTheme colors;
  final AppTheme theme;
  final ThemeData themeData;
  final LiveWellTextStyles textStyles;

  LiveWellTheme copyWith({
    LiveWellColorsByTheme? colors,
    AppTheme? theme,
    ThemeData? themeData,
    LiveWellTextStyles? textStyles,
  }) {
    return LiveWellTheme(
      colors: colors ?? this.colors,
      theme: theme ?? this.theme,
      themeData: themeData ?? this.themeData,
      textStyles: textStyles ?? this.textStyles,
    );
  }
}

import 'dart:async';
import 'package:core/core_export.dart';

class ThemeService {
  ThemeService() {
    themeController = StreamController<AppTheme>.broadcast();
  }

  late StreamController<AppTheme> themeController;
  AppTheme? _theme = AppTheme.light;
  AppTheme? get theme => _theme;

  Future<void> setTheme(AppTheme value) async {
    if (value == _theme) {
      return;
    }
    _theme = value;
    themeController.add(value);
  }
}

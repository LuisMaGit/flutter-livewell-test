import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:core/core_export.dart';
import 'package:livewell_test/features/startup/startup_state.dart';
import 'package:livewell_test/locator.dart';

class StartupViewModel extends StateNotifier<StartupState> {
  StartupViewModel() : super(const StartupState()) {
    _conectivityService.isConnected().listen((hasInternet) {
      if (hasInternet &&
          _hideInternetOverlay != null &&
          _isInternetOverlayOpen) {
        _hideInternetOverlayAndSetFlag();
      }

      if (!hasInternet &&
          _showOverlayInternet != null &&
          !_isInternetOverlayOpen) {
        _showInternetOverlayAndSetFlag(firstTime: false);
      }
    });
  }

  //di
  final _themeService = locator<ThemeService>();
  final _conectivityService = locator<IConectivityService>();
  final _quickSnackbarService = locator<QuickSnackbarService>();

  var _isInternetOverlayOpen = false;
  void Function({required bool firstTime})? _showOverlayInternet;
  void Function()? _hideInternetOverlay;

  void _showInternetOverlayAndSetFlag({required bool firstTime}) {
    _showOverlayInternet!(firstTime: firstTime);
    _isInternetOverlayOpen = true;
  }

  void _hideInternetOverlayAndSetFlag() {
    _hideInternetOverlay!();
    _isInternetOverlayOpen = false;
  }

  //events
  void setTheme(AppTheme theme) {
    _themeService.setTheme(theme);
  }

  void registerSnackbar(
    ShowSnackbarCallback callback, {
    String? text,
  }) {
    _quickSnackbarService.registerSnackBars(callback);
  }

  void registerInternatOverlay({
    required void Function({required bool firstTime}) showOverlayInternet,
    required void Function() hideOverlayInternet,
  }) {
    _showOverlayInternet = showOverlayInternet;
    _hideInternetOverlay = hideOverlayInternet;
    _showInternetOverlayAndSetFlag(firstTime: true);
  }
}

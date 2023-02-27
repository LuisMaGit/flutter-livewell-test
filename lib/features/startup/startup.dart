import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:core/core_export.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';
import 'package:livewell_test/features/pictures_grid/pictures_grid.dart';
import 'package:livewell_test/features/startup/startup_viewmodel.dart';
import 'package:livewell_test/locator.dart';

class Startup extends HookConsumerWidget {
  const Startup({super.key});

  void _handleTheme(
    Brightness brightness,
    StartupViewModel events,
  ) {
    useEffect(
      () {
        events.setTheme(
          brightness == Brightness.dark ? AppTheme.dark : AppTheme.light,
        );
        return null;
      },
      [brightness],
    );
  }

  void _handleConectivity(
    BuildContext context,
    StartupViewModel events,
  ) {
    void showOverlayInternet({required bool firstTime}) {
      if (firstTime) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context, ConectivityOverlay());
        });
        return;
      }

      Navigator.push(context, ConectivityOverlay());
    }

    void hideOverlayInternet() {
      Navigator.pop(context);
    }

    useEffect(
      () {
        events.registerInternatOverlay(
          showOverlayInternet: showOverlayInternet,
          hideOverlayInternet: hideOverlayInternet,
        );
        return null;
      },
      [],
    );
  }

  void _handleSnackbars(
    BuildContext context,
    StartupViewModel events,
  ) {
    void showSnackbar(
      QuickSnackbar type, {
      String? text,
    }) {
      showLiveWellSnackbar(context, type, text: text);
    }

    useEffect(
      () {
        events.registerSnackbar(showSnackbar);
        return null;
      },
      [],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(startupViewModelProvider.notifier);
    final brightness = MediaQuery.of(context).platformBrightness;
    _handleTheme(brightness, events);
    _handleConectivity(context, events);
    _handleSnackbars(context, events);
    return const PicturesGrid();
  }
}

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';
import 'package:livewell_test/locator.dart';

void showLiveWellSnackbar(
  BuildContext context,
  QuickSnackbar type, {
  String? text,
}) {
  OverlayEntry? previousOverlayEntry;
  OverlayState? overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => LiveWellSnackbar(
      type: type,
      text: text,
      onDismissed: () {
        overlayEntry.remove();
        previousOverlayEntry = null;
      },
    ),
  );
  previousOverlayEntry?.remove();
  overlayState?.insert(overlayEntry);
  previousOverlayEntry = overlayEntry;
}

class LiveWellSnackbar extends StatefulHookConsumerWidget {
  const LiveWellSnackbar({
    required this.type,
    required this.text,
    required this.onDismissed,
    super.key,
  });

  final QuickSnackbar type;
  final String? text;
  final VoidCallback onDismissed;

  @override
  LiveWellSnackbarState createState() => LiveWellSnackbarState();
}

class LiveWellSnackbarState extends ConsumerState<LiveWellSnackbar>
    with SingleTickerProviderStateMixin {
  late Animation offsetAnimation;
  late AnimationController animationController;
  double? bottomPosition;
  final showOutAnimationDuration = const Duration(milliseconds: 250);
  final hideOutAnimationDuration = const Duration(milliseconds: 550);
  final displayDuration = const Duration(milliseconds: 3000);

  @override
  void initState() {
    _setupAndStartAnimation();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _setupAndStartAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: showOutAnimationDuration,
      reverseDuration: hideOutAnimationDuration,
    );
    var offsetTween = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    );

    offsetAnimation = offsetTween.animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.linearToEaseOut,
      ),
    )..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(displayDuration);
          if (mounted) {
            animationController.reverse();
          }
        }

        if (status == AnimationStatus.dismissed) {
          widget.onDismissed.call();
        }
      });

    if (mounted) {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeProvider).colors;
    Widget snackbar(String text) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: kSpace3,
          horizontal: kSpace1,
        ),
        color: colors.inverseBackground,
        alignment: Alignment.center,
        child: LiveWellText.body1(
          text,
          color: colors.background,
        ),
      );
    }

    String textByType() {
      switch (widget.type) {
        case QuickSnackbar.disabled:
          return '';
        case QuickSnackbar.genericError:
          return Sentences.genericError();
        case QuickSnackbar.imageDownloaded:
          return Sentences.snackbarImageDownloaded(widget.text ?? '');
        case QuickSnackbar.storagePermissionDenied:
          return Sentences.snackbarPermissionDenied();
        default:
          return '';
      }
    }

    return AnimatedPositioned(
      duration: hideOutAnimationDuration * 1.5,
      curve: Curves.linearToEaseOut,
      bottom: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: offsetAnimation as Animation<Offset>,
        child: SafeArea(
          child: snackbar(textByType()),
        ),
      ),
    );
  }
}


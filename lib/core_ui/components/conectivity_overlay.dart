import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';
import 'package:livewell_test/locator.dart';

class ConectivityOverlay extends ModalRoute {
  @override
  Color? get barrierColor => LiveWellColors.black.withOpacity(.5);

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return const ConectivityBox();
  }
}

class ConectivityBox extends HookConsumerWidget {
  const ConectivityBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return FractionallySizedBox(
      heightFactor: .3,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colors.contrastBackground,
          boxShadow: kElevationToShadow[5],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kSpace3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child:  LiveWellIcons(
                icon: LiveWeelIconType.noInternet,
                size: 50,
              ),
            ),
            LSpacers.v2,
            Flexible(
              child: LiveWellText.body1(
                Sentences.genericNoInternet(),
                align: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

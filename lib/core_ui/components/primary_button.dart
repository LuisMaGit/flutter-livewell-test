import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';
import 'package:livewell_test/locator.dart';

class PrimaryButton extends HookConsumerWidget {
  const PrimaryButton({
    required this.text,
    required this.onTryAgain,
    this.icon,
    super.key,
  });

  final String text;
  final Widget? icon;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    Widget textWidget() {
      return LiveWellText.body1(
        text,
        color: theme.colors.inverseBackground,
      );
    }

    Widget layout() {
      if (icon != null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            LSpacers.h1,
            Flexible(child: textWidget()),
          ],
        );
      }

      return Center(
        child: textWidget(),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: theme.colors.principal),
      child: RippleButton(
        onTap: onTryAgain,
        child: Padding(
          padding: const EdgeInsets.all(kSpace2),
          child: layout(),
        ),
      ),
    );
  }
}

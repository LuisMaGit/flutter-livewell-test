import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/locator.dart';

class Loader extends HookConsumerWidget {
  const Loader({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? theme.colors.principal,
      ),
    );
  }
}

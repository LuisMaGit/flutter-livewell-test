import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';
import 'package:livewell_test/features/startup/startup.dart';
import 'package:livewell_test/locator.dart';

class LiveWellMaterialApp extends HookConsumerWidget {
  const LiveWellMaterialApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Sentences.appTitle(),
      theme: theme.themeData,
      home: const Startup(),
    );
  }
}

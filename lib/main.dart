import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/livewell_test_material_app.dart';
import 'package:livewell_test/locator.dart';

void main() {
  configureDependencies();
  runApp(const ProviderScope(child: LiveWellMaterialApp()));
}

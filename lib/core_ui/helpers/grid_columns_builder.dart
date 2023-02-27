import 'package:flutter/material.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';

class GridColumnBuilder extends StatelessWidget {
  const GridColumnBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(int count) builder;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: builder(2),
      desktop: builder(4),
    );
  }
}

import 'package:flutter/material.dart';

const kSpace1 = 8.0;
const kSpace2 = 16.0;
const kSpace3 = 24.0;

abstract class LSpacers {
  static const v1 = SizedBox(height: kSpace1);
  static const v2 = SizedBox(height: kSpace2);
  static const v3 = SizedBox(height: kSpace3);
  static const h1 = SizedBox(width: kSpace1);
  static const h2 = SizedBox(width: kSpace2);
  static const h3 = SizedBox(width: kSpace3);
}

class SpacerBottom extends StatelessWidget {
  const SpacerBottom({super.key});
  @override
  Widget build(BuildContext context) {
    final screenInsets = MediaQuery.of(context).padding;
    return SizedBox(height: screenInsets.bottom);
  }
}
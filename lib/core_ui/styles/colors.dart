import 'package:flutter/material.dart';

abstract class LiveWellColors {
  static const greenLiveWell = Color(0XFF00C2A8);
  static const black = Colors.black;
  static const white = Colors.white;
  static final greyShade600 = Colors.grey[600]!;
  static final greyShade400 = Colors.grey[400]!;
}

class LiveWellColorsByTheme {
  factory LiveWellColorsByTheme.light() {
    return LiveWellColorsByTheme(
      background: LiveWellColors.white,
      inverseBackground: LiveWellColors.black,
      principal: LiveWellColors.greenLiveWell,
      contrastBackground: LiveWellColors.greyShade400,
    );
  }
  factory LiveWellColorsByTheme.dark() {
    return LiveWellColorsByTheme(
      background: LiveWellColors.black,
      inverseBackground: LiveWellColors.white,
      principal: LiveWellColors.greenLiveWell,
      contrastBackground: LiveWellColors.greyShade600,
    );
  }
  const LiveWellColorsByTheme({
    required this.principal,
    required this.background,
    required this.inverseBackground,
    required this.contrastBackground,
  });
  final Color principal;
  final Color background;
  final Color inverseBackground;
  final Color contrastBackground;
}

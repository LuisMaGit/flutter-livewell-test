import 'package:flutter/material.dart';

enum LiveWellTextStylesTypes {
  h1,
  body1,
  caption,
}

class LiveWellTextStyles {
  const LiveWellTextStyles({
    this.h1 = const TextStyle(),
    this.body1 = const TextStyle(),
    this.caption = const TextStyle(),
  });
  final TextStyle h1;
  final TextStyle body1;
  final TextStyle caption;
}

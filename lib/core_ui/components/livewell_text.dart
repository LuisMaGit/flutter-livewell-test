import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/core_ui/styles/styles_export.dart';
import 'package:livewell_test/locator.dart';

class LiveWellText extends HookConsumerWidget {
  const LiveWellText.h1(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.align,
    this.textDecoration,
    this.fontStyle,
  })  : styleType = LiveWellTextStylesTypes.h1,
        super(key: key);
  const LiveWellText.body1(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.align,
    this.textDecoration,
    this.fontStyle,
  })  : styleType = LiveWellTextStylesTypes.body1,
        super(key: key);
  const LiveWellText.caption(
    this.text, {
    Key? key,
    this.color,
    this.maxLines,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.align,
    this.textDecoration,
    this.fontStyle,
  })  : styleType = LiveWellTextStylesTypes.caption,
        super(key: key);

  final String text;
  final LiveWellTextStylesTypes styleType;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final TextAlign? align;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    TextStyle getStyle() {
      switch (styleType) {
        case LiveWellTextStylesTypes.h1:
          return theme.textStyles.h1;
        case LiveWellTextStylesTypes.body1:
          return theme.textStyles.body1;
        case LiveWellTextStylesTypes.caption:
          return theme.textStyles.caption;
      }
    }

    final style = getStyle().copyWith(
      color: color ?? getStyle().color,
      fontWeight: fontWeight ?? getStyle().fontWeight,
      fontSize: fontSize ?? getStyle().fontSize,
      fontFamily: fontFamily ?? getStyle().fontFamily,
      decoration: textDecoration ?? getStyle().decoration,
      fontStyle: fontStyle ?? getStyle().fontStyle,
    );

    final overflow = maxLines != null ? TextOverflow.ellipsis : null;
    final textAlign = align ?? TextAlign.left;
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: style,
    );
  }
}

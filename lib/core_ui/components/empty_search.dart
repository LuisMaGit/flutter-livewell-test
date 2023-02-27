import 'package:flutter/material.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({
    required this.search,
    super.key,
  });

  final String search;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const LiveWellIcons(
          icon: LiveWeelIconType.emptySearch,
          size: 100,
        ),
        LSpacers.v2,
        LiveWellText.body1(
          Sentences.picturesGridFormEmptyResult(search),
        ),
      ],
    );
  }
}

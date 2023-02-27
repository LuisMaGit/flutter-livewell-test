import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';
import 'package:livewell_test/features/picture_details/picture_details.dart';
import 'package:livewell_test/features/pictures_grid/picture_grid_state.dart';
import 'package:livewell_test/locator.dart';
import 'package:visibility_detector/visibility_detector.dart';

part '_components/_search_form.dart';
part '_components/_grid_layout.dart';
part '_components/_picture_card.dart';

class PicturesGrid extends StatelessWidget {
  const PicturesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NullAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpace2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SearchForm(),
            Expanded(child: _GridLayout()),
          ],
        ),
      ),
    );
  }
}

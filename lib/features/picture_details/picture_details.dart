import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';
import 'package:livewell_test/locator.dart';
part '_components/_header.dart';
part '_components/_picture.dart';
part '_components/_submit.dart';

class PictureDetails extends StatelessWidget {
  const PictureDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NullAppbar(),
      body: HookConsumer(
        builder: (context, ref, _) {
          final picture = ref.watch(pictureDetailsViewModelProvider).picture;
          return DecoratedBox(
            decoration: BoxDecoration(color: Color(picture.flutterColor)),
            child: Column(
              children: const [
                _Header(),
                Expanded(child: _Picture()),
                _SubmitButton(),
                SpacerBottom(),
              ],
            ),
          );
        },
      ),
    );
  }
}


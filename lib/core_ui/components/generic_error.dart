import 'package:flutter/material.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';

class GenericError extends StatelessWidget {
  const GenericError({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const LiveWellIcons(
          icon: LiveWeelIconType.error,
          size: 100,
        ),
        LSpacers.v2,
        LiveWellText.body1(
          Sentences.genericError(),
        ),
        LSpacers.v2,
        SizedBox(
          width: 200,
          child: PrimaryButton(
            text: Sentences.genericErrorTryAgain(),
            onTryAgain: onTap,
          ),
        ),
      ],
    );
  }
}

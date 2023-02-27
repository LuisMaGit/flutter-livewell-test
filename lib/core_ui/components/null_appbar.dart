import 'package:flutter/material.dart';
import 'package:livewell_test/core_ui/styles/colors.dart';

class NullAppbar extends PreferredSize {
  const NullAppbar({
    Key? key,
  }) : super(
          key: key,
          child: const SizedBox(),
          preferredSize: const Size(0, 0),
        );
        

  @override
  Size get preferredSize => const Size.fromHeight(0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: LiveWellColors.black,
    );
  }
}
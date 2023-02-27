import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/core_ui/core_ui_export.dart';

class NetworkPicture extends HookConsumerWidget {
  const NetworkPicture({
    required this.url,
    this.sizeIcon = 32,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    super.key,
  });

  final String url;
  final double sizeIcon;
  final BoxFit fit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget wrapperIcon(LiveWeelIconType icon) {
      return _Wrapper(
        height: height,
        width: width,
        child: LiveWellIcons(
          icon: icon,
          size: sizeIcon,
        ),
      );
    }

    return Image.network(
      url,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, _, __) {
        return wrapperIcon(LiveWeelIconType.brokenImage);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return wrapperIcon(LiveWeelIconType.loadingImage);
      },
    );
  }
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({
    required this.child,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  final double? height;
  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}

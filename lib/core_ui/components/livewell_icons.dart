import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/locator.dart';

enum LiveWeelIconType {
  search,
  close,
  brokenImage,
  loadingImage,
  error,
  arrowBack,
  download,
  noInternet,
}

const _iconMap = {
  LiveWeelIconType.search: Icons.search_sharp,
  LiveWeelIconType.close: Icons.close_sharp,
  LiveWeelIconType.brokenImage: Icons.broken_image_sharp,
  LiveWeelIconType.loadingImage: Icons.image_search_sharp,
  LiveWeelIconType.error: Icons.error_outline_sharp,
  LiveWeelIconType.arrowBack: Icons.arrow_back_ios_sharp,
  LiveWeelIconType.download: Icons.download_sharp,
  LiveWeelIconType.noInternet: Icons.signal_wifi_connected_no_internet_4_sharp,
};

class LiveWellIcons extends HookConsumerWidget {
  const LiveWellIcons({
    required this.icon,
    this.color,
    this.size = 16,
    super.key,
  });

  final double size;
  final LiveWeelIconType icon;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Icon(
      _iconMap[icon],
      color: color ?? ref.watch(themeProvider).colors.inverseBackground,
      size: size,
    );
  }
}

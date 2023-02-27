import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  desktop,
}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.mobile,
    this.desktop,
    Key? key,
  }) : super(key: key);

  final Widget mobile;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return _ScreenSizeBuilder(
      builder: (context, deviceType) {
        if (deviceType == DeviceType.desktop) {
          if (desktop != null) return desktop!;
        }

        return mobile;
      },
    );
  }
}

class _ScreenSizeBuilder extends StatelessWidget {
  const _ScreenSizeBuilder({
    required this.builder,
    Key? key,
  }) : super(key: key);

  final Widget Function(BuildContext context, DeviceType device) builder;

  @override
  Widget build(BuildContext context) {
    DeviceType getDeviceType() {
      final w = MediaQuery.of(context).size.width;

      if (w >= 720) {
        return DeviceType.desktop;
      }

      return DeviceType.mobile;
    }

    return builder(context, getDeviceType());
  }
}

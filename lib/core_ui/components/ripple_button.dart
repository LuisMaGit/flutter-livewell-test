import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  const RippleButton({
    required this.child,
    this.onTap,
    this.color = Colors.transparent,
    this.disable = false,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final bool disable;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return disable
        ? DecoratedBox(
            decoration: BoxDecoration(
              color: color,
            ),
            child: child,
          )
        : Material(
            color: color,
            child: InkWell(
              onTap: onTap,
              child: child,
            ),
          );
  }
}
part of '../pictures_grid.dart';

class _PictureCard extends StatelessWidget {
  const _PictureCard({
    required this.index,
    required this.url,
    required this.color,
    required this.onTapPicture,
  });

  final int index;
  final String url;
  final Color color;
  final void Function(int idx) onTapPicture;

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onTap: () => onTapPicture(index),
      child: Hero(
        tag: WidgetKeys.picture(url),
        child: NetworkPicture(
          url: url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

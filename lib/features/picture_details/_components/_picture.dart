part of '../picture_details.dart';

class _Picture extends HookConsumerWidget {
  const _Picture();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picture = ref.watch(pictureDetailsViewModelProvider).picture;
    final transformationController = useTransformationController();
    final doubleTapDetails = useState<TapDownDetails>(TapDownDetails());

    void onDoubleTap() {
      if (transformationController.value != Matrix4.identity()) {
        transformationController.value = Matrix4.identity();
      } else {
        final position = doubleTapDetails.value.localPosition;
        transformationController.value = Matrix4.identity()
          ..translate(-position.dx * 2, -position.dy * 2)
          ..scale(3.0);
      }
    }

    void onDoubleTapDown(TapDownDetails details) {
      doubleTapDetails.value = details;
    }

    return Container(
      color: Color(picture.flutterColor),
      child: Hero(
        tag: WidgetKeys.picture(picture.urlMedium),
        child: GestureDetector(
          onDoubleTap: onDoubleTap,
          onDoubleTapDown: onDoubleTapDown,
          child: InteractiveViewer(
            transformationController: transformationController,
            child: NetworkPicture(
              url: picture.urlMedium,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
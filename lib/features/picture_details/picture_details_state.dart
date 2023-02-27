import 'package:core/core_export.dart';

class PictureDetailsState {
  const PictureDetailsState({
    this.picture = const Picture(),
  });

  final Picture picture;

  PictureDetailsState copyWith({
    Picture? picture,
  }) {
    return PictureDetailsState(
      picture: picture ?? this.picture,
    );
  }
}

import 'package:core/models/picture.dart';

class PictureDto {
  PictureDto({
    this.id,
    this.width,
    this.height,
    this.avgColorHex,
    this.src,
    this.alt,
  });
  factory PictureDto.fromMap(Map<String, dynamic> map) {
    return PictureDto(
      id: map['id'],
      width: map['width'],
      height: map['height'],
      avgColorHex: map['avg_color'],
      src: map['src'] != null ? SourcePictureDto.fromMap(map['src']) : null,
      alt: map['alt'],
    );
  }
  final int? id;
  final int? width;
  final int? height;
  final String? avgColorHex;
  final SourcePictureDto? src;
  final String? alt;

  Picture toCore() {
    const base = Picture();
    return Picture(
      id: id ?? base.id,
      width: width ?? base.width,
      height: height ?? base.height,
      avgColorHex: avgColorHex ?? base.avgColorHex,
      urlMedium: src?.medium ?? base.urlMedium,
      urlOriginal: src?.original ?? base.urlOriginal,
      name: alt ?? base.name,
    );
  }
}

class SourcePictureDto {
  SourcePictureDto({
    this.original,
    this.medium,
  });
  factory SourcePictureDto.fromMap(Map<String, dynamic> map) {
    return SourcePictureDto(
      original: map['original'],
      medium: map['medium'],
    );
  }
  final String? original;
  final String? medium;
}

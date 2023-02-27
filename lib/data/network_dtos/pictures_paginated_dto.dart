import 'package:core/core_export.dart';
import 'package:livewell_test/data/data_export.dart';

class PicturesPaginatedDto {
  const PicturesPaginatedDto({
    this.page,
    this.total,
    this.perPage,
    this.picture,
  });
  factory PicturesPaginatedDto.fromMap(Map<String, dynamic> map) {
    return PicturesPaginatedDto(
      page: map['page'],
      total: map['total'],
      perPage: map['per_page'],
      picture: map['photos'] != null
          ? List<PictureDto>.from(
              (map['photos']).map((x) => PictureDto.fromMap(x)),
            )
          : null,
    );
  }


  final int? page;
  final int? total;
  final int? perPage;
  final List<PictureDto>? picture;

  PicturesPaginated toCore() {
    const base = PicturesPaginated();
    return PicturesPaginated(
      page: page ?? base.page,
      total: total ?? base.total,
      perPage: perPage ?? base.perPage,
      pictures: picture == null
          ? base.pictures
          : picture!.map((e) => e.toCore()).toList(),
    );
  }
}

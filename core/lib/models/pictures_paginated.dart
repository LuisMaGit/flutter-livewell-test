import 'package:core/models/picture.dart';

class PicturesPaginated {
  const PicturesPaginated({
     this.page = 0,
     this.total = 0,
     this.perPage = 0,
     this.pictures = const [],
  });
  final int page;
  final int total;
  final int perPage;
  final List<Picture> pictures;


  @override
  String toString() {
    return 'PicturesPaginated(page: $page, total: $total, perPage: $perPage, pictures: $pictures)';
  }
}

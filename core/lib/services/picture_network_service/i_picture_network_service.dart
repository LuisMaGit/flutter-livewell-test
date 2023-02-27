import 'package:core/models/pictures_paginated.dart';

abstract class IPictureNetworkService {
  Future<PicturesPaginated?> getPictures({
    required String query,
    required int page,
    required int perPage,
  });
}

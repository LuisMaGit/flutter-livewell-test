import 'package:dio/dio.dart';
import 'package:core/core_export.dart';
import 'package:livewell_test/data/network_dtos/pictures_paginated_dto.dart';
import 'package:livewell_test/locator.dart';

class PictureNetworkService implements IPictureNetworkService {
  final _envService = locator<IEnvironmentService>();
  final _dio = Dio();

  @override
  Future<PicturesPaginated?> getPictures({
    required String query,
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await _dio.get(
        PictureEnpoints.queryEndpoint,
        queryParameters: {
          'query': query,
          'page': page,
          'per_page': perPage,
        },
        options: Options(
          headers: NetworkHeaders.authorization(
            await _envService.getPexelsApiKey() ?? '',
          ),
        ),
      );
      if (response.statusCode != StatusCode.success) {
        return null;
      }

      return PicturesPaginatedDto.fromMap(response.data).toCore();
    } on Exception {
      return null;
    }

  }
}

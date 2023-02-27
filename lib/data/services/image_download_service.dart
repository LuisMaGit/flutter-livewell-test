import 'package:dio/dio.dart';
import 'package:core/core_export.dart';

class ImageDownloadService implements IImageDownloadService {
  final _dio = Dio();

  @override
  Future<bool> download({
    required String url,
    required String storePath,
  }) async {
    try {
      await _dio.download(
        url,
        storePath,
      );     
      return true;
    } catch (e) {
      return false;
    }
  }
}

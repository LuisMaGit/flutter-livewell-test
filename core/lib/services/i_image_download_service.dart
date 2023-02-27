abstract class IImageDownloadService {
  Future<bool> download({
    required String url,
    required String storePath,
  });
}

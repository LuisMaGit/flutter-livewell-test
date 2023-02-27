import 'package:gallery_saver/gallery_saver.dart';
import 'package:core/core_export.dart';

class ImageSaveGalleryService implements IImageSaveGalleryService {
  @override
  Future<bool> save({required String path, required String album}) async {
    return await GallerySaver.saveImage(
          path,
          albumName: album,
        ) ??
        false;
  }
}

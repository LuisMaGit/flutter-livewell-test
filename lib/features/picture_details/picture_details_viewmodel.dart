import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:core/core_export.dart';
import 'package:livewell_test/features/picture_details/picture_details_state.dart';
import 'package:livewell_test/locator.dart';

class PictureDetailsViewModel extends StateNotifier<PictureDetailsState> {
  PictureDetailsViewModel({required this.picture})
      : super(PictureDetailsState(picture: picture));

  final Picture picture;

  //di
  final _pathProviderService = locator<IPathProviderService>();
  final _imageDownloadService = locator<IImageDownloadService>();
  final _permissionsService = locator<IPermissionService>();
  final _quickSnackbarService = locator<QuickSnackbarService>();
  final _imageSaveGallerySerice = locator<IImageSaveGalleryService>();

  //events
  Future<void> download() async {
    //permission storage
    final permissionGranted =
        await _permissionsService.handlePictureStoragePermission();
    if (!permissionGranted) {
      _quickSnackbarService.showSnackbar(
        QuickSnackbar.storagePermissionDenied,
      );
      return;
    }

    // path
    final storePath = await _pathProviderService.getTemporaryPath();
    if (storePath == null) {
      _quickSnackbarService.showSnackbar(
        QuickSnackbar.genericError,
      );
      return;
    }

    //download
    final temporaryImagePath = ImageNaming.buildPicturePath(storePath);
    await _imageDownloadService.download(
      url: picture.urlMedium,
      storePath: temporaryImagePath,
    );

    //save in gallery
    final galleryResp = await _imageSaveGallerySerice.save(
      path: temporaryImagePath,
      album: ImageNaming.galleryAlbumName,
    );
    if (!galleryResp) {
      _quickSnackbarService.showSnackbar(
        QuickSnackbar.genericError,
      );
      return;
    }
    _quickSnackbarService.showSnackbar(
      QuickSnackbar.imageDownloaded,
      text: ImageNaming.galleryAlbumName,
    );
  }
}

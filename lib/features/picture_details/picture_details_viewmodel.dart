import 'package:core/core_export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livewell_test/features/picture_details/picture_details_state.dart';

class PictureDetailsViewModel extends StateNotifier<PictureDetailsState> {
  PictureDetailsViewModel({
    required IPathProviderService pathProviderService,
    required IImageDownloadService imageDownloadService,
    required IPermissionService permissionsService,
    required QuickSnackbarService quickSnackbarService,
    required IImageSaveGalleryService imageSaveGallerySerice,
    required this.picture,
  })  : _pathProviderService = pathProviderService,
        _imageDownloadService = imageDownloadService,
        _permissionsService = permissionsService,
        _quickSnackbarService = quickSnackbarService,
        _imageSaveGallerySerice = imageSaveGallerySerice,
        super(PictureDetailsState(picture: picture));

  //di
  final Picture picture;
  final IPathProviderService _pathProviderService;
  final IImageDownloadService _imageDownloadService;
  final IPermissionService _permissionsService;
  final QuickSnackbarService _quickSnackbarService;
  final IImageSaveGalleryService _imageSaveGallerySerice;

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

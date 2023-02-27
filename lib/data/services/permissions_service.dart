import 'package:core/core_export.dart';
import 'package:livewell_test/locator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService implements IPermissionService {
  final _platformService = locator<IPlatformService>();

  Future<bool> _isStoragePermissionGranted() async {
    final platform = _platformService.getPlatform();
    try {
      if (platform == SupportedPlatforms.android) {
        return await Permission.storage.isGranted;
      }
      if (platform == SupportedPlatforms.ios) {
        return await Permission.photos.isGranted;
      }
      return false;
    } catch (e) {
      throw CoreExceptions('Storage permission error: $e');
    }
  }

  Future<bool> _requestStoragePermission() async {
    try {
      late final PermissionStatus status;
      final platform = _platformService.getPlatform();
      if (platform == SupportedPlatforms.android) {
        status = await Permission.storage.request();
      }
      if (platform == SupportedPlatforms.ios) {
        status = await Permission.photos.request();
      }
      if (status.isPermanentlyDenied) {
        await openAppSettings();
      }
      return status == PermissionStatus.limited ||
          status == PermissionStatus.granted;
    } catch (e) {
      throw CoreExceptions('Storage permission error: $e');
    }
  }

  @override
  Future<bool> handlePictureStoragePermission() async {
    if (!await _isStoragePermissionGranted()) {
      return await _requestStoragePermission();
    }

    return true;
  }
}

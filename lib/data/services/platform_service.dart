import 'dart:io';
import 'package:core/core_export.dart';

class PlatformService extends IPlatformService {
  @override
  SupportedPlatforms getPlatform() {
    if (Platform.isAndroid) {
      return SupportedPlatforms.android;
    }

    if (Platform.isIOS) {
      return SupportedPlatforms.ios;
    }
    
    throw CoreExceptions('${Platform.operatingSystem} is not supported');
  }

  @override
  bool isPlatformSuported() {
    return Platform.isAndroid && Platform.isIOS;
  }
}

import 'package:core/contracts/contracts_export.dart';

abstract class IPlatformService {
  SupportedPlatforms getPlatform();
  bool isPlatformSuported();
}

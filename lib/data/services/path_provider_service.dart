import 'package:core/core_export.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class PathProviderService implements IPathProviderService {
  @override
  Future<String?> getTemporaryPath() async {
    try {
      final directory = await path_provider.getTemporaryDirectory();
      return directory.path;
    } catch (e) {
      throw CoreExceptions('Path error: $e');
    }
  }
}

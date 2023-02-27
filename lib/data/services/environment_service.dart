import 'package:core/core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentService implements IEnvironmentService {
  EnvironmentService() {
    dotenv.load();
  }

  @override
  Future<String?> getPexelsApiKey() async {
    return dotenv.env['PEXELS_API_KEY'];
  }
}

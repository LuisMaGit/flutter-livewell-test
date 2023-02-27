import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core_export.dart';

class ConectivityService implements IConectivityService {
  @override
  Stream<bool> isConnected() {
    return Connectivity()
        .onConnectivityChanged
        .map((event) => event != ConnectivityResult.none);
  }
}

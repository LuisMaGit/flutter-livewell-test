import 'package:core/contracts/contracts_export.dart';

typedef ShowSnackbarCallback = void Function(
  QuickSnackbar type, {
  String? text,
});

class QuickSnackbarService {
  ShowSnackbarCallback? _showSnackbar;

  void registerSnackBars(ShowSnackbarCallback callback) {
    _showSnackbar = null;
    _showSnackbar = callback;
  }

  void showSnackbar(QuickSnackbar type, {String? text}) {
    if (_showSnackbar == null) {
      return;
    }
    _showSnackbar!(type, text: text);
  }
}

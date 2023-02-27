abstract class Sentences {
  static String appTitle() => 'LiveWell Test';
  static String genericError() => 'Ups, something went wrong';
  static String genericErrorTryAgain() => 'Try again';
  static String genericNoInternet() => 'No internet connection';
  static String picturesGridFormHint() => 'Search for something awesome...';
  static String picturesGridScreenDescription() => 'Pictures from pexels.com';
  static String picturesGridFormSearchButton() => 'Search';
  static String picturesGridFormEmptyResult(String value) =>
      'No pictures found for "$value", sorry';
  static String pictureDetailsDownloadButton() => 'Download';
  static String pictureDetailsDownloadSuccess(String location) =>
      'Picture downloaded in: $location';
  static String pictureDetailsDownloadCopyPath() => 'Copy path';
  static String snackbarImageDownloaded(String text) => 'Image saved in album "$text"';
  static String snackbarPermissionDenied() => 'Storage permission denied';
}

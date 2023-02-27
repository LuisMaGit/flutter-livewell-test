abstract class ImageNaming {
  static String _dateFootPrint() {
    final now = DateTime.now();
    return '${now.year}_${now.month}_${now.day}_${now.minute}_${now.second}_${now.millisecond}';
  }

  static String buildPicturePath(String storePath) {
    return '$storePath/pexels_${_dateFootPrint()}.jpg';
  }

  static String galleryAlbumName = 'Pexel pictures';
}

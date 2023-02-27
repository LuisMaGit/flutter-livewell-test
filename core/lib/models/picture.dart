class Picture {
  const Picture({
    this.id = 0,
    this.width = 0,
    this.height = 0,
    this.avgColorHex = '',
    this.urlMedium = '',
    this.urlOriginal = '',
    this.name = '',
  });
  final int id;
  final int width;
  final int height;
  final String avgColorHex;
  final String urlMedium;
  final String urlOriginal;
  final String name;

  int get flutterColor {
    final color = avgColorHex.replaceAll(RegExp(r'#'), '0XFF');
    const def = 0XFFFFFF;
    try {
      return int.tryParse(color) ?? def;
    } on Exception {
      return def;
    }
  }

  @override
  String toString() {
    return 'Picture(id: $id, width: $width, height: $height, avgColorHex: $avgColorHex, urlMedium: $urlMedium, urlOriginal: $urlOriginal, name: $name)';
  }
}

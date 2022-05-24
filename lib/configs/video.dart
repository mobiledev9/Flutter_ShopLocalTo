class Videos{
  static const String Background1 = "assets/videos/waves.mp4";
  static final Videos _instance = Videos._internal();

  factory Videos() {
    return _instance;
  }

  Videos._internal();
}

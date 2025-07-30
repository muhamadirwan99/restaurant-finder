class Endpoints {
  Endpoints._();

  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 30);

  static const String list = "/list";
  static const String detail = "/detail";
  static const String search = "/search";
  static const String review = "review";
  static const String smallImage = "images/small/";
  static const String mediumImage = "images/medium/";
  static const String largeImage = "images/large/";
}

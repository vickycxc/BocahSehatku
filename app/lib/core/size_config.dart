import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double safeScreenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init (BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    double topPadding = _mediaQueryData!.padding.top;
    double bottomPadding = _mediaQueryData!.padding.bottom;
    safeScreenHeight = screenHeight - topPadding - bottomPadding;
    orientation = _mediaQueryData!.orientation;
  }
}

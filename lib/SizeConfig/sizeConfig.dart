
import 'package:flutter/widgets.dart';

///Another work in progress
///Originally adapted from the DevCam boy but i made some changes to make it feel my needs better 
///email: paviemabiala@gmail.com
///instagram: emilecode
///website: emilecode.com
class SizeConfig {
  static MediaQueryData _mediaQueryData;
  ///this is the width of the screen
  static double screenWidth;
  ///this is the height of the screen
  static double screenHeight;
  /// This is 1% of the screen on the horizontal without considering the safe Area
  static double horizontalBloc;
  /// This is 1% of the screen on the vertical without considering the safe Area
  static double verticalBloc;
  //for my internal use 
  static double _safeAreaHorizontal;
  //for my internal use
  static double _safeAreaVertical;
  /// This is 1% of the screen on the horizontal by considering the safe Area
  static double safeBlockHorizontal;
  /// This is 1% of the screen on the vertical by considering the safe Area
  static double safeBlockVertical;

  ///Use this Only once inside the build method, preferably on the 1st screen and never call it again during the life time of your app
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    horizontalBloc = screenWidth / 100;
    verticalBloc = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

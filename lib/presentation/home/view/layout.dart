import 'package:flutter/material.dart';

abstract class Breakpoints {
  static const double mobile = 640;
  static const double tablet = 960;
  static const double wide = 1360;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  bool get isMobile => screenWidth < Breakpoints.mobile;
  bool get isTablet => screenWidth >= Breakpoints.mobile && screenWidth < Breakpoints.tablet;
  bool get isDesktop => screenWidth >= Breakpoints.tablet;
  bool get isMobileOrTablet => screenWidth < Breakpoints.tablet;
  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);
}

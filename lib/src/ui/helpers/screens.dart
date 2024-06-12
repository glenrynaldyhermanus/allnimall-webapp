import 'package:flutter/material.dart';

class AMScreens {
  static late BuildContext _appContext;

  static AMScreens of(BuildContext context) {
    var screens = AMScreens();
    _appContext = context;
    return screens;
  }

  bool get isMobile {
    final screenWidth = MediaQuery.of(_appContext).size.width;
    // Define a threshold to determine if the app is running on mobile
    const screenWidthThreshold = 600.0; // Adjust this value as needed

    // Return true if screen width is less than the threshold, indicating a mobile device
    return screenWidth < screenWidthThreshold;
  }

  bool get isTab {
    final screenWidth = MediaQuery.of(_appContext).size.width;
    // Define a threshold to determine if the app is running on mobile
    const screenWidthThreshold = 1200.0; // Adjust this value as needed

    // Return true if screen width is less than the threshold, indicating a mobile device
    return screenWidth < screenWidthThreshold;
  }

  bool get isDesktop {
    // Return true if not running on mobile, indicating a web platform
    final screenWidth = MediaQuery.of(_appContext).size.width;
    // Define a threshold to determine if the app is running on mobile
    const screenWidthThreshold = 1200.0; // Adjust this value as needed

    // Return true if screen width is less than the threshold, indicating a mobile device
    return screenWidth >= screenWidthThreshold;
  }
}

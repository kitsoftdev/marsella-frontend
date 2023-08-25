import 'package:flutter/material.dart';

import '../constants.dart';

class MarsellaScreen {
  static bool screenIsSmallSize(BuildContext context) {
    if (MediaQuery.of(context).size.width < ScreenSize.minScreen) {
      return true;
    } else {
      return false;
    }
  }

  static bool screenIsNormalSize(BuildContext context) {
    if (MediaQuery.of(context).size.width < ScreenSize.maxScreen) {
      return true;
    } else {
      return false;
    }
  }

  static bool screenIsBigSize(BuildContext context) {
    if (MediaQuery.of(context).size.width > ScreenSize.maxScreen) {
      return true;
    } else {
      return false;
    }
  }
}

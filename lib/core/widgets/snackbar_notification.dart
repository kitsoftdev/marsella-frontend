import 'package:flutter/material.dart';
import 'package:marsellafrontend/core/themes/marsella_text_styles.dart';

import '../constants.dart';
import '../themes/marsella_themedata.dart';

class MarsellaSnackBarData {
  final Color textColor;
  final Color borderColor;
  final Color closeIconColor;
  final Color backgroundColor;

  const MarsellaSnackBarData(
      {required this.textColor,
      required this.borderColor,
      required this.closeIconColor,
      required this.backgroundColor});
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarNotify(
    BuildContext context, String message, IconData? icon) {
  final shTheme = MarsellaTheme.of(context).snackBarData;
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.all(16),
      closeIconColor: shTheme.closeIconColor,
      backgroundColor: shTheme.backgroundColor,
      content: Row(
        children: [
          Icon(
            icon,
            color: shTheme.textColor,
          ),
          const SizedBox(width: 4),
          Text(
            message,
            style: MarsellaTextStyles.textSnackBar(shTheme.textColor),
          )
        ],
      ),
      duration: const Duration(milliseconds: snackBarConfig.snackbarDuration),
    ),
  );
}

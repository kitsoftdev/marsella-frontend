import 'package:flutter/material.dart';
import 'package:marsellafrontend/core/widgets/marsella_texts.dart';

import '../widgets/marsella_buttons.dart';
import '../widgets/marsella_inputs.dart';
import '../widgets/marsella_post_widgets.dart';
import '../widgets/marsella_selectors.dart';
import '../widgets/marsella_widgets.dart';
import '../widgets/snackbar_notification.dart';

class MarsellaThemeData {
  late ThemeData themeData; // important!
  final Color backGroundColor;
  final Color iconMenuColor;
  final Color errorColor;
  final Color textColor;
  final MarsellaButtonData sideMenuButtonData;
  final MarsellaButtonData postFavoriteButtonData;
  final MarsellaButtonData postBookmarkButtonData;
  final MarsellaButtonData postCommentButtonData;
  final MarsellaButtonData postShareButtonData;
  final MarsellaButtonData postDownloadButtonData;
  final MarsellaButtonData postVoteNegativeButtonData;
  final MarsellaButtonData postVotePositiveButtonData;
  final MarsellaButtonData onlyTextButton;
  final MarsellaButtonData cancelIconTextButton;
  final MarsellaButtonData okIconTextButton;
  final MarsellaButtonData textWithoutUnderlineButton;
  final MarsellaButtonData selectFileButtonData;
  final MarsellaButtonData loginButtonData;
  final MarsellaButtonData loginSocialButtonData;
  final MarsellaInputData sideMenuInputSearchData;
  final MarsellaTextData textData;
  final MarsellaDropdownData sideMenuDropdownData;
  final MarsellaPostData postData;
  final MarsellaInputData postInputData;
  final MarsellaCheckboxData checkBoxData;
  final MarsellaInputData loginInputData;
  final MarsellaSnackBarData snackBarData;
  final MarsellaCircularIndicatorData circularProgressIndicatorData;
  final MarsellaAlertDialogData alertDialogData;
  final MarsellaTagInputData tagInputData;
  final MarsellaToggleData toggleData;

  MarsellaThemeData copyWith(Color backgroundColor) {
    return MarsellaThemeData(
        themeData: themeData,
        backGroundColor: backgroundColor,
        iconMenuColor: iconMenuColor,
        sideMenuButtonData: sideMenuButtonData,
        postFavoriteButtonData: postFavoriteButtonData,
        postBookmarkButtonData: postBookmarkButtonData,
        postCommentButtonData: postCommentButtonData,
        postShareButtonData: postShareButtonData,
        postDownloadButtonData: postDownloadButtonData,
        postVoteNegativeButtonData: postVoteNegativeButtonData,
        postVotePositiveButtonData: postVotePositiveButtonData,
        sideMenuInputSearchData: sideMenuInputSearchData,
        textData: textData,
        sideMenuDropdownData: sideMenuDropdownData,
        postData: postData,
        postInputData: postInputData,
        onlyTextButton: onlyTextButton,
        cancelIconTextButton: cancelIconTextButton,
        okIconTextButton: okIconTextButton,
        checkBoxData: checkBoxData,
        textWithoutUnderlineButton: textWithoutUnderlineButton,
        selectFileButtonData: selectFileButtonData,
        loginButtonData: loginButtonData,
        loginInputData: loginInputData,
        loginSocialButtonData: loginSocialButtonData,
        snackBarData: snackBarData,
        circularProgressIndicatorData: circularProgressIndicatorData,
        alertDialogData: alertDialogData,
        textColor: textColor,
        errorColor: errorColor,
        tagInputData: tagInputData,
        toggleData: toggleData);
  }

  MarsellaThemeData({
    required this.themeData,
    required this.backGroundColor,
    required this.iconMenuColor,
    required this.sideMenuButtonData,
    required this.postFavoriteButtonData,
    required this.postBookmarkButtonData,
    required this.postCommentButtonData,
    required this.postShareButtonData,
    required this.postDownloadButtonData,
    required this.postVoteNegativeButtonData,
    required this.postVotePositiveButtonData,
    required this.sideMenuInputSearchData,
    required this.textData,
    required this.sideMenuDropdownData,
    required this.postData,
    required this.postInputData,
    required this.onlyTextButton,
    required this.cancelIconTextButton,
    required this.okIconTextButton,
    required this.checkBoxData,
    required this.textWithoutUnderlineButton,
    required this.selectFileButtonData,
    required this.loginButtonData,
    required this.loginInputData,
    required this.loginSocialButtonData,
    required this.snackBarData,
    required this.circularProgressIndicatorData,
    required this.alertDialogData,
    required this.textColor,
    required this.errorColor,
    required this.tagInputData,
    required this.toggleData,
  });
}

class InheritedMarsellaTheme extends InheritedWidget {
  final MarsellaThemeData data;
  const InheritedMarsellaTheme({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(
          key: key,
          child: child,
        );
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget != this;
}

class MarsellaTheme extends StatelessWidget {
  final MarsellaThemeData marsellaTheme;

  final Widget child;
  const MarsellaTheme({
    required this.marsellaTheme,
    required this.child,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = marsellaTheme;

    return InheritedMarsellaTheme(
      data: data,
      child: Theme(
        data: data.themeData,
        child: child,
      ),
    );
  }

  static MarsellaThemeData of(BuildContext context) {
    final theme = Theme.of(context);
    return context
        .dependOnInheritedWidgetOfExactType<InheritedMarsellaTheme>()!
        .data
      ..themeData = theme;
  }
}

class CustomWidgetData {
  final Color backgroundColor;
  final BoxShape shape;
  const CustomWidgetData({
    required this.backgroundColor,
    required this.shape,
  });
}

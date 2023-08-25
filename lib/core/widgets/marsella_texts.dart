import 'package:flutter/material.dart';
import 'package:marsellafrontend/core/themes/marsella_text_styles.dart';

import '../themes/marsella_themedata.dart';

class MarsellaTextData {
  final Color textColor;
  final Color textTitlePageColor;
  final Color iconTitlePageColor;
  final Color strongTextColor;
  final Color subTextColor;
  final Color formFieldTopLabelColor;

  const MarsellaTextData({
    required this.textColor,
    required this.textTitlePageColor,
    required this.iconTitlePageColor,
    required this.strongTextColor,
    required this.subTextColor,
    required this.formFieldTopLabelColor,
  });
}

class MarsellaSideMenuSubtitle extends StatelessWidget {
  const MarsellaSideMenuSubtitle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).textData;
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 11),
      child: Text(
        text,
        style: MarsellaTextStyles.textSubtitle(shThemeData.textColor),
      ),
    );
  }
}

class MarsellaPageTitle extends StatelessWidget {
  const MarsellaPageTitle({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).textData;
    return Row(
      children: [
        Icon(
          Icons.arrow_downward_rounded,
          color: shThemeData.iconTitlePageColor,
          size: 17,
        ),
        Container(
          padding: const EdgeInsets.only(left: 7.0),
          child: Text(
            text,
            style:
                MarsellaTextStyles.textPageTitle(shThemeData.textTitlePageColor),
          ),
        ),
      ],
    );
  }
}

class MarsellaPostUserName extends StatelessWidget {
  const MarsellaPostUserName({
    super.key,
    required this.username,
  });
  final String username;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).textData;

    return Container(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Text(username,
            style: MarsellaTextStyles.textButtonLabel(shThemeData.textColor)));
  }
}

class MarsellaFormFieldTopLabel extends StatelessWidget {
  const MarsellaFormFieldTopLabel({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).textData;
    return Text(text,
        style:
            MarsellaTextStyles.textSubtitle(shThemeData.formFieldTopLabelColor));
  }
}

class MarsellaStrongText extends StatelessWidget {
  const MarsellaStrongText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).textData;
    return Text(text,
        style: MarsellaTextStyles.textButtonLabel(shThemeData.textColor));
  }
}

class MarsellaRegularText extends StatelessWidget {
  const MarsellaRegularText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).textData;
    return Text(text,
        style: MarsellaTextStyles.textRegular(shThemeData.textColor));
  }
}

class MarsellaErrorText extends StatelessWidget {
  const MarsellaErrorText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context);
    return Text(text,
        style: MarsellaTextStyles.textStrongError(shThemeData.errorColor));
  }
}

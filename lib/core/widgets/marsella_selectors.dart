import 'package:flutter/material.dart';
import 'package:marsellafrontend/core/widgets/marsella_icons.dart';
import 'package:marsellafrontend/core/themes/marsella_colors.dart';
import 'package:marsellafrontend/core/themes/marsella_text_styles.dart';

import '../themes/marsella_themedata.dart';

class MarsellaDropdownData {
  final Color normalTextColor;
  final Color normalBackgroundColor;
  final Color normalBorderColor;
  final Color normalIconColor;
  final Color hoverTextColor;
  final Color hoverBackgroundColor;
  final Color hoverBorderColor;
  final Color hoverIconColor;

  const MarsellaDropdownData({
    required this.normalTextColor,
    required this.normalBackgroundColor,
    required this.normalBorderColor,
    required this.normalIconColor,
    required this.hoverTextColor,
    required this.hoverBackgroundColor,
    required this.hoverBorderColor,
    required this.hoverIconColor,
  });
}

class MarsellaSideMenuSelectTheme extends StatelessWidget {
  const MarsellaSideMenuSelectTheme({
    super.key,
    required this.primaryColor,
    required this.active,
    required this.onPressed,
  });
  final Color primaryColor;
  final bool active;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context);
    Color borderColor = shThemeData
        .onlyTextButton.normalBorderColor; //MarsellaColors.marsellaBlack20;
    double width = 2;
    if (active) {
      borderColor = shThemeData
          .loginButtonData.normalBorderColor; //MarsellaColors.marsellaGreen;
      width = 4;
    }

    BorderSide borderSide = BorderSide(
        color: borderColor, // Borde verde
        width: width, // Grosor del borde
        style: BorderStyle.solid);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 30,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
            shadowColor: Colors.transparent,
            shape: const CircleBorder(), // Forma circular
            backgroundColor: primaryColor, // Fondo blanco
            side: borderSide,
          ),
          child: null,
        ),
      ),
    );
  }
}

class MarsellaSideMenuDropdown extends StatefulWidget {
  const MarsellaSideMenuDropdown({
    super.key,
    required this.items,
    required this.value,
    this.onChanged,
  });
  final List<DropdownMenuItem<String>>? items;
  final String? value;

  final Function(String?)? onChanged;

  @override
  State<MarsellaSideMenuDropdown> createState() =>
      _MarsellaSideMenuDropdownState();
}

class _MarsellaSideMenuDropdownState extends State<MarsellaSideMenuDropdown> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).sideMenuDropdownData;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        height: 39,
        decoration: BoxDecoration(
          color: _isHovered
              ? shThemeData.hoverBackgroundColor
              : shThemeData.normalBackgroundColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: DropdownButton(
          dropdownColor: shThemeData.normalBackgroundColor,
          focusColor: shThemeData.hoverBackgroundColor,
          value: widget.value,
          items: widget.items,
          iconSize: 22,
          autofocus: true,
          onChanged: widget.onChanged,
          iconEnabledColor: _isHovered
              ? shThemeData.hoverIconColor
              : shThemeData.normalIconColor,
          icon: MarsellaIconDropdown(
              color: _isHovered
                  ? shThemeData.hoverIconColor
                  : shThemeData.normalIconColor),
          borderRadius: BorderRadius.circular(20),
          style: MarsellaTextStyles.textButtonLabel(_isHovered
              ? shThemeData.hoverTextColor
              : shThemeData.normalTextColor),
          underline: Container(),
        ),
      ),
    );
  }
}

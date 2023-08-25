import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:marsellafrontend/core/themes/marsella_text_styles.dart';
import 'package:marsellafrontend/core/widgets/marsella_icons.dart';

import '../themes/marsella_colors.dart';
import '../themes/marsella_themedata.dart';

class MarsellaButtonData {
  final Color disabledTextColor;
  final Color disabledBackgroundColor;
  final Color disabledBorderColor;
  final Color disabledIconColor;
  final Color normalTextColor;
  final Color normalBackgroundColor;
  final Color normalBorderColor;
  final Color normalIconColor;
  final Color hoverTextColor;
  final Color hoverBackgroundColor;
  final Color hoverBorderColor;
  final Color hoverIconColor;
  final Color activeTextColor;
  final Color activeBackgroundColor;
  final Color activeBorderColor;
  final Color activeIconColor;

  const MarsellaButtonData({
    required this.disabledTextColor,
    required this.disabledBackgroundColor,
    required this.disabledBorderColor,
    required this.disabledIconColor,
    required this.normalTextColor,
    required this.normalBackgroundColor,
    required this.normalBorderColor,
    required this.normalIconColor,
    required this.hoverTextColor,
    required this.hoverBackgroundColor,
    required this.hoverBorderColor,
    required this.hoverIconColor,
    required this.activeTextColor,
    required this.activeBackgroundColor,
    required this.activeBorderColor,
    required this.activeIconColor,
  });
}

class MarsellaSideMenuButton extends StatelessWidget {
  const MarsellaSideMenuButton({
    super.key,
    required this.text,
    required this.active,
    required this.onPressed,
  });
  final bool active;
  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).sideMenuButtonData;

    final backgroundColor = onPressed == null
        ? shThemeData.disabledBackgroundColor
        : active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = onPressed == null
        ? shThemeData.disabledBorderColor
        : active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = onPressed == null
        ? shThemeData.disabledTextColor
        : active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    return Container(
      height: 47,
      padding: const EdgeInsets.only(right: 6, top: 4, bottom: 4, left: 6),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(78, 38)),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return shThemeData
                    .hoverBackgroundColor; // Color de fondo cuando se produce el evento hover
              }
              return backgroundColor; // Mantener el color de fondo predeterminado en otros casos
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: borderColor,
                width: 1,
              ),
            ),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 10, right: 10),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: MarsellaTextStyles.textButtonLabel(textColor),
          ),
        ),
      ),
    );
  }
}

class MarsellaPostFavoriteButtonBar extends StatefulWidget {
  const MarsellaPostFavoriteButtonBar({
    super.key,
    required this.text,
    required this.active,
    this.onPressed,
  });
  final bool active;
  final String text;
  final VoidCallback? onPressed;

  @override
  State<MarsellaPostFavoriteButtonBar> createState() =>
      _MarsellaPostFavoriteButtonBarState();
}

class _MarsellaPostFavoriteButtonBarState
    extends State<MarsellaPostFavoriteButtonBar> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postFavoriteButtonData;

    final backgroundColor = widget.onPressed == null
        ? shThemeData.disabledBackgroundColor
        : widget.active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = widget.onPressed == null
        ? shThemeData.disabledBorderColor
        : widget.active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    Color textColor = widget.onPressed == null
        ? shThemeData.disabledTextColor
        : widget.active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = widget.onPressed == null
        ? shThemeData.disabledIconColor
        : widget.active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;
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
      child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            disabledBackgroundColor: shThemeData.disabledBackgroundColor,
            disabledForegroundColor: shThemeData.disabledTextColor,
            foregroundColor:
                _isHovered ? shThemeData.hoverTextColor : textColor,
            backgroundColor:
                _isHovered ? shThemeData.hoverBackgroundColor : backgroundColor,
            padding: const EdgeInsets.only(right: 0.0),
            alignment: Alignment.topLeft,
          ),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                  child: MarsellaIconFavorite(
                      color:
                          _isHovered ? shThemeData.hoverIconColor : iconColor)),
              Container(
                padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                child: Text(
                  widget.text,
                  style: MarsellaTextStyles.textButtonNumber(
                      _isHovered ? shThemeData.hoverTextColor : textColor),
                ),
              ),
            ],
          )),
    );
  }
}

class MarsellaPostBookmarkButtonBar extends StatefulWidget {
  const MarsellaPostBookmarkButtonBar({
    super.key,
    required this.text,
    required this.active,
    this.onPressed,
  });
  final bool active;
  final String text;
  final VoidCallback? onPressed;

  @override
  State<MarsellaPostBookmarkButtonBar> createState() =>
      _MarsellaPostBookmarkButtonBarState();
}

class _MarsellaPostBookmarkButtonBarState
    extends State<MarsellaPostBookmarkButtonBar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postBookmarkButtonData;

    final backgroundColor = widget.onPressed == null
        ? shThemeData.disabledBackgroundColor
        : widget.active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = widget.onPressed == null
        ? shThemeData.disabledBorderColor
        : widget.active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = widget.onPressed == null
        ? shThemeData.disabledTextColor
        : widget.active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = widget.onPressed == null
        ? shThemeData.disabledIconColor
        : widget.active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

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
      child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            disabledBackgroundColor: shThemeData.disabledBackgroundColor,
            disabledForegroundColor: shThemeData.disabledTextColor,
            foregroundColor:
                _isHovered ? shThemeData.hoverTextColor : textColor,
            backgroundColor:
                _isHovered ? shThemeData.hoverBackgroundColor : backgroundColor,
            padding: const EdgeInsets.only(right: 0.0),
            alignment: Alignment.topLeft,
          ),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                  child: MarsellaIconBookmark(
                      color:
                          _isHovered ? shThemeData.hoverIconColor : iconColor)),
              Container(
                padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                child: Text(
                  widget.text,
                  style: MarsellaTextStyles.textButtonNumber(
                      _isHovered ? shThemeData.hoverTextColor : textColor),
                ),
              ),
            ],
          )),
    );
  }
}

class MarsellaPostCommentButtonBar extends StatefulWidget {
  const MarsellaPostCommentButtonBar({
    super.key,
    required this.text,
    required this.active,
    this.onPressed,
  });
  final bool active;
  final String text;
  final VoidCallback? onPressed;

  @override
  State<MarsellaPostCommentButtonBar> createState() =>
      _MarsellaPostCommentButtonBarState();
}

class _MarsellaPostCommentButtonBarState
    extends State<MarsellaPostCommentButtonBar> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postCommentButtonData;

    final backgroundColor = widget.onPressed == null
        ? shThemeData.disabledBackgroundColor
        : widget.active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = widget.onPressed == null
        ? shThemeData.disabledBorderColor
        : widget.active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = widget.onPressed == null
        ? shThemeData.disabledTextColor
        : widget.active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = widget.onPressed == null
        ? shThemeData.disabledIconColor
        : widget.active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;
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
      child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            disabledBackgroundColor: shThemeData.disabledBackgroundColor,
            disabledForegroundColor: shThemeData.disabledTextColor,
            foregroundColor:
                _isHovered ? shThemeData.hoverTextColor : textColor,
            backgroundColor:
                _isHovered ? shThemeData.hoverBackgroundColor : backgroundColor,
            padding: const EdgeInsets.only(right: 0.0),
            alignment: Alignment.topLeft,
          ),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 3.0, left: 10.0),
                  child: MarsellaIconComment(
                      color:
                          _isHovered ? shThemeData.hoverIconColor : iconColor)),
              Container(
                padding: const EdgeInsets.only(top: 5.0, left: 3.0),
                child: Text(
                  widget.text,
                  style: MarsellaTextStyles.textButtonNumber(
                      _isHovered ? shThemeData.hoverTextColor : textColor),
                ),
              ),
            ],
          )),
    );
  }
}

class MarsellaPostDownloadButtonBar extends StatefulWidget {
  const MarsellaPostDownloadButtonBar({
    super.key,
    required this.text,
    required this.active,
    this.onPressed,
  });
  final bool active;
  final String text;
  final VoidCallback? onPressed;

  @override
  State<MarsellaPostDownloadButtonBar> createState() =>
      _MarsellaPostDownloadButtonBarState();
}

class _MarsellaPostDownloadButtonBarState
    extends State<MarsellaPostDownloadButtonBar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postDownloadButtonData;

    final backgroundColor = widget.onPressed == null
        ? shThemeData.disabledBackgroundColor
        : widget.active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = widget.onPressed == null
        ? shThemeData.disabledBorderColor
        : widget.active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = widget.onPressed == null
        ? shThemeData.disabledTextColor
        : widget.active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = widget.onPressed == null
        ? shThemeData.disabledIconColor
        : widget.active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

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
      child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            disabledBackgroundColor: shThemeData.disabledBackgroundColor,
            disabledForegroundColor: shThemeData.disabledTextColor,
            foregroundColor:
                _isHovered ? shThemeData.hoverTextColor : textColor,
            backgroundColor:
                _isHovered ? shThemeData.hoverBackgroundColor : backgroundColor,
            padding: const EdgeInsets.only(right: 0.0),
            alignment: Alignment.topLeft,
          ),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 5.0, left: 11.0),
                  child: MarsellaIconDownload(
                      color:
                          _isHovered ? shThemeData.hoverIconColor : iconColor)),
              Container(
                padding: const EdgeInsets.only(top: 5.0, left: 4.0),
                child: Text(
                  widget.text,
                  style: MarsellaTextStyles.textButtonNumber(
                      _isHovered ? shThemeData.hoverTextColor : textColor),
                ),
              ),
            ],
          )),
    );
  }
}

class MarsellaPostShareButtonBar extends StatefulWidget {
  const MarsellaPostShareButtonBar({
    super.key,
    required this.text,
    required this.active,
    this.onPressed,
  });
  final bool active;
  final String text;
  final VoidCallback? onPressed;

  @override
  State<MarsellaPostShareButtonBar> createState() =>
      _MarsellaPostShareButtonBarState();
}

class _MarsellaPostShareButtonBarState extends State<MarsellaPostShareButtonBar> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postShareButtonData;

    final backgroundColor = widget.onPressed == null
        ? shThemeData.disabledBackgroundColor
        : widget.active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = widget.onPressed == null
        ? shThemeData.disabledBorderColor
        : widget.active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = widget.onPressed == null
        ? shThemeData.disabledTextColor
        : widget.active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = widget.onPressed == null
        ? shThemeData.disabledIconColor
        : widget.active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;
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
      child: SizedBox(
        width: 30.0,
        child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            disabledBackgroundColor: shThemeData.disabledBackgroundColor,
            disabledForegroundColor: shThemeData.disabledTextColor,
            foregroundColor: _isHovered ? shThemeData.hoverTextColor : textColor,
            backgroundColor:
                _isHovered ? shThemeData.hoverBackgroundColor : backgroundColor,
            padding: const EdgeInsets.only(right: 0.0),
            alignment: Alignment.topLeft,
          ),
          child: Container(
              padding: const EdgeInsets.only(top: 4.0, left: 5.0),
              child: MarsellaIconShare(
                  color:
                      _isHovered ? shThemeData.hoverIconColor : iconColor)),
        ),
      ),
    );
  }
}

class MarsellaIconTextButton extends StatelessWidget {
  const MarsellaIconTextButton({
    super.key,
    required this.text,
    required this.active,
    required this.icon,
    this.onPressed,
  });

  final bool active;
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).onlyTextButton;

    final backgroundColor = onPressed == null
        ? shThemeData.disabledBackgroundColor
        : active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = onPressed == null
        ? shThemeData.disabledBorderColor
        : active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = onPressed == null
        ? shThemeData.disabledTextColor
        : active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = onPressed == null
        ? shThemeData.disabledIconColor
        : active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.only(left: 15.0, right: 15.0)),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        minimumSize: MaterialStateProperty.all(
          const Size(78, 47),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: active
            ? null
            : MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return shThemeData
                        .hoverBackgroundColor; // Color de fondo cuando se produce el evento hover
                  }
                  return backgroundColor; // Mantener el color de fondo predeterminado en otros casos
                },
              ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          //MarsellaIconEdit(color: iconColor),
          const SizedBox(
            width: 8,
          ),
          Text(text, style: MarsellaTextStyles.textButtonLabel(textColor)),
        ],
      ),
    );
  }
}

class MarsellaOnlyTextButton extends StatelessWidget {
  const MarsellaOnlyTextButton({
    super.key,
    required this.text,
    required this.active,
    this.onPressed,
  });

  final bool active;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).onlyTextButton;

    final backgroundColor = onPressed == null
        ? shThemeData.disabledBackgroundColor
        : active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = onPressed == null
        ? shThemeData.disabledBorderColor
        : active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = onPressed == null
        ? shThemeData.disabledTextColor
        : active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = onPressed == null
        ? shThemeData.disabledIconColor
        : active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(EdgeInsets.only(left: 16.0, right: 16.0)),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        minimumSize: MaterialStateProperty.all(
          const Size(78, 47),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: active
            ? null
            : MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return shThemeData
                        .hoverBackgroundColor; // Color de fondo cuando se produce el evento hover
                  }
                  return backgroundColor; // Mantener el color de fondo predeterminado en otros casos
                },
              ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
      ),
      child: Text(text, style: MarsellaTextStyles.textButtonLabel(textColor)),
    );
  }
}

class MarsellaEditTextButton extends StatelessWidget {
  const MarsellaEditTextButton({
    super.key,
    required this.text,
    required this.active,
    this.onPressed,
  });

  final bool active;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).onlyTextButton;

    final backgroundColor = onPressed == null
        ? shThemeData.disabledBackgroundColor
        : active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = onPressed == null
        ? shThemeData.disabledBorderColor
        : active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = onPressed == null
        ? shThemeData.disabledTextColor
        : active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = onPressed == null
        ? shThemeData.disabledIconColor
        : active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(EdgeInsets.only(left: 16.0, right: 16.0)),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        minimumSize: MaterialStateProperty.all(
          const Size(78, 47),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: active
            ? null
            : MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return shThemeData
                        .hoverBackgroundColor; // Color de fondo cuando se produce el evento hover
                  }
                  return backgroundColor; // Mantener el color de fondo predeterminado en otros casos
                },
              ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 4.0, left: 4.0),
        child: Row(
          children: [
            MarsellaIconEdit(color: iconColor),
            const SizedBox(
              width: 8,
            ),
            Text(text, style: MarsellaTextStyles.textButtonLabel(textColor)),
          ],
        ),
      ),
    );
  }
}

class MarsellaOkIconButton extends StatelessWidget {
  const MarsellaOkIconButton({
    super.key,
    required this.text,
    required this.active,
    this.onPressed,
  });

  final bool active;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).okIconTextButton;

    final backgroundColor = onPressed == null
        ? shThemeData.disabledBackgroundColor
        : active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = onPressed == null
        ? shThemeData.disabledBorderColor
        : active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = onPressed == null
        ? shThemeData.disabledTextColor
        : active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = onPressed == null
        ? shThemeData.disabledIconColor
        : active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

    return TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.only(left: 16.0, right: 16.0)),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          minimumSize: MaterialStateProperty.all(
            const Size(78, 47),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          overlayColor: active
              ? null
              : MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return shThemeData
                          .hoverBackgroundColor; // Color de fondo cuando se produce el evento hover
                    }
                    return backgroundColor; // Mantener el color de fondo predeterminado en otros casos
                  },
                ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: borderColor,
                width: 1,
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.only(right: 4.0, left: 4.0),
          child: Row(
            children: [
              MarsellaIconCheck(color: iconColor),
              const SizedBox(
                width: 8,
              ),
              Text(text, style: MarsellaTextStyles.textButtonLabel(textColor)),
            ],
          ),
        ));
  }
}

class MarsellaCancelIconButton extends StatefulWidget {
  const MarsellaCancelIconButton({
    super.key,
    required this.text,
    required this.active,
    this.onPressed,
  });

  final bool active;
  final String text;
  final VoidCallback? onPressed;

  @override
  State<MarsellaCancelIconButton> createState() =>
      _MarsellaCancelIconButtonState();
}

class _MarsellaCancelIconButtonState extends State<MarsellaCancelIconButton> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).cancelIconTextButton;

    final backgroundColor = widget.onPressed == null
        ? shThemeData.disabledBackgroundColor
        : widget.active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = widget.onPressed == null
        ? shThemeData.disabledBorderColor
        : widget.active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = widget.onPressed == null
        ? shThemeData.disabledTextColor
        : widget.active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = widget.onPressed == null
        ? shThemeData.disabledIconColor
        : widget.active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

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
      child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(78, 47),
            disabledBackgroundColor: shThemeData.disabledBackgroundColor,
            disabledForegroundColor: shThemeData.disabledTextColor,
            foregroundColor:
                _isHovered ? shThemeData.hoverTextColor : textColor,
            backgroundColor:
                _isHovered ? shThemeData.hoverBackgroundColor : backgroundColor,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: _isHovered ? shThemeData.hoverBorderColor : borderColor,
                width: 1,
              ),
            ),
          ),
          onPressed: widget.onPressed,
          child: Container(
            padding: const EdgeInsets.only(right: 2.0, left: 2.0),
            child: Row(
              children: [
                MarsellaIconClose(
                    color: _isHovered ? shThemeData.hoverIconColor : iconColor),
                const SizedBox(
                  width: 8,
                ),
                Text(widget.text,
                    style: MarsellaTextStyles.textButtonLabel(
                        _isHovered ? shThemeData.hoverTextColor : textColor)),
              ],
            ),
          )),
    );
  }
}

class MarsellaDeleteIconButton extends StatelessWidget {
  const MarsellaDeleteIconButton({
    super.key,
    required this.text,
    required this.active,
    this.onPressed,
  });

  final bool active;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).cancelIconTextButton;

    final backgroundColor = onPressed == null
        ? shThemeData.disabledBackgroundColor
        : active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = onPressed == null
        ? shThemeData.disabledBorderColor
        : active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = onPressed == null
        ? shThemeData.disabledTextColor
        : active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = onPressed == null
        ? shThemeData.disabledIconColor
        : active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(EdgeInsets.only(left: 16.0, right: 16.0)),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        minimumSize: MaterialStateProperty.all(
          const Size(78, 47),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: active
            ? null
            : MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return shThemeData
                        .hoverBackgroundColor; // Color de fondo cuando se produce el evento hover
                  }
                  return backgroundColor; // Mantener el color de fondo predeterminado en otros casos
                },
              ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 4.0, left: 4.0),
        child: Row(
          children: [
            MarsellaIconDelete(color: iconColor),
            const SizedBox(
              width: 8,
            ),
            Text(text, style: MarsellaTextStyles.textButtonLabel(textColor)),
          ],
        ),
      ),
    );
  }
}

class MarsellaWithoutUnderlineButton extends StatefulWidget {
  const MarsellaWithoutUnderlineButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.active,
  });
  final String text;
  final VoidCallback? onPressed;
  final bool active;

  @override
  State<MarsellaWithoutUnderlineButton> createState() =>
      _MarsellaWithoutUnderlineButtonState();
}

class _MarsellaWithoutUnderlineButtonState
    extends State<MarsellaWithoutUnderlineButton> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).textWithoutUnderlineButton;
    final backgroundColor = widget.onPressed == null
        ? shThemeData.disabledBackgroundColor
        : widget.active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = widget.onPressed == null
        ? shThemeData.disabledBorderColor
        : widget.active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = widget.onPressed == null
        ? shThemeData.disabledTextColor
        : widget.active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = widget.onPressed == null
        ? shThemeData.disabledIconColor
        : widget.active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;
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
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          disabledBackgroundColor: shThemeData.disabledBackgroundColor,
          disabledForegroundColor: shThemeData.disabledTextColor,
          foregroundColor: _isHovered ? shThemeData.hoverTextColor : textColor,
          backgroundColor:
              _isHovered ? shThemeData.hoverBackgroundColor : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          widget.text,
          style: MarsellaTextStyles.textLinksWithoutUnderline(
              _isHovered ? shThemeData.hoverTextColor : textColor),
        ),
      ),
    );
  }
}

class MarsellaSelectFileButton extends StatelessWidget {
  const MarsellaSelectFileButton({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).selectFileButtonData;
    final bool active = false;

    final backgroundColor = onPressed == null
        ? shThemeData.disabledBackgroundColor
        : active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = onPressed == null
        ? shThemeData.disabledBorderColor
        : active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = onPressed == null
        ? shThemeData.disabledTextColor
        : active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = onPressed == null
        ? shThemeData.disabledIconColor
        : active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.only(left: 16.0, right: 16.0)),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        minimumSize: MaterialStateProperty.all(
          const Size(78, 47),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: active
            ? null
            : MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return shThemeData
                        .hoverBackgroundColor; // Color de fondo cuando se produce el evento hover
                  }
                  return backgroundColor; // Mantener el color de fondo predeterminado en otros casos
                },
              ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 4.0, right: 5.0),
        child: Text(text,
            style:
                MarsellaTextStyles.textButtonLabel(shThemeData.normalTextColor)),
      ),
    );
  }
}

class MarsellaLoginButton extends StatelessWidget {
  const MarsellaLoginButton({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).loginButtonData;
    final bool active = false;
    final backgroundColor = onPressed == null
        ? shThemeData.disabledBackgroundColor
        : active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = onPressed == null
        ? shThemeData.disabledBorderColor
        : active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = onPressed == null
        ? shThemeData.disabledTextColor
        : active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = onPressed == null
        ? shThemeData.disabledIconColor
        : active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

    return Container(
      height: 40,
      width: 104,
      padding: const EdgeInsets.only(right: 0, top: 0, bottom: 0, left: 0),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.only(left: 16.0, right: 16.0)),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          minimumSize: MaterialStateProperty.all(
            const Size(78, 47),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          overlayColor: active
              ? null
              : MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return shThemeData
                          .hoverBackgroundColor; // Color de fondo cuando se produce el evento hover
                    }
                    return backgroundColor; // Mantener el color de fondo predeterminado en otros casos
                  },
                ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: borderColor,
                width: 1,
              ),
            ),
          ),
        ),
        /*
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: shThemeData.normalBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        */
        onPressed: onPressed,
        child: Center(
            child: Text(text,
                textAlign: TextAlign.center,
                style: MarsellaTextStyles.textButtonLabel(
                    shThemeData.normalTextColor))),
      ),
    );
  }
}

class MarsellaLoginSocialButton extends StatelessWidget {
  const MarsellaLoginSocialButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.active,
    required this.text,
  });

  final VoidCallback? onPressed;
  final Icon icon;
  final bool active;
  final String text;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).loginSocialButtonData;
    final backgroundColor = onPressed == null
        ? shThemeData.disabledBackgroundColor
        : active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = onPressed == null
        ? shThemeData.disabledBorderColor
        : active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = onPressed == null
        ? shThemeData.disabledTextColor
        : active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = onPressed == null
        ? shThemeData.disabledIconColor
        : active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;

    Icon xicon = Icon(icon.icon, size: icon.size, color: iconColor);

    return Container(
      height: 40,
      padding: const EdgeInsets.only(right: 6, top: 0, bottom: 0, left: 6),
      child: ElevatedButton.icon(
        icon: xicon,
        label: Text(text,
            textAlign: TextAlign.center,
            style: MarsellaTextStyles.textButtonLabel(textColor)),
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              EdgeInsets.only(left: 16.0, right: 16.0)),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          minimumSize: MaterialStateProperty.all(
            const Size(78, 40),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          overlayColor: active
              ? null
              : MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return shThemeData
                          .hoverBackgroundColor; // Color de fondo cuando se produce el evento hover
                    }
                    return backgroundColor; // Mantener el color de fondo predeterminado en otros casos
                  },
                ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: borderColor,
                width: 1,
              ),
            ),
          ),
        ),

/*
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: shThemeData.disabledBackgroundColor,
          disabledForegroundColor: shThemeData.disabledTextColor,
          minimumSize: const Size(78, 40),
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: borderColor,
                width: 1,
              )),
        ),
        */
      ),
    );
  }
}

class MarsellaWithUnderlineButton extends StatefulWidget {
  const MarsellaWithUnderlineButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.active,
  });
  final String text;
  final VoidCallback? onPressed;
  final bool active;

  @override
  State<MarsellaWithUnderlineButton> createState() =>
      _MarsellaWithUnderlineButtonState();
}

class _MarsellaWithUnderlineButtonState
    extends State<MarsellaWithUnderlineButton> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).textWithoutUnderlineButton;
    final backgroundColor = widget.onPressed == null
        ? shThemeData.disabledBackgroundColor
        : widget.active
            ? shThemeData.activeBackgroundColor
            : shThemeData.normalBackgroundColor;

    final borderColor = widget.onPressed == null
        ? shThemeData.disabledBorderColor
        : widget.active
            ? shThemeData.activeBorderColor
            : shThemeData.normalBorderColor;

    final textColor = widget.onPressed == null
        ? shThemeData.disabledTextColor
        : widget.active
            ? shThemeData.activeTextColor
            : shThemeData.normalTextColor;

    final iconColor = widget.onPressed == null
        ? shThemeData.disabledIconColor
        : widget.active
            ? shThemeData.activeIconColor
            : shThemeData.normalIconColor;
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
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          disabledBackgroundColor: shThemeData.disabledBackgroundColor,
          disabledForegroundColor: shThemeData.disabledTextColor,
          foregroundColor: _isHovered ? shThemeData.hoverTextColor : textColor,
          backgroundColor:
              _isHovered ? shThemeData.hoverBackgroundColor : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          widget.text,
          style: MarsellaTextStyles.textLinksWitUnderline(
              _isHovered ? shThemeData.hoverTextColor : textColor),
        ),
      ),
    );
  }
}

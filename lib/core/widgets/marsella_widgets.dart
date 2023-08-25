import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:marsellafrontend/core/widgets/marsella_buttons.dart';

import '../../domain/entities/storage/cloudfile.dart';
import '../../presentation/nav/bloc/nav_bloc.dart';
import '../../presentation/nav/bloc/nav_event.dart';
import '../../presentation/nav/bloc/nav_state.dart';
import '../constants.dart';
import '../themes/marsella_colors.dart';
import '../themes/marsella_screen.dart';
import '../themes/marsella_text_styles.dart';
import '../themes/marsella_themedata.dart';

class MarsellaCircularIndicatorData {
  final Color primaryColor;

  const MarsellaCircularIndicatorData({required this.primaryColor});
}

class MarsellaContainer extends StatelessWidget {
  const MarsellaContainer({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context);
    return Container(
      constraints: const BoxConstraints.tightFor(width: double.infinity),
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: shThemeData.postData.backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1,
            color: shThemeData.postData.borderColor,
          )),
      child: child,
    );
  }
}

class MarsellaContainerSimple extends StatelessWidget {
  const MarsellaContainerSimple({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context);
    return Container(
      constraints: const BoxConstraints.tightFor(width: double.infinity),
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: shThemeData.postData.backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1,
            color: shThemeData.postData.borderColor,
          )),
      child: child,
    );
  }
}

class MarsellaScrollViewInTable extends StatelessWidget {
  const MarsellaScrollViewInTable({
    super.key,
    required this.child,
    required this.height,
    required this.length,
  });
  final Widget? child;
  final double? height;
  final int length;

  @override
  Widget build(BuildContext context) {
    return length > 5 
    ? SizedBox(
      height: height,
      child: SingleChildScrollView(
        child: child,
      )
    )
    : SizedBox(
      height: null,
      child: child
    );
  }
}

class MarsellaOverflowBarOrRow extends StatelessWidget {
  const MarsellaOverflowBarOrRow({
    super.key,
    required this.textFields,
  });
  final List<Widget> textFields;

  @override
  Widget build(BuildContext context) {
    return MarsellaScreen.screenIsSmallSize(context)
    ? OverflowBar(
      children: textFields,
    )
    : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: textFields,
    );
  }
}

class MarsellaEnabled {
  static bool isEnabled(
      String postId, bool postEnable, Map<String, bool> checks) {
    return (checks.containsKey(postId) && checks[postId] == true) ||
        (!checks.containsKey(postId) && postEnable);
  }
}


enum MarsellaCircularSize { small, normal, big }

class MarsellaCircularIndicator extends StatelessWidget {
  const MarsellaCircularIndicator({
    super.key,
    required this.size,
  });

  final MarsellaCircularSize size;

  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).circularProgressIndicatorData;

    final double size = this.size == MarsellaCircularSize.small
        ? 16
        : this.size == MarsellaCircularSize.normal
            ? 26
            : 36;

    final double strokeWidth = this.size == MarsellaCircularSize.small
        ? 2
        : this.size == MarsellaCircularSize.normal
            ? 3
            : 4;

    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        backgroundColor: Colors.transparent,
        color: shThemeData.primaryColor,
      ),
    );
  }
}

class MarsellaAlertDialogData {
  final Color contentTextColor;
  final Color titleTextColor;
  final Color backgroundColor;
  final Color borderColor;

  const MarsellaAlertDialogData(
      {required this.backgroundColor,
      required this.contentTextColor,
      required this.titleTextColor,
      required this.borderColor});
}

class MarsellaAlertDialog extends StatelessWidget {
  const MarsellaAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.buttons,
  });
  final String title;
  final String content;
  final List<Widget> buttons;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).alertDialogData;

    List<Widget> childrens = [];
    for (Widget button in buttons) {
      childrens.add(button);
    }

    return AlertDialog(
      backgroundColor: shThemeData.backgroundColor,
      titlePadding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      actionsPadding:
          const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: shThemeData.borderColor,
          width: 1,
        ),
      ),
      title: Text(title,
          style: MarsellaTextStyles.textPostTitle(shThemeData.titleTextColor)),
      content: Text(content,
          style: MarsellaTextStyles.textPlaceholderText(
              shThemeData.contentTextColor)),
      actions: <Widget>[
        Row(
          children: childrens,
        ),
      ],
    );
  }
}

class MarsellaErrorScreen extends StatelessWidget {
  const MarsellaErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final shThemeBrightness = MarsellaTheme.of(context).themeData.brightness;
    final shThemeData = MarsellaTheme.of(context);

    String imageLocation = '';

    if (shThemeBrightness == Brightness.light) {
      imageLocation = 'assets/marsella_large_logo_light_worm.png';
    } else {
      imageLocation = 'assets/marsella_large_logo_dark_worm.png';
    }

    return Column(
      children: [
        const SizedBox(height: 70,),
        Image.asset(
          imageLocation,
          width: 70,
          height: 96,
        ),
        const SizedBox(height: 70,),
        Icon(
          Icons.do_disturb,
          size: 100,
          color: MarsellaColors
              .marsellaMediumGreen,),
        const SizedBox(height: 16,),
        Text(ErrorScreenMessage.errorScreenMessage,
        style: MarsellaTextStyles
          .textPlaceholderText(MarsellaColors
              .marsellaMediumGreen)),
        const SizedBox(height: 24,),
        MarsellaSideMenuButton(
          text: 'Volver al inicio',
          active: false,
          onPressed: () {
            BlocProvider.of<NavBloc>(context).add(NavigateTo(
                NavItem.pageUsers,
                context,
                <String, dynamic>{
                  "searchText": "",
                },
                force: true));
          }
        ),
      ],
    );
  }
}

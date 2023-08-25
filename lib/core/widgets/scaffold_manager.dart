// Dependiendo del tamaño de la pantalla mantendrá el SideDrawer visible
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsellafrontend/core/themes/marsella_screen.dart';
import 'package:marsellafrontend/core/widgets/marsella_appbar.dart';
import 'package:marsellafrontend/core/widgets/marsella_icons.dart';

import '../../presentation/sidedrawer/pages/sidedrawer_page.dart';
import '../bloc/scroll_cubit.dart';
import '../constants.dart';
import '../themes/marsella_themedata.dart';

class ScaffoldManager extends StatelessWidget {
  const ScaffoldManager(
      {super.key,
      required this.child,
      this.floatingActionButton,
      this.scrollController,
      this.layoutFormat});

  final Widget child;
  final Widget? floatingActionButton;
  final ScrollController? scrollController;
  final String? layoutFormat;
  @override
  Widget build(BuildContext context) {
    final shTheme = MarsellaTheme.of(context);
    //full y mobile
    if (!MarsellaScreen.screenIsNormalSize(context)) {
      return Row(
        children: [
          layoutFormat != "login"
              ? SizedBox(
                  width: ScreenSize.sizeMenuBox,
                  child: SideDrawer(
                    layoutFormat: layoutFormat,
                    key: const ValueKey("sidedrawer"),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: shTheme.backGroundColor,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            decoration: BoxDecoration(
                              color: shTheme.backGroundColor,
                            ),
                            padding: const EdgeInsets.only(top: 23),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: MarsellaIconBack(
                                color: shTheme.iconMenuColor,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
          Expanded(
              child: Scaffold(
            backgroundColor: shTheme.backGroundColor,
            body: BlocBuilder<ScrollLiveCubit, ScrollLiveState>(
              builder: (context, state) {
                return SingleChildScrollView(
                    controller: state.scrollController,
                    child: Center(child: child));
              },
            ),
            floatingActionButton: floatingActionButton,
          ))
        ],
      );
    } else {
      return Scaffold(
        backgroundColor: shTheme.backGroundColor,
        appBar: MarsellaAppBarNormal(layoutFormat: layoutFormat).appBar,
        body: BlocBuilder<ScrollLiveCubit, ScrollLiveState>(
          builder: (context, state) {
            return SingleChildScrollView(
                controller: state.scrollController,
                child: Center(child: child));
          },
        ),
        floatingActionButton: floatingActionButton,
        drawer: SideDrawer(
          layoutFormat: layoutFormat,
          key: const ValueKey("sidedrawer"),
        ),
      );
    }
  }
}

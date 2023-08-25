import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/marsella_screen.dart';
import '../../../core/themes/marsella_themedata.dart';
import '../../../core/widgets/marsella_icons.dart';
import '../../../core/widgets/marsella_images.dart';
import '../../../core/widgets/marsella_inputs.dart';
import '../../presentation/nav/bloc/nav_bloc.dart';
import '../../presentation/nav/bloc/nav_event.dart';
import '../../presentation/nav/bloc/nav_state.dart';
import '../bloc/searchpost_cubit.dart';

class MarsellaAppBarNormal extends StatelessWidget
    implements PreferredSizeWidget {
  MarsellaAppBarNormal({
    super.key,
    this.layoutFormat,
  });

  final String? layoutFormat;
  final TextEditingController _searchController = TextEditingController();

  PreferredSizeWidget get appBar => this;
  @override
  PreferredSizeWidget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context);
    String layout = layoutFormat ?? "normal";

    NavItem actualNavItem = NavItem.pageUsers;

    List<Widget>? actions = [];
    if (layout == "normal") {
      actions = [
        MarsellaScreen.screenIsSmallSize(context)
            ? BlocBuilder<SearchPostLiveCubit, SearchPostLiveState>(
                builder: (context, statecubit) {
                  _searchController.text =
                      context.read<SearchPostLiveCubit>().state.searchText;

                  if (NavState.isBoxPage(
                      context.read<NavBloc>().state.selectedItem)) {
                    actualNavItem = context.read<NavBloc>().state.selectedItem;
                  }

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: statecubit.mobileSearchIsExpanded ? 300 : 58,
                    padding:
                        const EdgeInsets.only(top: 11, right: 8, bottom: 27),
                    onEnd: () {
                      bool toChange = !statecubit.mobileSearchIsClose;
                      context
                          .read<SearchPostLiveCubit>()
                          .changeMobileSearchExpandEndAnimated(toChange);
                    },
                    child: MarsellaAppBarInputSearchMobile(
                        isExpanded: statecubit.mobileSearchIsExpanded,
                        hintText: 'Buscar',
                        text: '',
                        searchController: _searchController,
                        onTap: () {
                          bool toChange = !statecubit.mobileSearchIsExpanded;
                          context
                              .read<SearchPostLiveCubit>()
                              .changeMobileSearchExpand(toChange);
                        },
                        onSubmitted: (value) {
                          if (_searchController.text.isNotEmpty) {
                            BlocProvider.of<NavBloc>(context).add(NavigateTo(
                                actualNavItem,
                                context,
                                <String, dynamic>{
                                  "searchText": _searchController.text,
                                },
                                force: true));

                            context
                                .read<SearchPostLiveCubit>()
                                .changeSearchText(_searchController.text);

                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          }
                          return null;
                        },
                        onPressedIcon: () {
                            BlocProvider.of<NavBloc>(context).add(NavigateTo(
                                actualNavItem,
                                context,
                                <String, dynamic>{
                                  "searchText": "",
                                },
                                force: true));
                            context
                                .read<SearchPostLiveCubit>()
                                .changeSearchTextCloseMobile();
                            _searchController.text = "";
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                        }),
                  );
                },
              )
            : BlocBuilder<SearchPostLiveCubit, SearchPostLiveState>(
                builder: (context, statecubit) {
                  _searchController.text =
                      context.read<SearchPostLiveCubit>().state.searchText;
                  if (NavState.isBoxPage(
                      context.read<NavBloc>().state.selectedItem)) {
                    actualNavItem = context.read<NavBloc>().state.selectedItem;
                  }
                  return MarsellaAppBarInputSearch(
                    hintText: 'Buscar',
                    text: '',
                    searchController: _searchController,
                    onSubmitted: (value) {
                      if (_searchController.text.isNotEmpty) {
                        BlocProvider.of<NavBloc>(context).add(NavigateTo(
                            actualNavItem,
                            context,
                            <String, dynamic>{
                              "searchText": _searchController.text,
                            },
                            force: true));

                        context
                            .read<SearchPostLiveCubit>()
                            .changeSearchText(_searchController.text);

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      } else if (_searchController.text.isEmpty) {
                        BlocProvider.of<NavBloc>(context).add(NavigateTo(
                            actualNavItem,
                            context,
                            <String, dynamic>{
                              "searchText": "",
                            },
                            force: true));

                        context
                            .read<SearchPostLiveCubit>()
                            .changeSearchText("");

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                      return null;
                    },
                    onPressedIcon: () {
                      if (_searchController.text.isNotEmpty &&
                          _searchController.text ==
                              context
                                  .read<SearchPostLiveCubit>()
                                  .state
                                  .searchText) {
                        BlocProvider.of<NavBloc>(context).add(NavigateTo(
                            actualNavItem,
                            context,
                            <String, dynamic>{
                              "searchText": "",
                            },
                            force: true));
                        context
                            .read<SearchPostLiveCubit>()
                            .changeSearchText("");
                        _searchController.text = "";
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      } else if (context
                              .read<SearchPostLiveCubit>()
                              .state
                              .searchText
                              .isEmpty &&
                          _searchController.text.isNotEmpty) {
                        BlocProvider.of<NavBloc>(context).add(NavigateTo(
                            actualNavItem,
                            context,
                            <String, dynamic>{
                              "searchText": _searchController.text,
                            },
                            force: true));

                        context
                            .read<SearchPostLiveCubit>()
                            .changeSearchText(_searchController.text);

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                    },
                  );
                },
              ),
      ];
    }

    Widget? largeLogo;
    if (layout != "login") {
      largeLogo = BlocBuilder<SearchPostLiveCubit, SearchPostLiveState>(
        builder: (context, statecubit) {
          return InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              BlocProvider.of<NavBloc>(context).add(NavigateTo(
                  NavItem.pageUsers,
                  context,
                  <String, dynamic>{
                    "searchText": "",
                  },
                  force: true));
              context.read<SearchPostLiveCubit>().changeSearchText("");

              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: statecubit.mobileSearchIsExpanded ||
                    !statecubit.mobileSearchIsClose
                ? const MarsellaSideMenuLargeWormLogo()
                : const MarsellaSideMenuLargeLogo(),
          );
        },
      );
    }

    Widget? leading;
    if (layout == "normal") {
      leading = IconButton(
        splashRadius: 10,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(top: 26, left: 15),
        icon: MarsellaIconMenu(
          color: shThemeData.iconMenuColor,
        ),
        onPressed: () {
          if (Scaffold.of(context).hasDrawer) {
            Scaffold.of(context).openDrawer();
          }
        },
      );
    } else if (layout == "login") {
      leading = IconButton(
        splashRadius: 10,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(top: 26, left: 15),
        icon: MarsellaIconBack(
          color: shThemeData.iconMenuColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      leading = const SizedBox();
    }

    return AppBar(
      toolbarHeight: 80,
      leadingWidth: 46,
      titleSpacing: 0.0,
      leading: leading,
      title: largeLogo,
      actions: actions,
      elevation: 0.0,
      backgroundColor: shThemeData.backGroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

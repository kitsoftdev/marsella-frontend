import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsellafrontend/core/bloc/session_cubit.dart';
import 'package:marsellafrontend/core/constants.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';

import '../../../core/bloc/searchpost_cubit.dart';
import '../../../core/bloc/theme_cubit.dart';
import '../../../core/themes/marsella_colors.dart';
import '../../../core/themes/marsella_screen.dart';
import '../../../core/themes/marsella_text_styles.dart';
import '../../../core/themes/marsella_themedata.dart';
import '../../../core/widgets/marsella_buttons.dart';
import '../../../core/widgets/marsella_images.dart';
import '../../../core/widgets/marsella_inputs.dart';
import '../../../core/widgets/marsella_selectors.dart';
import '../../../core/widgets/marsella_texts.dart';
import '../../../core/widgets/marsella_widgets.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/orga.dart';
import '../../nav/bloc/nav_bloc.dart';
import '../../nav/bloc/nav_event.dart';
import '../../nav/bloc/nav_state.dart';
import '../bloc/sidedrawer_bloc.dart';
import '../bloc/sidedrawer_state.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({
    super.key,
    this.layoutFormat,
  });

  final TextEditingController _searchController = TextEditingController();
  final String? layoutFormat;
  void _handleItemClick(BuildContext context, NavItem item) {
    BlocProvider.of<NavBloc>(context)
        .add(NavigateTo(item, context, <String, dynamic>{"searchText": ""}));
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < ScreenSize.maxScreen) {
      Navigator.pop(context);
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final shTheme = MarsellaTheme.of(context);

    NavItem actualNavItem = NavItem.pageUsers;

    return BlocListener<SideDrawerBloc, SideDrawerState>(
      listener: (context, state) {
        if (state is SideDrawerError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: Drawer(
          width: ScreenSize.sizeMenuBox,
          backgroundColor: shTheme.backGroundColor,
          child: BlocBuilder<SideDrawerBloc, SideDrawerState>(
            builder: (context, state) {
              actualNavItem = context.read<NavBloc>().state.selectedItem;
              List<Widget> childrensList = <Widget>[];
              childrensList.add(
                InkWell(
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
                    child: const MarsellaSideMenuLargeLogo()),
              );

              if (layoutFormat == null || layoutFormat == "normal") {
                childrensList.add(
                  const Divider(
                    color: Colors.transparent,
                    height: 17,
                  ),
                );
                _searchController.text =
                    context.read<SearchPostLiveCubit>().state.searchText;
                if (!MarsellaScreen.screenIsNormalSize(context)) {
                  if (!NavState.isBoxPage(
                      context.read<NavBloc>().state.selectedItem)) {
                    actualNavItem = NavItem.pageUsers;
                  }

                  childrensList.add(MarsellaSideMenuInputSearch(
                    hintText: 'Buscar',
                    text: _searchController.text,
                    searchController: _searchController,
                    onSubmitted: (value) {
                      final screenWidth = MediaQuery.of(context).size.width;
                      if (_searchController.text.isNotEmpty) {
                        context
                            .read<SearchPostLiveCubit>()
                            .changeSearchText(_searchController.text);
                        BlocProvider.of<NavBloc>(context).add(NavigateTo(
                            actualNavItem,
                            context,
                            <String, dynamic>{
                              "searchText": _searchController.text,
                            },
                            force: true));
                        if (screenWidth < ScreenSize.maxScreen) {
                          Navigator.pop(context);
                        }
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
                        if (screenWidth < ScreenSize.maxScreen) {
                          Navigator.pop(context);
                        }
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                      return value;
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
                      } else if (context
                          .read<SearchPostLiveCubit>()
                          .state
                          .searchText
                          .isEmpty) {
                        BlocProvider.of<NavBloc>(context).add(NavigateTo(
                            actualNavItem,
                            context,
                            <String, dynamic>{
                              "searchText": _searchController.text,
                            },
                            force: true));
                        final screenWidth = MediaQuery.of(context).size.width;
                        if (screenWidth < ScreenSize.maxScreen) {
                          Navigator.pop(context);
                        }

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        context
                            .read<SearchPostLiveCubit>()
                            .changeSearchText(_searchController.text);
                      }
                    },
                  ));
                } else {
                  childrensList.add(const Divider(
                    color: Colors.transparent,
                    height: 10,
                  ));
                }

                childrensList.add(
                  const Divider(
                    color: Colors.transparent,
                    height: 15,
                  ),
                );

                if (state is SideDrawerReady) {
                  if (state.reload) {
                    BlocProvider.of<NavBloc>(context).add(
                        NavigateTo(actualNavItem, context, null, force: true));
                    final screenWidth = MediaQuery.of(context).size.width;
                    if (screenWidth < ScreenSize.maxScreen) {
                      Navigator.pop(context);
                    }
                  }

                  if (state.orgaList.isNotEmpty) {
                    if (state.orgaList.length > 1) {
                      final shThemeSideMenuDropdownData =
                          MarsellaTheme.of(context).sideMenuDropdownData;

                      String firstOrga = state.orga?.id ?? "";
                      if (firstOrga == '') {
                        firstOrga = state.orgaList.first.id;
                      }
                      childrensList.add(
                        const MarsellaSideMenuSubtitle(text: 'Organización'),
                      );
                      childrensList.add(
                        MarsellaSideMenuDropdown(
                          value: state.orgaList
                              .firstWhere((element) => element.id == firstOrga)
                              .id,
                          items: state.orgaList
                              .map<DropdownMenuItem<String>>((Orga orga) {
                            return DropdownMenuItem<String>(
                              value: orga.id,
                              child: Text(
                                orga.name,
                                style: MarsellaTextStyles.textButtonLabel(
                                    shThemeSideMenuDropdownData
                                        .normalTextColor),
                              ),
                              /*Container(
                                        padding: const EdgeInsets.only(
                                            left: 6, top: 4, bottom: 4, right: 6),
                                        child: Text(
                                          orga.name,
                                          style: MarsellaTextStyles.textButtonLabel(
                                              shThemeSideMenuDropdownData
                                                  .normalTextColor),
                                        ),
                                      ),*/
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value.toString() != firstOrga) {
                              showDialog(
                                  context: context,
                                  builder: (context) => GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: MarsellaAlertDialog(
                                          title:
                                              '¿Desea cambiar de Organización?',
                                          content: '',
                                          buttons: [
                                            MarsellaOnlyTextButton(
                                                text: 'Cancelar',
                                                onPressed: () {
                                                  Navigator.pop(context, false);
                                                },
                                                active: false),
                                            MarsellaOkIconButton(
                                                text: 'Cambiar',
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                },
                                                active: false),
                                          ]))).then((resp) {
                                if (resp) {
                                  firstOrga = value.toString();

                                  context.read<SideDrawerBloc>().add(
                                      OnSideDrawerChangeOrga(
                                          value.toString(), state.user!));
                                }
                              });
                            }
                          },
                        ),
                      );
                    } else {
                      //mostrar solo el texto nombre de la orga
                      if (state.orgaList[0].name != 'System' &&
                          state.orgaList[0].name != 'Default') {
                        childrensList.add(
                            MarsellaRegularText(text: state.orgaList[0].name));
                      }
                    }
                  }

                  List<Widget> childrenCategoryOptionsList = <Widget>[];

                  if (childrenCategoryOptionsList.isNotEmpty) {
                    childrensList.add(
                      const MarsellaSideMenuSubtitle(text: 'Categorías'),
                    );

                    childrensList.add(
                      Container(
                        padding: const EdgeInsets.all(0),
                        child: Wrap(
                          children: childrenCategoryOptionsList,
                        ),
                      ),
                    );
                  }

                  //
                  List<Widget> childrenAdminOptionsList = <Widget>[];

                  if (state.opts.contains(SideDrawerUserOptions.optUsers)) {
                    childrenAdminOptionsList.add(
                      MarsellaSideMenuButton(
                        text: 'Usuarios',
                        onPressed: () {
                          _handleItemClick(context, NavItem.pageUsers);
                        },
                        active: (actualNavItem == NavItem.pageUsers),
                      ),
                    );
                  }

                  if (childrenAdminOptionsList.isNotEmpty) {
                    childrensList.add(
                      const MarsellaSideMenuSubtitle(text: 'Administración'),
                    );

                    childrensList.add(
                      Container(
                        padding: const EdgeInsets.all(0),
                        child: Wrap(
                          children: childrenAdminOptionsList,
                        ),
                      ),
                    );
                  }

                  //

                  List<Widget> childrenMyAccountOptionsList = <Widget>[];

                  if (childrenMyAccountOptionsList.isNotEmpty) {
                    childrensList.add(
                      const MarsellaSideMenuSubtitle(text: 'Tu cuenta'),
                    );

                    childrensList.add(
                      Container(
                        padding: const EdgeInsets.all(0),
                        child: Wrap(
                          children: childrenMyAccountOptionsList,
                        ),
                      ),
                    );
                  }
                }

                childrensList.add(
                  const MarsellaSideMenuSubtitle(text: 'Escoge tu color'),
                );
                childrensList.add(
                  Wrap(
                    children: [
                      MarsellaSideMenuSelectTheme(
                        primaryColor: MarsellaColors.marsellaGreenBackground,
                        active:
                            context.read<ThemeLiveCubit>().state.themeMode ==
                                "green",
                        onPressed: () {
                          context
                              .read<ThemeLiveCubit>()
                              .changeSwitchValue("green");
                        },
                      ),
                      MarsellaSideMenuSelectTheme(
                        primaryColor: MarsellaColors.marsellaBlackBackground,
                        active:
                            context.read<ThemeLiveCubit>().state.themeMode ==
                                "dark",
                        onPressed: () {
                          context
                              .read<ThemeLiveCubit>()
                              .changeSwitchValue("dark");
                        },
                      ),
                      MarsellaSideMenuSelectTheme(
                        primaryColor: MarsellaColors.marsellaBlueBackground,
                        active:
                            context.read<ThemeLiveCubit>().state.themeMode ==
                                "blue",
                        onPressed: () {
                          context
                              .read<ThemeLiveCubit>()
                              .changeSwitchValue("blue");
                        },
                      ),
                      MarsellaSideMenuSelectTheme(
                        primaryColor: MarsellaColors.marsellaYellowBackground,
                        active:
                            context.read<ThemeLiveCubit>().state.themeMode ==
                                "yellow",
                        onPressed: () {
                          context
                              .read<ThemeLiveCubit>()
                              .changeSwitchValue("yellow");
                        },
                      ),
                      MarsellaSideMenuSelectTheme(
                        primaryColor: MarsellaColors.marsellaPurpleBackground,
                        active:
                            context.read<ThemeLiveCubit>().state.themeMode ==
                                "purple",
                        onPressed: () {
                          context
                              .read<ThemeLiveCubit>()
                              .changeSwitchValue("purple");
                        },
                      ),
                    ],
                  ),
                );
              }

              if (state is SideDrawerEmpty) {
                SessionLiveState sessionState =
                    context.read<SessionLiveCubit>().state;

                context.read<SideDrawerBloc>().add(OnSideDrawerLoading(
                    sessionState.user,
                    sessionState.orga,
                    sessionState.orgaList,
                    sessionState.session));

                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: const Center(
                    child: MarsellaCircularIndicator(
                      size: MarsellaCircularSize.normal,
                    ),
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.only(top: 15, left: 24, right: 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: childrensList,
                ),
              );
            },
          )),
    );
  }
}

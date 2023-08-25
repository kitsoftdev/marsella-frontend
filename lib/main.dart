import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsellafrontend/core/bloc/connectivity_cubit.dart';
import 'package:marsellafrontend/core/bloc/session_cubit.dart';
import 'package:marsellafrontend/presentation/nav/bloc/nav_bloc.dart';
import 'package:marsellafrontend/presentation/nav/bloc/nav_event.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_state.dart';

import 'core/bloc/scroll_cubit.dart';
import 'core/bloc/searchpost_cubit.dart';
import 'core/bloc/theme_cubit.dart';
import 'core/bloc/visibility_cubit.dart';
import 'core/router/app_router.dart';
import 'core/themes/marsella_themedata.dart';
import 'core/themes/marsella_themes.dart';
import 'core/widgets/body_formatter.dart';
import 'core/widgets/scaffold_manager.dart';
import 'core/widgets/marsella_widgets.dart';
import 'core/widgets/snackbar_notification.dart';
import 'firebase_options.dart';
import 'injection.dart' as di;
import 'presentation/nav/bloc/nav_state.dart';
import 'presentation/sidedrawer/bloc/sidedrawer_bloc.dart';
import 'presentation/users/bloc/user_bloc.dart';
import 'presentation/users/pages/users_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //usePathUrlStrategy();
  debugPaintSizeEnabled = false; //true;

  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    if (inDebug) {
      return ErrorWidget(details.exception);
    }
    return Container(
      alignment: Alignment.center,
      child: const MarsellaErrorScreen(),
    );
  };

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  runApp(const MarsellaApp());
}

class MarsellaApp extends StatefulWidget {
  const MarsellaApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MarsellaApp();
}

class _MarsellaApp extends State<MarsellaApp> {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<NavBloc>()),
        BlocProvider(create: (_) => di.locator<SideDrawerBloc>()),
        BlocProvider(create: (_) => di.locator<UserBloc>()),
        BlocProvider(create: (_) => di.locator<SearchPostLiveCubit>()),
        BlocProvider(create: (_) => di.locator<ThemeLiveCubit>()),
        BlocProvider(create: (_) => di.locator<SessionLiveCubit>()),
        BlocProvider(create: (_) => di.locator<VisibilityLiveCubit>()),
        BlocProvider(create: (_) => di.locator<ConnectivityLiveCubit>()),
        BlocProvider(create: (_) => di.locator<ScrollLiveCubit>()),
      ],
      child: MaterialApp(
        title: 'Marsella.com',
        home: Builder(builder: (context) {
          //context.read<SessionLiveCubit>().readSession();
          final shThemeDataAll = MarsellaTheme.of(context);
          return BlocListener<ConnectivityLiveCubit, ConnectivityLiveState>(
            listener: (context, state) {
              if (state.connectionStatus == ConnectivityResult.none) {
                snackBarNotify(
                    context, 'Sin conexión a internet', Icons.signal_wifi_off);
              }
            },
            child: BlocListener<SessionLiveCubit, SessionLiveState>(
              listener: (context, statecubit) {
                /*if (context.read<SessionLiveCubit>().timeCancel) {
                  snackBarNotify(context, 'Sesión cerrada automáticamente',
                      Icons.exit_to_app);
                  context
                      .read<SideDrawerBloc>()
                      .add(const OnSideDrawerLogOff());
                  context.read<SessionLiveCubit>().logoff();
                  BlocProvider.of<NavBloc>(context)
                      .add(NavigateTo(NavItem.pageUsers, context, null));
                }*/
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: shThemeDataAll.backGroundColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ScaffoldManager(
                      child: BodyFormatter(
                          screenWidth: MediaQuery.of(context).size.width,
                          child: BlocBuilder<NavBloc, NavState>(
                            builder: (context, state) {
                              return _animatedSwitcher(state, context);
                            },
                          )))),
            ),
          );
        }),
        builder: (context, child) =>
            BlocBuilder<ThemeLiveCubit, ThemeLiveState>(
          builder: (context, statecubit) {
            String themeMode = statecubit.themeMode;
            if (themeMode == "") {
              context.read<ThemeLiveCubit>().changeThemeFromCache();
            }

            return MarsellaTheme(
              marsellaTheme: themeMode == "green"
                  ? marsellaGreenTheme
                  : themeMode == "dark"
                      ? marsellaDarkTheme
                      : themeMode == "blue"
                          ? marsellaBlueTheme
                          : themeMode == "yellow"
                              ? marsellaYellowTheme
                              : themeMode == "purple"
                                  ? marsellaPurpleTheme
                                  : marsellaGreenTheme,
              child: child ?? ErrorWidget('Child needed!'),
            );
          },
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }

  AnimatedSwitcher _animatedSwitcher(NavState state, BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeInExpo,
      switchOutCurve: Curves.easeOutExpo,
      duration: const Duration(milliseconds: 250),
      child: _bodyForState(state, context),
    );
  }

  dynamic _bodyForState(NavState state, BuildContext context) {
    dynamic sideState = context.read<SideDrawerBloc>().state;

    if (sideState is SideDrawerReady) {
      SideDrawerReady sideDrawerReady = sideState;
      context.read<SideDrawerBloc>().add(OnSideDrawerReady(
          sideDrawerReady.opts,
          sideDrawerReady.orgaList,
          sideDrawerReady.orga,
          sideDrawerReady.reload,
          !sideDrawerReady.changedPage,
          sideDrawerReady.user));
    }

    if (state.selectedItem == NavItem.pageUsers) {
      return UsersPage();
    }
  }
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_bloc.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_state.dart';
import 'package:marsellafrontend/presentation/sidedrawer/pages/sidedrawer_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSideDrawerBloc extends MockBloc<SideDrawerEvent, SideDrawerState>
    implements SideDrawerBloc {}

class FakeSideDrawerState extends Fake implements SideDrawerState {}

class FakeSideDrawerEvent extends Fake implements SideDrawerEvent {}

void main() {
  late MockSideDrawerBloc mockSideDrawerBloc;

  setUpAll(() async {
    registerFallbackValue(FakeSideDrawerState());
    registerFallbackValue(FakeSideDrawerEvent());
    final di = GetIt.instance;
    di.registerFactory(() => mockSideDrawerBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SideDrawerBloc>.value(
      value: mockSideDrawerBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  setUp(() {
    mockSideDrawerBloc = MockSideDrawerBloc();
  });

  const listAnonymous = <String>["recent", "login"];
  const listUser = <String>["recent", "logoff", "profile"];
  const listAdmin = <String>["recent", "logoff", "profile", "users"];
  const listSuperAdmin = <String>[
    "recent",
    "logoff",
    "profile",
    "orgas",
    "users",
    "roles"
  ];
}

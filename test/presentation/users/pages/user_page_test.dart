import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:marsellafrontend/core/fakedata.dart';
import 'package:marsellafrontend/presentation/users/bloc/user_bloc.dart';
import 'package:marsellafrontend/presentation/users/bloc/user_event.dart';
import 'package:marsellafrontend/presentation/users/bloc/user_state.dart';
import 'package:marsellafrontend/presentation/users/pages/users_page.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

class FakeUserState extends Fake implements UserState {}

class FakeUserEvent extends Fake implements UserEvent {}

void main() {
  late MockUserBloc mockUserBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeUserState());
    registerFallbackValue(FakeUserEvent());

    mockUserBloc = MockUserBloc();

    final di = GetIt.instance;

    di.registerFactory(() => mockUserBloc);
  });

  setUp(() {});

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>.value(
          value: mockUserBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tUser2 = fakeListUsers[1].toEntity();

  final tOrga2 = fakeListOrgas[1].toEntity();
  final tListOrgaUser = fakeListOrgaUsers
      .where(
        (element) => element.orgaId == tOrga2.id,
      )
      .toList();
  final tListOrgas = fakeListOrgas
      .where(
        (element) => element.id == tOrga2.id,
      )
      .toList();
  final tOrgaUser = fakeListOrgaUsers[1].toEntity();
}

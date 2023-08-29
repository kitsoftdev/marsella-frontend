import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/core/constants.dart';
import 'package:marsellafrontend/data/models/session_model.dart';
import 'package:marsellafrontend/domain/entities/user.dart';
import 'package:marsellafrontend/domain/usecases/local/get_has_login.dart';
import 'package:marsellafrontend/domain/usecases/local/get_session_status.dart';
import 'package:marsellafrontend/domain/usecases/login/change_orga.dart';
import 'package:marsellafrontend/data/models/orga_model.dart';
import 'package:marsellafrontend/domain/entities/orga.dart';
import 'package:marsellafrontend/domain/usecases/orgas/get_orga.dart';
import 'package:marsellafrontend/domain/usecases/orgas/get_orgasbyuser.dart';
import 'package:marsellafrontend/domain/usecases/sidedrawer/do_logoff.dart';
import 'package:marsellafrontend/domain/usecases/sidedrawer/get_side_options.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_bloc.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sidedrawer_bloc_test.mocks.dart';

@GenerateMocks([
  GetSideOptions,
  DoLogOff,
  GetSession,
  GetOrgasByUser,
  GetHasLogIn,
  GetOrga,
  ChangeOrga
])
void main() {
  late MockGetSideOptions mockGetSideOptions;
  late MockDoLogOff mockDoLogOff;
  late MockGetSession mockGetSession;
  late MockGetOrgasByUser mockGetOrgasByUser;
  late MockGetHasLogIn mockGetHasLogIn;
  late MockGetOrga mockGetOrga;
  late MockChangeOrga mockChangeOrga;

  late SideDrawerBloc sideDrawerBloc;

  setUp(() {
    mockGetSideOptions = MockGetSideOptions();
    mockDoLogOff = MockDoLogOff();
    mockGetSession = MockGetSession();
    mockGetHasLogIn = MockGetHasLogIn();
    mockGetOrga = MockGetOrga();
    mockGetOrgasByUser = MockGetOrgasByUser();
    mockChangeOrga = MockChangeOrga();

    sideDrawerBloc = SideDrawerBloc(mockGetSideOptions, mockDoLogOff,
        mockGetSession, mockGetOrgasByUser, mockGetHasLogIn, mockChangeOrga);
  });

  const userId = '00000002-0002-0002-0002-000000000002';
  const listAnonymous = <String>["recent", "login"];
  const tSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: 'rev@mp.com',
      name: 'Revisor');
  const tOrga = Orga(
      id: '00000002-0002-0002-0002-000000000002',
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);
  const tUser = User(
      id: '1',
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false,
      pictureUrl: null,
      pictureCloudFileId: null,
      pictureThumbnailUrl: null,
      pictureThumbnailCloudFileId: null);

  test(
    'el estado inicial de sidedraer debe ser vacío',
    () {
      expect(sideDrawerBloc.state, SideDrawerEmpty());
    },
  );

  blocTest<SideDrawerBloc, SideDrawerState>(
    'debe emitir loading antes de ready',
    build: () {
      when(mockGetSideOptions.execute())
          .thenAnswer((_) async => const Right(listAnonymous));
      when(mockGetHasLogIn.execute())
          .thenAnswer((_) async => const Right(true));
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(tSession));
      when(mockGetOrgasByUser.execute('00000001-0001-0001-0001-000000000001'))
          .thenAnswer((_) async => const Right(<Orga>[tOrga]));
      return sideDrawerBloc;
    },
    act: (bloc) => bloc.add(const OnSideDrawerLoading(null, null, [], null)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SideDrawerLoading(),
      const SideDrawerReady(
          listAnonymous, <Orga>[tOrga], null, false, false, null),
    ],
    verify: (bloc) {
      verify(mockGetSideOptions.execute());
    },
  );

  blocTest<SideDrawerBloc, SideDrawerState>(
    'debe cerrar sesión ',
    build: () {
      when(mockDoLogOff.execute()).thenAnswer((_) async => const Right(true));
      return sideDrawerBloc;
    },
    act: (bloc) => bloc.add(OnSideDrawerLogOff()),
    wait: const Duration(milliseconds: 500),
    expect: () => [SideDrawerEmpty()],
    verify: (bloc) {
      verify(mockDoLogOff.execute());
    },
  );

  blocTest<SideDrawerBloc, SideDrawerState>(
    'debe emitir ready al cambiar de orga',
    build: () {
      when(mockGetSideOptions.execute())
          .thenAnswer((_) async => const Right(listAnonymous));
      when(mockChangeOrga.execute(tSession.username, tOrga.id))
          .thenAnswer((_) async => const Right(tSession));
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(tSession));
      when(mockGetOrgasByUser.execute('00000001-0001-0001-0001-000000000001'))
          .thenAnswer((_) async => const Right(<Orga>[tOrga]));
      return sideDrawerBloc;
    },
    act: (bloc) => bloc.add(OnSideDrawerChangeOrga(tOrga.id, tUser)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const SideDrawerReady(
          listAnonymous, <Orga>[tOrga], null, false, false, null),
    ],
    verify: (bloc) {
      verify(mockGetSession.execute());
      verify(
          mockGetOrgasByUser.execute('00000001-0001-0001-0001-000000000001'));
    },
  );
}

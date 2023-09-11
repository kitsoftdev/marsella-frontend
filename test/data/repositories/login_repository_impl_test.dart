import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/core/constants.dart';
import 'package:marsellafrontend/core/exceptions.dart';
import 'package:marsellafrontend/core/failures.dart';
import 'package:marsellafrontend/data/datasources/local_data_source.dart';
import 'package:marsellafrontend/data/datasources/login_data_source.dart';
import 'package:marsellafrontend/data/datasources/user_data_source.dart';
import 'package:marsellafrontend/data/models/session_model.dart';
import 'package:marsellafrontend/data/models/user_model.dart';
import 'package:marsellafrontend/data/repositories/login_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource, LocalDataSource, UserRemoteDataSource, Guid])
void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late LoginRepositoryImpl repository;
  late MockGuid mockGuid;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockGuid = MockGuid();
    repository = LoginRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      userDataSource: mockUserRemoteDataSource,
    );
  });

  final newUserId = Guid.newGuid.toString();

  const tUserModel = UserModel(
    id: '',
    name: 'user',
    username: 'user',
    email: 'user@mp.com',
    enabled: true,
    builtIn: false,
    pictureUrl: null,
    pictureCloudFileId: null,
    pictureThumbnailUrl: null,
    pictureThumbnailCloudFileId: null,
  );

  const tLoginAccessModel = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: "mp@mp.com",
      name: "Miguel");

  const tSessionModel = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: "mp@mp.com",
      name: "Miguel");

  group('conseguir la autorización con el login repository impl', () {
    const tusername = "mp@mp.com";
    const tpassword = "12345";

    test(
      'debe retornar el token cuando se obtiene correctamente desde el origen',
      () async {
        // arrange
        when(mockLocalDataSource.saveSession(any))
            .thenAnswer((realInvocation) async => true);
        when(mockRemoteDataSource.getAuthenticate(tusername, tpassword))
            .thenAnswer((realInvocation) async => tLoginAccessModel);

        // act
        final result = await repository.getAuthenticate(tusername, tpassword);

        // assert
        verify(mockRemoteDataSource.getAuthenticate(tusername, tpassword));
        verify(mockLocalDataSource.saveSession(any)).called(1);
        expect(result, equals(const Right(tLoginAccessModel)));
      },
    );
  });

  group('registro de usuario en login repository impl', () {
    const tusername = "mp@mp.com";
    const tpassword = "12345";

    test(
      'debe retornar boolean cuando se registra correctamente',
      () async {
        // arrange
        when(mockLocalDataSource.saveSession(any))
            .thenAnswer((realInvocation) async => true);
        when(mockRemoteDataSource.registerUser(
                tUserModel, 'orgaId', '1234', 'user'))
            .thenAnswer((realInvocation) async => true);

        // act
        final result = await repository.registerUser(
            'user', 'user', 'user@mp.com', 'orgaId', '1234', 'user');

        // assert
        verify(mockRemoteDataSource.registerUser(
            tUserModel, 'orgaId', '1234', 'user'));
        expect(result, equals(const Right(true)));
      },
    );
  });

  group('cambio de organización login repository impl', () {
    const tusername = "mp@mp.com";
    const tpassword = "12345";

    test(
      'debe retornar sessionmodel cuando se cambia correctamente',
      () async {
        // arrange
        when(mockLocalDataSource.saveSession(any))
            .thenAnswer((realInvocation) async => true);
        when(mockRemoteDataSource.changeOrga('user', 'orgaId'))
            .thenAnswer((realInvocation) async => tSessionModel);

        // act
        final result = await repository.changeOrga('user', 'orgaId');

        // assert
        verify(mockRemoteDataSource.changeOrga('user', 'orgaId'));
        expect(result, equals(const Right(tSessionModel)));
      },
    );
  });
}

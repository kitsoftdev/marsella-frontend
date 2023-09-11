import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:marsellafrontend/core/constants.dart';
import 'package:marsellafrontend/core/exceptions.dart';
import 'package:marsellafrontend/core/failures.dart';
import 'package:marsellafrontend/core/fakedata.dart';
import 'package:marsellafrontend/data/datasources/orga_data_source.dart';
import 'package:marsellafrontend/data/models/orga_model.dart';
import 'package:marsellafrontend/data/models/orgauser_model.dart';
import 'package:marsellafrontend/data/repositories/orga_repository_impl.dart';
import 'package:marsellafrontend/domain/entities/orga.dart';
import 'package:marsellafrontend/domain/entities/orgauser.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'orga_repository_impl_test.mocks.dart';

@GenerateMocks([OrgaRemoteDataSource])
void main() {
  late MockOrgaRemoteDataSource mockRemoteDataSource;
  late OrgaRepositoryImpl repository;

  final newOrgaId = Guid.newGuid.toString();
  final newUserId = Guid.newGuid.toString();

  final tOrgaModel = OrgaModel(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  final tOrgaUserModel = OrgaUserModel(
      userId: newUserId,
      orgaId: newOrgaId,
      roles: const <String>[Roles.roleAdmin],
      enabled: true,
      builtIn: true);

  final tOrgaUserModelList = OrgaUserModel(
      userId: newUserId,
      orgaId: newOrgaId,
      roles: const <String>[Roles.roleAdmin],
      enabled: true,
      builtIn: true);

  final tOrgaUser = OrgaUser(
      userId: newUserId,
      orgaId: newOrgaId,
      roles: const <String>[Roles.roleAdmin],
      enabled: true,
      builtIn: true);

  List<Orga> tlistOrgas = [];
  List<OrgaUser> tlistOrgaUsers = [];

  setUp(() {
    mockRemoteDataSource = MockOrgaRemoteDataSource();
    repository = OrgaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );

    for (var element in fakeListOrgas) {
      tlistOrgas.add(element.toEntity());
    }
    for (var element in fakeListOrgaUsers) {
      tlistOrgaUsers.add(element.toEntity());
    }
  });
  group('conseguir orga, orgas y orgauser con simulación de problemas', () {
    test(
      'debe retornar un orga',
      () async {
        // arrange
        when(mockRemoteDataSource.getOrga(any))
            .thenAnswer((realInvocation) async => tOrgaModel);

        // act
        final result = await repository.getOrga(newOrgaId);

        // assert
        verify(mockRemoteDataSource.getOrga(any));
        expect(result, equals(Right(tOrga)));
      },
    );

    test(
      'debe retornar una lista de orgas',
      () async {
        // arrange
        when(mockRemoteDataSource.getOrgas(any, any, any, any))
            .thenAnswer((_) async => <OrgaModel>[tOrgaModel]);

        // act
        final result = await repository.getOrgas("", "", 1, 10);
        List<Orga> list = [];
        result.fold((l) => {}, ((r) => {list = r}));

        // assert
        verify(mockRemoteDataSource.getOrgas(any, any, any, any));
        expect(result.isRight(), true);
        expect(list, (<Orga>[tOrga]));
      },
    );

    test(
      'debe retornar una lista de orgausers',
      () async {
        // arrange
        when(mockRemoteDataSource.getOrgaUsers(any)).thenAnswer(
            (realInvocation) async => <OrgaUserModel>[tOrgaUserModel]);

        // act
        final result = await repository.getOrgaUsers(fakeOrgaIdSystem);
        List<OrgaUser> list = [];
        result.fold((l) => {}, ((r) => {list = r}));
        // assert
        verify(mockRemoteDataSource.getOrgaUsers(any));
        expect(result.isRight(), true);
        expect(list, (<OrgaUser>[tOrgaUser]));
      },
    );

    test(
      'debe retornar una lista de orgausers por orgaId y userId',
      () async {
        // arrange
        when(mockRemoteDataSource.getOrgaUser(any, any)).thenAnswer(
            (realInvocation) async => <OrgaUserModel>[tOrgaUserModel]);

        // act
        final result = await repository.getOrgaUser('orgaId', 'userId');
        List<OrgaUser> list = [];
        result.fold((l) => {}, ((r) => {list = r}));
        // assert
        verify(mockRemoteDataSource.getOrgaUser(any, any));
        expect(result.isRight(), true);
        expect(list, (<OrgaUser>[tOrgaUser]));
      },
    );
  });
  group('agregar orga y orgauser con simulación de problemas', () {
    test(
      'debe agregar un orga',
      () async {
        // arrange
        when(mockRemoteDataSource.addOrga(any))
            .thenAnswer((realInvocation) async => tOrgaModel);

        // act
        final result = await repository.addOrga(
            tOrgaModel.name, tOrgaModel.code, tOrgaModel.enabled);

        // assert
        verify(mockRemoteDataSource.addOrga(any));
        expect(result, equals(Right(tOrga)));
      },
    );

    test(
      'debe agregar un orgauser',
      () async {
        // arrange
        when(mockRemoteDataSource.addOrgaUser(any))
            .thenAnswer((realInvocation) async => tOrgaUserModel);

        // act
        final result = await repository.addOrgaUser(
            tOrgaUserModel.orgaId,
            tOrgaUserModel.userId,
            tOrgaUserModel.roles,
            tOrgaUserModel.enabled);

        // assert
        verify(mockRemoteDataSource.addOrgaUser(any));
        expect(result, equals(Right(tOrgaUser)));
      },
    );
  });
  group('actualizar orga y orgauser con simulación de problemas', () {
    test(
      'debe actualizar un orga',
      () async {
        // arrange
        when(mockRemoteDataSource.updateOrga(any, any))
            .thenAnswer((realInvocation) async => tOrgaModel);

        // act
        final result = await repository.updateOrga(tOrgaModel.id, tOrgaModel);

        // assert
        verify(mockRemoteDataSource.updateOrga(any, any));
        expect(result, equals(Right(tOrga)));
      },
    );
  });
  group('eliminar orga y orgauser con simulación de problemas', () {
    test(
      'debe eliminar un orga',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteOrga(any))
            .thenAnswer((realInvocation) async => true);

        // act
        final result = await repository.deleteOrga(tOrgaModel.id);

        // assert
        verify(mockRemoteDataSource.deleteOrga(any));
        expect(result, equals(const Right(true)));
      },
    );

    test(
      'debe eliminar un orgauser',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteOrgaUser(any, any))
            .thenAnswer((realInvocation) async => true);

        // act
        final result = await repository.deleteOrgaUser(
            tOrgaUserModel.orgaId, tOrgaUserModel.userId);

        // assert
        verify(mockRemoteDataSource.deleteOrgaUser(any, any));
        expect(result, equals(const Right(true)));
      },
    );
  });
  group('deshabilitar orga y orgauser con simulación de problemas', () {
    test(
      'debe deshabilitar un orga',
      () async {
        // arrange
        when(mockRemoteDataSource.enableOrga(any, any))
            .thenAnswer((realInvocation) async => true);
        when(mockRemoteDataSource.getOrga(any))
            .thenAnswer((realInvocation) async => tOrgaModel);
        // act
        final result = await repository.enableOrga(tOrgaModel.id, false);

        // assert
        verify(mockRemoteDataSource.enableOrga(any, any));
        expect(result, equals(Right(tOrga)));
      },
    );

    test(
      'debe deshabilitar un orgauser',
      () async {
        // arrange
        when(mockRemoteDataSource.enableOrgaUser(any, any, any))
            .thenAnswer((realInvocation) async => true);
        when(mockRemoteDataSource.getOrgaUser(any, any)).thenAnswer(
            (realInvocation) async =>
                <OrgaUserModel>[tOrgaUserModel]); //tOrgaUserModel);

        // act
        final result = await repository.enableOrgaUser(
            tOrgaUserModel.orgaId, tOrgaUserModel.userId, false);

        // assert
        verify(mockRemoteDataSource.enableOrgaUser(any, any, any));
        expect(result, equals(Right(tOrgaUser)));
      },
    );
  });
}

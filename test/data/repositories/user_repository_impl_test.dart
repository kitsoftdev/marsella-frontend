import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/core/exceptions.dart';
import 'package:marsellafrontend/core/failures.dart';
import 'package:marsellafrontend/core/fakedata.dart';
import 'package:marsellafrontend/core/model_container.dart';
import 'package:marsellafrontend/data/datasources/user_data_source.dart';
import 'package:marsellafrontend/data/models/user_model.dart';
import 'package:marsellafrontend/data/repositories/user_repository_impl.dart';
import 'package:marsellafrontend/domain/entities/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([UserRemoteDataSource])
void main() {
  late MockUserRemoteDataSource mockRemoteDataSource;
  late UserRepositoryImpl repository;

  final newUserId = Guid.newGuid.toString();

  final tUserModel = UserModel(
    id: newUserId,
    name: 'Test User',
    username: 'test',
    email: 'te@mp.com',
    enabled: true,
    builtIn: false,
    pictureUrl: null,
    pictureCloudFileId: null,
    pictureThumbnailUrl: null,
    pictureThumbnailCloudFileId: null,
  );

  final tUser = User(
    id: newUserId,
    name: 'Test User',
    username: 'test',
    email: 'te@mp.com',
    enabled: true,
    builtIn: false,
    pictureUrl: null,
    pictureCloudFileId: null,
    pictureThumbnailUrl: null,
    pictureThumbnailCloudFileId: null,
  );

  List<User> tlistUsers = [];

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    repository = UserRepositoryImpl(remoteDataSource: mockRemoteDataSource);

    for (var element in fakeListUsers) {
      tlistUsers.add(element.toEntity());
    }
  });
  group('conseguir user, users con simulación de problemas', () {
    test(
      'debe retornar un user',
      () async {
        // arrange
        when(mockRemoteDataSource.getUser(any))
            .thenAnswer((realInvocation) async => tUserModel);

        // act
        final result = await repository.getUser(newUserId);

        // assert
        verify(mockRemoteDataSource.getUser(any)).called(1);
        expect(result, equals(Right(tUser)));
      },
    );

    test(
      'debe retornar una lista de users',
      () async {
        // arrange
        when(mockRemoteDataSource.getUsers(any, any, any, any, any))
            .thenAnswer((_) async => ModelContainer.fromItem(tUserModel));

        // act
        final result =
            await repository.getUsers("", "", <String, int>{}, 1, 10);
        ModelContainer<User> list = ModelContainer.empty();
        result.fold((l) => {}, ((r) => {list = r}));

        // assert
        verify(mockRemoteDataSource.getUsers(any, any, any, any, any));
        expect(result.isRight(), true);
        expect(list, (ModelContainer.fromItem(tUserModel)));
      },
    );
  });
  group('agregar user y useruser con simulación de problemas', () {
    test(
      'debe agregar un user',
      () async {
        // arrange
        when(mockRemoteDataSource.addUser(any))
            .thenAnswer((realInvocation) async => tUserModel);

        // act
        final result = await repository.addUser(tUserModel.name,
            tUserModel.username, tUserModel.email, tUserModel.enabled);

        // assert
        verify(mockRemoteDataSource.addUser(any));
        expect(result, equals(Right(tUser)));
      },
    );
  });
  group('actualizar user y useruser con simulación de problemas', () {
    test(
      'debe actualizar un user',
      () async {
        // arrange
        when(mockRemoteDataSource.updateUser(any, any))
            .thenAnswer((realInvocation) async => tUserModel);

        // act
        final result = await repository.updateUser(tUserModel.id, tUserModel);

        // assert
        verify(mockRemoteDataSource.updateUser(any, any));
        expect(result, equals(Right(tUser)));
      },
    );
  });
  group('eliminar user y useruser con simulación de problemas', () {
    test(
      'debe eliminar un user',
      () async {
        // arrange
        when(mockRemoteDataSource.deleteUser(any))
            .thenAnswer((realInvocation) async => true);

        // act
        final result = await repository.deleteUser(tUserModel.id);

        // assert
        verify(mockRemoteDataSource.deleteUser(any));
        expect(result, equals(const Right(true)));
      },
    );
  });
  group('deshabilitar user y useruser con simulación de problemas', () {
    test(
      'debe deshabilitar un user',
      () async {
        // arrange
        when(mockRemoteDataSource.enableUser(any, any))
            .thenAnswer((realInvocation) async => true);
        when(mockRemoteDataSource.getUser(any))
            .thenAnswer((realInvocation) async => tUserModel);

        // act
        final result = await repository.enableUser(tUserModel.id, false);

        // assert
        verify(mockRemoteDataSource.enableUser(any, any));
        expect(result, equals(Right<Failure, User>(tUserModel.toEntity())));
      },
    );
  });
}

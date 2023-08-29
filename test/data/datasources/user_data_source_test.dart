import 'dart:convert';

import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:marsellafrontend/core/constants.dart';
import 'package:marsellafrontend/core/model_container.dart';
import 'package:marsellafrontend/data/datasources/local_data_source.dart';
import 'package:marsellafrontend/data/models/session_model.dart';
import 'package:marsellafrontend/core/exceptions.dart';
import 'package:marsellafrontend/core/fakedata.dart';
import 'package:marsellafrontend/data/datasources/user_data_source.dart';
import 'package:marsellafrontend/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositories/local_repository_impl_test.mocks.dart';
import 'user_data_source_test.mocks.dart';

@GenerateMocks([UserRemoteDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late UserRemoteDataSourceImpl dataSource;
  late MockLocalDataSourceImpl mockLocalDataSource;

  late String userId; //Sistema
  late String userIdSampleUpdate;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockLocalDataSource = MockLocalDataSourceImpl();
    dataSource = UserRemoteDataSourceImpl(
        client: mockHttpClient, localDataSource: mockLocalDataSource);

    userId = fakeListUsers[0].id; //Sistema

    userIdSampleUpdate = fakeListUsers[3].id;
  });

  const testUserId = '00000001-0001-0001-0001-000000000001';
  const testUserModel = UserModel(
      id: '00000001-0001-0001-0001-000000000001',
      name: 'Súper',
      username: 'super',
      email: 'super@mp.com',
      enabled: true,
      builtIn: true,
      pictureUrl: null,
      pictureCloudFileId: null,
      pictureThumbnailUrl: null,
      pictureThumbnailCloudFileId: null,);

  const testGetResponse =
      '{"apiVersion":"1.0","method":"get","params":{"id":"00000001-0001-0001-0001-000000000001"},"context":"geted by id","id":"37f93961-a189-4182-96b0-28491a8b78df","_id":"37f93961-a189-4182-96b0-28491a8b78df","data":{"items":[{"_id":"00000001-0001-0001-0001-000000000001","id":"00000001-0001-0001-0001-000000000001","name":"Súper","username":"super","email":"super@mp.com","enabled":true,"builtIn":true,"created":"2023-01-11T15:50:26.921Z","orgas":[{"id":"00000100-0100-0100-0100-000000000100","code":"sys"}],"updated":"2023-01-11T15:50:33.444Z"}],"kind":"string","currentItemCount":1,"updated":"2023-01-12T14:23:00.142Z"}}';

  const testGetResponseZero =
      '{"apiVersion":"1.0","method":"get","params":{"orgaId":"00000200-0200-0200-0200-000000000200"},"context":"geted by orga id","id":"480893fa-0b81-4ce6-9e2f-e4439ce0ba9a","_id":"480893fa-0b81-4ce6-9e2f-e4439ce0ba9a","data":{"items":[],"kind":"string","currentItemCount":0,"updated":"2023-01-13T15:25:05.437Z"}}';

  const testGetResponseUpdate =
      '{"apiVersion":"1.0","method":"get","params":{"id":"00000001-0001-0001-0001-000000000001"},"context":"geted by id","id":"37f93961-a189-4182-96b0-28491a8b78df","_id":"37f93961-a189-4182-96b0-28491a8b78df","data":{"items":[{"_id":"00000001-0001-0001-0001-000000000001","id":"00000001-0001-0001-0001-000000000001","name":"Editado","username":"edited","email":"ed@mp.com","enabled":true,"builtin":false,"created":"2023-01-11T15:50:26.921Z","orgas":[{"id":"00000100-0100-0100-0100-000000000100","code":"sys"}],"updated":"2023-01-11T15:50:33.444Z"}],"kind":"string","currentItemCount":1,"updated":"2023-01-12T14:23:00.142Z"}}';

  const testBoolResponse =
      '{"apiVersion":"1.0","method":"get","params":{"id":"00000001-0001-0001-0001-000000000001"},"context":"geted by id","id":"37f93961-a189-4182-96b0-28491a8b78df","_id":"37f93961-a189-4182-96b0-28491a8b78df","data":{"items":[true],"kind":"string","currentItemCount":1,"updated":"2023-01-12T14:23:00.142Z"}}';

  const testSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023, name: 'Súper', username: 'super');

  const testHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${SystemKeys.tokenSuperAdmin2023}",
  };

  group('obtener datos user, users', () {
    test('obtener una usuarios', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.getUser(testUserId);

      //assert
      expect(result, equals(testUserModel));
    });
    test('obtener lista de usuarios sin filtrar', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.getUsers("", "", [], 1, 10);

      //assert
      expect(result, equals(ModelContainer.fromItem(testUserModel)));
    });
    test('obtener lista de usuarios filtrada', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.getUsers("", "Súper", [], 1, 10);

      //assert
      expect(result, equals(ModelContainer.fromItem(testUserModel)));
    });

    test(
      '''debe lanzar un error de servidor al conseguir 
      cuando la respuesta es distinta a 200''',
      () async {
        // arrange
        when(
          mockHttpClient.get(any, headers: testHeaders),
        ).thenAnswer(
          (_) async => http.Response('', 404),
        );
        when(mockLocalDataSource.getSavedSession())
            .thenAnswer((realInvocation) async => testSession);

        // act
        final call1 = dataSource.getUser(userId);
        final call2 = dataSource.getUsers("", "", [], 1, 10);

        // assert
        expect(() => call1, throwsA(isA<ServerException>()));
        expect(() => call2, throwsA(isA<ServerException>()));
      },
    );
  });
  group('actualizar datos user', () {
    test('actualizar un usuario', () async {
      //arrange
      UserModel toEdit = const UserModel(
          id: testUserId,
          name: "Editado",
          username: "edited",
          email: "ed@mp.com",
          enabled: true,
          builtIn: false,
          pictureUrl: null,
          pictureCloudFileId: null,
          pictureThumbnailUrl: null,
          pictureThumbnailCloudFileId: null,);

      when(mockHttpClient.put(any,
              body: json.encode(toEdit), headers: testHeaders))
          .thenAnswer((realInvocation) async =>
              http.Response(testGetResponseUpdate, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act

      final result = await dataSource.updateUser(testUserId, toEdit);

      //assert
      expect(result, equals(toEdit));
      //expect(toEdit, equals(fakeListUsers[2]));
    });

    test('actualizar un usuario pero arroja error', () async {
      //arrange
      UserModel toEdit = const UserModel(
          id: testUserId,
          name: "Editado",
          username: "edited",
          email: "ed@mp.com",
          enabled: true,
          builtIn: false,
          pictureUrl: null,
          pictureCloudFileId: null,
          pictureThumbnailUrl: null,
          pictureThumbnailCloudFileId: null,);

      when(mockHttpClient.put(any,
              body: json.encode(toEdit), headers: testHeaders))
          .thenAnswer((realInvocation) async => http.Response('', 500));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act

      final call = dataSource.updateUser(testUserId, toEdit);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('agregar datos user', () {
    test('agregar un user', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(UrlBackend.base)))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      UserModel toAdd = UserModel(
          id: Guid.newGuid.toString(),
          name: "Nuevo User",
          username: "newuser",
          email: "nw@mp.com",
          enabled: true,
          builtIn: false,
          pictureUrl: null,
          pictureCloudFileId: null,
          pictureThumbnailUrl: null,
          pictureThumbnailCloudFileId: null,);
      final result = await dataSource.addUser(toAdd);

      //assert
      expect(result, equals(toAdd));
      //expect(fakeListUsers.length, nearEqual(a, b, epsilon));
    });

    test('agregar un user y arroja error', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(UrlBackend.base)))
          .thenAnswer((realInvocation) async => http.Response("", 500));

      //act
      UserModel toAdd = UserModel(
          id: Guid.newGuid.toString(),
          name: "Nuevo User",
          username: "newuser",
          email: "nw@mp.com",
          enabled: true,
          builtIn: false,
          pictureUrl: null,
          pictureCloudFileId: null,
          pictureThumbnailUrl: null,
          pictureThumbnailCloudFileId: null,);
      final call = dataSource.addUser(toAdd);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('eliminar datos user y useruser', () {
    test('eliminar un usuario', () async {
      //arrange
      when(mockHttpClient.delete(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.deleteUser(fakeUserIdUser01);

      //assert
      expect(result, equals(true));
    });

    test('eliminar un usuario pero arroja error', () async {
      //arrange
      when(mockHttpClient.delete(any, headers: testHeaders))
          .thenAnswer((realInvocation) async => http.Response('', 500));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final call = dataSource.deleteUser(fakeUserIdUser01);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('habilitar datos user', () {
    test('habilitar un usuario', () async {
      //arrange
      when(mockHttpClient.put(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.enableUser(fakeListUsers[1].id, false);

      //assert
      expect(result, equals(true));
    });

    test('habilitar un usuario pero arroja error', () async {
      //arrange
      when(mockHttpClient.put(any, headers: testHeaders))
          .thenAnswer((realInvocation) async => http.Response('', 500));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final call = dataSource.enableUser(fakeListUsers[1].id, false);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('existe o no usuaro', () {
    test('existe o no usuario', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result =
          await dataSource.existsUser(userId, 'user1', 'user1@mp.com');

      //assert
      expect(result, equals(testUserModel));
    });

    test('existe o no usuario arroja null', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponseZero, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result =
          await dataSource.existsUser(userId, 'user1', 'user1@mp.com');

      //assert
      expect(result, equals(null));
    });

    test('existe o no usuario arroja error', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders))
          .thenAnswer((realInvocation) async => http.Response('', 500));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final call = dataSource.existsUser(userId, 'user1', 'user1@mp.com');

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('consigue usuarios que no estén en la organización', () {
    test('trae lista de usuarios', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result =
          await dataSource.getUsersNotInOrga('', 'orgaId', [], 1, 10);

      //assert
      expect(result, equals(ModelContainer.fromItem(testUserModel)));
    });

    test('error al traer lista de usuarios que no estén en orga', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders))
          .thenAnswer((realInvocation) async => http.Response('', 500));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final call = dataSource.getUsersNotInOrga('', 'orgaId', [], 1, 10);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('actualizar password de usuario', () {
    test('actualizar password de usuario', () async {
      //arrange
      UserModel toEdit = const UserModel(
          id: testUserId,
          name: "Editado",
          username: "edited",
          email: "ed@mp.com",
          enabled: true,
          builtIn: false,
          pictureUrl: null,
          pictureCloudFileId: null,
          pictureThumbnailUrl: null,
          pictureThumbnailCloudFileId: null,);
      final Map<String, dynamic> passData = {'password': '12345'};
      when(mockHttpClient.put(any,
              body: json.encode(passData), headers: testHeaders))
          .thenAnswer(
              (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act

      final result = await dataSource.updateUserPassword(testUserId, '12345');

      //assert
      expect(result, equals(true));
      //expect(toEdit, equals(fakeListUsers[2]));
    });

    test('actualizar password de usuario pero arroja error', () async {
      //arrange
      UserModel toEdit = const UserModel(
          id: testUserId,
          name: "Editado",
          username: "edited",
          email: "ed@mp.com",
          enabled: true,
          builtIn: false,
          pictureUrl: null,
          pictureCloudFileId: null,
          pictureThumbnailUrl: null,
          pictureThumbnailCloudFileId: null,);
      final Map<String, dynamic> passData = {'password': '12345'};
      when(mockHttpClient.put(any,
              body: json.encode(passData), headers: testHeaders))
          .thenAnswer((realInvocation) async => http.Response('', 500));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act

      final call = dataSource.updateUserPassword(testUserId, '12345');

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
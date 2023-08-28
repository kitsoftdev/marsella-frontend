import 'dart:convert';

import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/data/models/user_model.dart';
import 'package:marsellafrontend/domain/entities/user.dart';

void main() {
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
      pictureThumbnailCloudFileId: null,);

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
      pictureThumbnailCloudFileId: null,);

  group('user model methods', () {
    test('user model to entity', () {
      // assert
      final result = tUserModel.toEntity();
      expect(result, equals(tUser));
    });
    test(
      'debe retornar un UserModel desde un json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          '{"id":"$newUserId", "name":"Test User", "username": "test", "email": "te@mp.com", "enabled": true, "builtIn": false}',
        );

        // act
        final result = UserModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tUserModel));
      },
    );
    test(
      'debe retornar un json válido desde el user model',
      () async {
        // act
        final result = tUserModel.toJson();

        // assert
        final expectedJsonMap = {
          'id': newUserId,
          'name': 'Test User',
          'username': 'test',
          'email': 'te@mp.com',
          'enabled': true,
          'builtIn': false
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}

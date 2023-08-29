import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/domain/entities/user.dart';
import 'package:marsellafrontend/domain/usecases/users/add_user.dart';
import 'package:mockito/mockito.dart';

import 'user_test_helper.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late AddUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = AddUser(mockUserRepository);
  });

  final newUserId = Guid.newGuid.toString();

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

  test('debe agregar un nuevo user', () async {
    //arrange
    when(mockUserRepository.addUser(any, any, any, any))
        .thenAnswer((_) async => Right(tUser));

    //act
    final result = await usecase.execute(
        tUser.name, tUser.username, tUser.email, tUser.enabled);

    //assert
    expect(result, equals(Right(tUser)));
  });
}

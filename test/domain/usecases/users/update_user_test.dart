import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/domain/entities/user.dart';
import 'package:marsellafrontend/domain/usecases/users/update_user.dart';
import 'package:mockito/mockito.dart';

import 'user_test_helper.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late UpdateUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UpdateUser(mockUserRepository);
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

  test('debe actualizar un nuevo user', () async {
    //arrange
    when(mockUserRepository.updateUser(any, any))
        .thenAnswer((_) async => Right(tUser));

    //act
    final result = await usecase.execute(newUserId, tUser);

    //assert
    expect(result, Right(tUser));
  });
}

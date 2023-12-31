import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:marsellafrontend/data/datasources/user_data_source.dart';
import 'package:marsellafrontend/data/models/user_model.dart';

import '../../core/constants.dart';
import '../../core/exceptions.dart';
import '../../core/failures.dart';
import '../../core/model_container.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ModelContainer<User>>> getUsers(
      String searchText,
      String orgaId,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize) async {
    try {
      List<dynamic> order = [];
      fieldsOrder.forEach((key, value) {
        order.add([key, value == 1 ? value : -1]);
      });
      final result = await remoteDataSource.getUsers(
          searchText, orgaId, order, pageIndex, pageSize);

      return Right(result);
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, ModelContainer<User>>> getUsersNotInOrga(
      String searchText,
      String orgaId,
      Map<String, int> fieldsOrder,
      int pageIndex,
      int pageSize) async {
    try {
      List<dynamic> order = [];
      fieldsOrder.forEach((key, value) {
        order.add([key, value == 1 ? value : -1]);
      });

      final result = await remoteDataSource.getUsersNotInOrga(
          searchText, orgaId, order, pageIndex, pageSize);

      return Right(result);
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, User>> getUser(String userId) async {
    try {
      final result = await remoteDataSource.getUser(userId);

      return Right(result.toEntity());
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, User>> addUser(
      String name, String username, String email, bool enabled) async {
    try {
      UserModel userModel = UserModel(
          id: Guid.newGuid.toString(),
          name: name,
          username: username,
          email: email,
          enabled: enabled,
          builtIn: false,
          pictureUrl: null,
          pictureCloudFileId: null,
          pictureThumbnailUrl: null,
          pictureThumbnailCloudFileId: null,);

      final result = await remoteDataSource.addUser(userModel);

      return Right(result.toEntity());
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser(String userId) async {
    try {
      final result = await remoteDataSource.deleteUser(userId);

      return Right(result);
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, User>> enableUser(
      String userId, bool enableOrDisable) async {
    try {
      final result = await remoteDataSource.enableUser(userId, enableOrDisable);
      if (result) {
        final resultItem = await remoteDataSource.getUser(userId);
        return Right(resultItem.toEntity());
      }
      return const Left(
          ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(String userId, User user) async {
    try {
      UserModel userModel = UserModel(
          id: userId,
          name: user.name,
          username: user.username,
          email: user.email,
          enabled: user.enabled,
          builtIn: user.builtIn,
          pictureUrl: user.pictureUrl,
          pictureCloudFileId: user.pictureCloudFileId,
          pictureThumbnailUrl: user.pictureThumbnailUrl,
          pictureThumbnailCloudFileId: user.pictureThumbnailCloudFileId,);

      final result = await remoteDataSource.updateUser(userId, userModel);

      return Right(result.toEntity());
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile(String userId, User user) async {
    try {
      UserModel userModel = UserModel(
          id: userId,
          name: user.name,
          username: user.username,
          email: user.email,
          enabled: user.enabled,
          builtIn: user.builtIn,
          pictureUrl: user.pictureUrl,
          pictureCloudFileId: user.pictureCloudFileId,
          pictureThumbnailUrl: user.pictureThumbnailUrl,
          pictureThumbnailCloudFileId: user.pictureThumbnailCloudFileId,);

      final result = await remoteDataSource.updateProfile(userId, userModel);

      return Right(result.toEntity());
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, User?>> existsUser(
      String userId, String username, String email) async {
    try {
      final result = await remoteDataSource.existsUser(userId, username, email);

      if (result == null) {
        return const Right(null);
      } else {
        return Right(result.toEntity());
      }
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, User?>> existsProfile(
      String userId, String username, String email) async {
    try {
      final result =
          await remoteDataSource.existsProfile(userId, username, email);

      if (result == null) {
        return const Right(null);
      } else {
        return Right(result.toEntity());
      }
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserPassword(
      String userId, String password) async {
    try {
      final result =
          await remoteDataSource.updateUserPassword(userId, password);

      return Right(result);
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProfilePassword(
      String userId, String password) async {
    try {
      final result =
          await remoteDataSource.updateProfilePassword(userId, password);

      return Right(result);
    } on ConnectionException {
      return const Left(ConnectionFailure(ExceptionMessage.connectionException));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.getMessage));
    } on Exception {
      return const Left(ConnectionFailure(ExceptionMessage.exception));
    }
  }
}

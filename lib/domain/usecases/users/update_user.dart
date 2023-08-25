import 'package:dartz/dartz.dart';
import 'package:marsellafrontend/core/failures.dart';
import 'package:marsellafrontend/domain/entities/user.dart';

import '../../repositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;
  UpdateUser(this.repository);
  Future<Either<Failure, User>> execute(String userId, User user) async {
    return await repository.updateUser(userId, user);
  }
}

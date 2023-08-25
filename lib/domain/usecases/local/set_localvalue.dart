import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../repositories/local_repository.dart';

class SetLocalValue {
  final LocalRepository repository;
  SetLocalValue(this.repository);
  Future<Either<Failure, bool>> execute(String key, String value) async {
    return await repository.setLocalValue(key, value);
  }
}

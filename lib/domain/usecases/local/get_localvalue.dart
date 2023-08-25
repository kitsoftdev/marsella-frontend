import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../repositories/local_repository.dart';

class GetLocalValue {
  final LocalRepository repository;
  GetLocalValue(this.repository);
  Future<Either<Failure, String>> execute(String key) async {
    return await repository.getLocalValue(key);
  }
}

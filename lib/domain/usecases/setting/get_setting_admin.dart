import 'package:dartz/dartz.dart';
import 'package:marsellafrontend/core/failures.dart';

import '../../entities/setting.dart';
import '../../repositories/setting_repository.dart';

class GetSettingAdmin {
  final SettingRepository repository;
  GetSettingAdmin(this.repository);
  Future<Either<Failure, List<Setting>>> execute(String orgaId) async {
    return await repository.getSettingAdmin(orgaId);
  }
}

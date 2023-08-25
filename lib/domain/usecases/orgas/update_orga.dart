import 'package:dartz/dartz.dart';
import 'package:marsellafrontend/core/failures.dart';
import 'package:marsellafrontend/domain/entities/orga.dart';

import '../../repositories/orga_repository.dart';

///Caso de uso para actualizar una organización
class UpdateOrga {
  final OrgaRepository repository;
  UpdateOrga(this.repository);
  Future<Either<Failure, Orga>> execute(String orgaId, Orga orga) async {
    return await repository.updateOrga(orgaId, orga);
  }
}

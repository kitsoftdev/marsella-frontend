// Mocks generated by Mockito 5.3.2 from annotations
// in marsellafrontend/test/data/repositories/orga_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:marsellafrontend/data/datasources/orga_data_source.dart' as _i4;
import 'package:marsellafrontend/data/models/orga_model.dart' as _i2;
import 'package:marsellafrontend/data/models/orgauser_model.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeOrgaModel_0 extends _i1.SmartFake implements _i2.OrgaModel {
  _FakeOrgaModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOrgaUserModel_1 extends _i1.SmartFake implements _i3.OrgaUserModel {
  _FakeOrgaUserModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [OrgaRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockOrgaRemoteDataSource extends _i1.Mock
    implements _i4.OrgaRemoteDataSource {
  MockOrgaRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i2.OrgaModel>> getOrgas(
    String? filter,
    String? fieldOrder,
    double? pageNumber,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOrgas,
          [
            filter,
            fieldOrder,
            pageNumber,
            pageSize,
          ],
        ),
        returnValue: _i5.Future<List<_i2.OrgaModel>>.value(<_i2.OrgaModel>[]),
      ) as _i5.Future<List<_i2.OrgaModel>>);
  @override
  _i5.Future<_i2.OrgaModel> getOrga(String? orgaId) => (super.noSuchMethod(
        Invocation.method(
          #getOrga,
          [orgaId],
        ),
        returnValue: _i5.Future<_i2.OrgaModel>.value(_FakeOrgaModel_0(
          this,
          Invocation.method(
            #getOrga,
            [orgaId],
          ),
        )),
      ) as _i5.Future<_i2.OrgaModel>);
  @override
  _i5.Future<List<_i3.OrgaUserModel>> getOrgaUsers(String? orgaId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOrgaUsers,
          [orgaId],
        ),
        returnValue:
            _i5.Future<List<_i3.OrgaUserModel>>.value(<_i3.OrgaUserModel>[]),
      ) as _i5.Future<List<_i3.OrgaUserModel>>);
  @override
  _i5.Future<List<_i3.OrgaUserModel>> getOrgaUser(
    String? orgaId,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOrgaUser,
          [
            orgaId,
            userId,
          ],
        ),
        returnValue:
            _i5.Future<List<_i3.OrgaUserModel>>.value(<_i3.OrgaUserModel>[]),
      ) as _i5.Future<List<_i3.OrgaUserModel>>);
  @override
  _i5.Future<_i2.OrgaModel> addOrga(_i2.OrgaModel? orga) => (super.noSuchMethod(
        Invocation.method(
          #addOrga,
          [orga],
        ),
        returnValue: _i5.Future<_i2.OrgaModel>.value(_FakeOrgaModel_0(
          this,
          Invocation.method(
            #addOrga,
            [orga],
          ),
        )),
      ) as _i5.Future<_i2.OrgaModel>);
  @override
  _i5.Future<_i3.OrgaUserModel> addOrgaUser(_i3.OrgaUserModel? orgaUser) =>
      (super.noSuchMethod(
        Invocation.method(
          #addOrgaUser,
          [orgaUser],
        ),
        returnValue: _i5.Future<_i3.OrgaUserModel>.value(_FakeOrgaUserModel_1(
          this,
          Invocation.method(
            #addOrgaUser,
            [orgaUser],
          ),
        )),
      ) as _i5.Future<_i3.OrgaUserModel>);
  @override
  _i5.Future<bool> deleteOrga(String? orgaId) => (super.noSuchMethod(
        Invocation.method(
          #deleteOrga,
          [orgaId],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<bool> deleteOrgaUser(
    String? orgaId,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteOrgaUser,
          [
            orgaId,
            userId,
          ],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<bool> enableOrga(
    String? orgaId,
    bool? enableOrDisable,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #enableOrga,
          [
            orgaId,
            enableOrDisable,
          ],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<bool> enableOrgaUser(
    String? orgaId,
    String? userId,
    bool? enableOrDisable,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #enableOrgaUser,
          [
            orgaId,
            userId,
            enableOrDisable,
          ],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<_i2.OrgaModel> updateOrga(
    String? orgaId,
    _i2.OrgaModel? orga,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateOrga,
          [
            orgaId,
            orga,
          ],
        ),
        returnValue: _i5.Future<_i2.OrgaModel>.value(_FakeOrgaModel_0(
          this,
          Invocation.method(
            #updateOrga,
            [
              orgaId,
              orga,
            ],
          ),
        )),
      ) as _i5.Future<_i2.OrgaModel>);
  @override
  _i5.Future<_i2.OrgaModel?> existsOrga(
    String? orgaId,
    String? code,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #existsOrga,
          [
            orgaId,
            code,
          ],
        ),
        returnValue: _i5.Future<_i2.OrgaModel?>.value(),
      ) as _i5.Future<_i2.OrgaModel?>);
  @override
  _i5.Future<_i3.OrgaUserModel> updateOrgaUser(
    String? orgaId,
    String? userId,
    _i3.OrgaUserModel? orgaUser,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateOrgaUser,
          [
            orgaId,
            userId,
            orgaUser,
          ],
        ),
        returnValue: _i5.Future<_i3.OrgaUserModel>.value(_FakeOrgaUserModel_1(
          this,
          Invocation.method(
            #updateOrgaUser,
            [
              orgaId,
              userId,
              orgaUser,
            ],
          ),
        )),
      ) as _i5.Future<_i3.OrgaUserModel>);
  @override
  _i5.Future<List<_i2.OrgaModel>> getOrgasByUser(String? orgaId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getOrgasByUser,
          [orgaId],
        ),
        returnValue: _i5.Future<List<_i2.OrgaModel>>.value(<_i2.OrgaModel>[]),
      ) as _i5.Future<List<_i2.OrgaModel>>);
}
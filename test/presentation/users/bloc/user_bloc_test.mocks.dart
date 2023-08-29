// Mocks generated by Mockito 5.3.2 from annotations
// in marsellafrontend/test/presentation/users/bloc/user_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:dartz/dartz.dart' as _i3;
import 'package:marsellafrontend/core/failures.dart' as _i9;
import 'package:marsellafrontend/core/model_container.dart' as _i15;
import 'package:marsellafrontend/data/models/session_model.dart' as _i19;
import 'package:marsellafrontend/domain/entities/orgauser.dart' as _i23;
import 'package:marsellafrontend/domain/entities/user.dart' as _i10;
import 'package:marsellafrontend/domain/repositories/local_repository.dart'
    as _i5;
import 'package:marsellafrontend/domain/repositories/login_repository.dart'
    as _i4;
import 'package:marsellafrontend/domain/repositories/orga_repository.dart' as _i6;
import 'package:marsellafrontend/domain/repositories/user_repository.dart' as _i2;
import 'package:marsellafrontend/domain/usecases/local/get_session_status.dart'
    as _i18;
import 'package:marsellafrontend/domain/usecases/login/register_user.dart'
    as _i17;
import 'package:marsellafrontend/domain/usecases/orgas/add_orgauser.dart' as _i27;
import 'package:marsellafrontend/domain/usecases/orgas/delete_orgauser.dart'
    as _i25;
import 'package:marsellafrontend/domain/usecases/orgas/get_orgauser.dart' as _i22;
import 'package:marsellafrontend/domain/usecases/orgas/update_orgauser.dart'
    as _i24;
import 'package:marsellafrontend/domain/usecases/users/add_user.dart' as _i7;
import 'package:marsellafrontend/domain/usecases/users/delete_user.dart' as _i11;
import 'package:marsellafrontend/domain/usecases/users/enable_user.dart' as _i12;
import 'package:marsellafrontend/domain/usecases/users/exists_user.dart' as _i20;
import 'package:marsellafrontend/domain/usecases/users/get_user.dart' as _i13;
import 'package:marsellafrontend/domain/usecases/users/get_users.dart' as _i14;
import 'package:marsellafrontend/domain/usecases/users/get_users_notin_orga.dart'
    as _i26;
import 'package:marsellafrontend/domain/usecases/users/update_user.dart' as _i16;
import 'package:marsellafrontend/domain/usecases/users/update_user_password.dart'
    as _i21;
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

class _FakeUserRepository_0 extends _i1.SmartFake
    implements _i2.UserRepository {
  _FakeUserRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLoginRepository_2 extends _i1.SmartFake
    implements _i4.LoginRepository {
  _FakeLoginRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLocalRepository_3 extends _i1.SmartFake
    implements _i5.LocalRepository {
  _FakeLocalRepository_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOrgaRepository_4 extends _i1.SmartFake
    implements _i6.OrgaRepository {
  _FakeOrgaRepository_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AddUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddUser extends _i1.Mock implements _i7.AddUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i10.User>> execute(
    String? name,
    String? username,
    String? email,
    bool? enabled,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            name,
            username,
            email,
            enabled,
          ],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, _i10.User>>.value(
            _FakeEither_1<_i9.Failure, _i10.User>(
          this,
          Invocation.method(
            #execute,
            [
              name,
              username,
              email,
              enabled,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, _i10.User>>.value(
                _FakeEither_1<_i9.Failure, _i10.User>(
          this,
          Invocation.method(
            #execute,
            [
              name,
              username,
              email,
              enabled,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, _i10.User>>);
}

/// A class which mocks [DeleteUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteUser extends _i1.Mock implements _i11.DeleteUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, bool>> execute(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [userId],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, bool>>.value(
            _FakeEither_1<_i9.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [userId],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, bool>>.value(
                _FakeEither_1<_i9.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [userId],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, bool>>);
}

/// A class which mocks [EnableUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockEnableUser extends _i1.Mock implements _i12.EnableUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i10.User>> execute(
    String? userId,
    bool? enableOrDisable,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            userId,
            enableOrDisable,
          ],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, _i10.User>>.value(
            _FakeEither_1<_i9.Failure, _i10.User>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              enableOrDisable,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, _i10.User>>.value(
                _FakeEither_1<_i9.Failure, _i10.User>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              enableOrDisable,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, _i10.User>>);
}

/// A class which mocks [GetUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUser extends _i1.Mock implements _i13.GetUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i10.User>> execute(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [userId],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, _i10.User>>.value(
            _FakeEither_1<_i9.Failure, _i10.User>(
          this,
          Invocation.method(
            #execute,
            [userId],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, _i10.User>>.value(
                _FakeEither_1<_i9.Failure, _i10.User>(
          this,
          Invocation.method(
            #execute,
            [userId],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, _i10.User>>);
}

/// A class which mocks [GetUsers].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUsers extends _i1.Mock implements _i14.GetUsers {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i15.ModelContainer<_i10.User>>> execute(
    String? searchText,
    String? orgaId,
    Map<String, int>? fieldsOrder,
    int? pageIndex,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            searchText,
            orgaId,
            fieldsOrder,
            pageIndex,
            pageSize,
          ],
        ),
        returnValue: _i8.Future<
                _i3.Either<_i9.Failure, _i15.ModelContainer<_i10.User>>>.value(
            _FakeEither_1<_i9.Failure, _i15.ModelContainer<_i10.User>>(
          this,
          Invocation.method(
            #execute,
            [
              searchText,
              orgaId,
              fieldsOrder,
              pageIndex,
              pageSize,
            ],
          ),
        )),
        returnValueForMissingStub: _i8.Future<
                _i3.Either<_i9.Failure, _i15.ModelContainer<_i10.User>>>.value(
            _FakeEither_1<_i9.Failure, _i15.ModelContainer<_i10.User>>(
          this,
          Invocation.method(
            #execute,
            [
              searchText,
              orgaId,
              fieldsOrder,
              pageIndex,
              pageSize,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, _i15.ModelContainer<_i10.User>>>);
}

/// A class which mocks [UpdateUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateUser extends _i1.Mock implements _i16.UpdateUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i10.User>> execute(
    String? userId,
    _i10.User? user,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            userId,
            user,
          ],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, _i10.User>>.value(
            _FakeEither_1<_i9.Failure, _i10.User>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              user,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, _i10.User>>.value(
                _FakeEither_1<_i9.Failure, _i10.User>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              user,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, _i10.User>>);
}

/// A class which mocks [RegisterUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockRegisterUser extends _i1.Mock implements _i17.RegisterUser {
  @override
  _i4.LoginRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeLoginRepository_2(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeLoginRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.LoginRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, bool>> execute(
    String? name,
    String? username,
    String? email,
    String? orgaId,
    String? password,
    String? role,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            name,
            username,
            email,
            orgaId,
            password,
            role,
          ],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, bool>>.value(
            _FakeEither_1<_i9.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [
              name,
              username,
              email,
              orgaId,
              password,
              role,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, bool>>.value(
                _FakeEither_1<_i9.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [
              name,
              username,
              email,
              orgaId,
              password,
              role,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, bool>>);
}

/// A class which mocks [GetSession].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSession extends _i1.Mock implements _i18.GetSession {
  @override
  _i5.LocalRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeLocalRepository_3(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeLocalRepository_3(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i5.LocalRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i19.SessionModel>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i8.Future<_i3.Either<_i9.Failure, _i19.SessionModel>>.value(
                _FakeEither_1<_i9.Failure, _i19.SessionModel>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, _i19.SessionModel>>.value(
                _FakeEither_1<_i9.Failure, _i19.SessionModel>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, _i19.SessionModel>>);
}

/// A class which mocks [ExistsUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockExistsUser extends _i1.Mock implements _i20.ExistsUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i10.User?>> execute(
    String? userId,
    String? username,
    String? email,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            userId,
            username,
            email,
          ],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, _i10.User?>>.value(
            _FakeEither_1<_i9.Failure, _i10.User?>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              username,
              email,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, _i10.User?>>.value(
                _FakeEither_1<_i9.Failure, _i10.User?>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              username,
              email,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, _i10.User?>>);
}

/// A class which mocks [UpdateUserPassword].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateUserPassword extends _i1.Mock
    implements _i21.UpdateUserPassword {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, bool>> execute(
    String? userId,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            userId,
            password,
          ],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, bool>>.value(
            _FakeEither_1<_i9.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, bool>>.value(
                _FakeEither_1<_i9.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              password,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, bool>>);
}

/// A class which mocks [GetOrgaUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetOrgaUser extends _i1.Mock implements _i22.GetOrgaUser {
  @override
  _i6.OrgaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeOrgaRepository_4(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeOrgaRepository_4(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i6.OrgaRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, List<_i23.OrgaUser>>> execute(
    String? orgaId,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            userId,
          ],
        ),
        returnValue:
            _i8.Future<_i3.Either<_i9.Failure, List<_i23.OrgaUser>>>.value(
                _FakeEither_1<_i9.Failure, List<_i23.OrgaUser>>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, List<_i23.OrgaUser>>>.value(
                _FakeEither_1<_i9.Failure, List<_i23.OrgaUser>>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, List<_i23.OrgaUser>>>);
}

/// A class which mocks [UpdateOrgaUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateOrgaUser extends _i1.Mock implements _i24.UpdateOrgaUser {
  @override
  _i6.OrgaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeOrgaRepository_4(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeOrgaRepository_4(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i6.OrgaRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i23.OrgaUser>> execute(
    String? orgaId,
    String? userId,
    _i23.OrgaUser? orgaUser,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            userId,
            orgaUser,
          ],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, _i23.OrgaUser>>.value(
            _FakeEither_1<_i9.Failure, _i23.OrgaUser>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
              orgaUser,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, _i23.OrgaUser>>.value(
                _FakeEither_1<_i9.Failure, _i23.OrgaUser>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
              orgaUser,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, _i23.OrgaUser>>);
}

/// A class which mocks [DeleteOrgaUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteOrgaUser extends _i1.Mock implements _i25.DeleteOrgaUser {
  @override
  _i6.OrgaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeOrgaRepository_4(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeOrgaRepository_4(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i6.OrgaRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, bool>> execute(
    String? orgaId,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            userId,
          ],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, bool>>.value(
            _FakeEither_1<_i9.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, bool>>.value(
                _FakeEither_1<_i9.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, bool>>);
}

/// A class which mocks [GetUsersNotInOrga].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUsersNotInOrga extends _i1.Mock implements _i26.GetUsersNotInOrga {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i15.ModelContainer<_i10.User>>> execute(
    String? searchText,
    String? orgaId,
    Map<String, int>? fieldsOrder,
    int? pageIndex,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            searchText,
            orgaId,
            fieldsOrder,
            pageIndex,
            pageSize,
          ],
        ),
        returnValue: _i8.Future<
                _i3.Either<_i9.Failure, _i15.ModelContainer<_i10.User>>>.value(
            _FakeEither_1<_i9.Failure, _i15.ModelContainer<_i10.User>>(
          this,
          Invocation.method(
            #execute,
            [
              searchText,
              orgaId,
              fieldsOrder,
              pageIndex,
              pageSize,
            ],
          ),
        )),
        returnValueForMissingStub: _i8.Future<
                _i3.Either<_i9.Failure, _i15.ModelContainer<_i10.User>>>.value(
            _FakeEither_1<_i9.Failure, _i15.ModelContainer<_i10.User>>(
          this,
          Invocation.method(
            #execute,
            [
              searchText,
              orgaId,
              fieldsOrder,
              pageIndex,
              pageSize,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, _i15.ModelContainer<_i10.User>>>);
}

/// A class which mocks [AddOrgaUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddOrgaUser extends _i1.Mock implements _i27.AddOrgaUser {
  @override
  _i6.OrgaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeOrgaRepository_4(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeOrgaRepository_4(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i6.OrgaRepository);
  @override
  _i8.Future<_i3.Either<_i9.Failure, _i23.OrgaUser>> execute(
    String? orgaId,
    String? userId,
    List<String>? roles,
    bool? enabled,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            userId,
            roles,
            enabled,
          ],
        ),
        returnValue: _i8.Future<_i3.Either<_i9.Failure, _i23.OrgaUser>>.value(
            _FakeEither_1<_i9.Failure, _i23.OrgaUser>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
              roles,
              enabled,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i3.Either<_i9.Failure, _i23.OrgaUser>>.value(
                _FakeEither_1<_i9.Failure, _i23.OrgaUser>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
              roles,
              enabled,
            ],
          ),
        )),
      ) as _i8.Future<_i3.Either<_i9.Failure, _i23.OrgaUser>>);
}

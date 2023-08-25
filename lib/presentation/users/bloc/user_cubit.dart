import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsellafrontend/core/constants.dart';

import '../../../domain/entities/orgauser.dart';
import '../../../domain/usecases/users/enable_user.dart';

class UserOrgaDialogEditCubit extends Cubit<UserOrgaDialogEditState> {
  UserOrgaDialogEditCubit(OrgaUser orgaUser)
      : super(UserOrgaDialogEditState("enabled", false)) {
    state.checks["enabled"] = orgaUser.enabled;
    for (var element in orgaUser.roles) {
      state.checks[element] = true;
    }
  }

  void changeValue(String name, bool value) {
    emit(state.copyWith(name: name, changeState: value));
  }
}

class UserOrgaDialogEditState extends Equatable {
  late Map<String, bool> checks;
  late bool deleted;

  @override
  List<Object?> get props => [deleted, checks];

  UserOrgaDialogEditState(String name, bool changeState) {
    deleted = false;
    checks = <String, bool>{};
    checks.addEntries(<String, bool>{"enabled": false}.entries);
    Roles.toList().forEach((element) {
      checks.addEntries(<String, bool>{element: false}.entries);
    });
    checks[name] = changeState;
  }

  UserOrgaDialogEditState copyWith(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = UserOrgaDialogEditState(name, changeState);
    ous.checks = nchecks;
    return ous;
  }
}

class UserLiveCubit extends Cubit<UserLiveState> {
  final EnableUser _enableUser;
  UserLiveCubit(
    this._enableUser,
  ) 
  : super(UserLiveState(const <String, bool>{}));

  void changeCheckEnable(String postId, bool enabled) async {
    final result = await _enableUser.execute(postId, enabled);
      result.fold(
          (l) => {},
          (r) => {
            emit(state.copyWithCheckEnable(postId: postId, checkValue: enabled))
          });
  }
}

class UserLiveState extends Equatable {
  late Map<String, bool> checksList;

  @override
  List<Object?> get props => [checksList];

  UserLiveState(
      this.checksList,);

  UserLiveState copyWithCheckEnable(
      {required String postId, required bool checkValue}) {
    Map<String, bool> ncheckList = <String, bool>{};
    ncheckList.addAll(checksList);
    ncheckList[postId] = checkValue;
    final ous = UserLiveState(
        ncheckList,);
    return ous;
  }
}

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsellafrontend/core/validators.dart';
import 'package:marsellafrontend/domain/entities/session.dart';

import '../../data/models/session_model.dart';
import '../../domain/entities/orga.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/local/get_has_login.dart';
import '../../domain/usecases/local/get_session_status.dart';
import '../../domain/usecases/orgas/get_orgasbyuser.dart';
import '../../domain/usecases/users/get_user.dart';

class SessionLiveCubit extends Cubit<SessionLiveState> {
  final GetSession _getSession;
  final GetHasLogIn _hasLogIn;
  final GetUser _getUser;
  final GetOrgasByUser _getOrgasByUser;
  late bool timeCancel = false;
  SessionLiveCubit(
      this._getSession, this._hasLogIn, this._getUser, this._getOrgasByUser)
      : super(const SessionLiveState(null, null, [], null,));

  void login(User userLoaded, Orga orgaSelected, List<Orga> orgaListFromUser,
      Session sessionLoaded) {
    emit(state.copyWithNewSession(
        userLoaded: userLoaded,
        orgaSelected: orgaSelected,
        orgaListFromUser: orgaListFromUser,
        sessionLoaded: sessionLoaded));
    expireSession();
  }

  void logoff() {
    timeCancel = true;
    emit(state.copyWithLogoff());
  }

  void expireSession() async {
    timeCancel = false;

    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (timeCancel) {
        timer.cancel();
        return;
      }
      if (!Validators.validateToken(state.session!.token)) {
        logoff();
      }
    });
  }

  void readSession() async {
    bool hasLogin = false;
    SessionModel? session;
    User? user;
    List<Orga> listorgas = [];
    Orga? orga;

    final resultLogIn = await _hasLogIn.execute();
    resultLogIn.fold((l) => null, (r) => {hasLogin = r});

    if (hasLogin) {
      final resultSession = await _getSession.execute();
      resultSession.fold(
          (l) => null,
          (r) => {
                session = SessionModel(
                    token: r.token, username: r.username, name: r.name)
              });
    }

    if (session != null &&
        Validators.validateToken(session!.token) &&
        session?.getUserId() != null &&
        session?.getOrgaId() != null) {
      final userId = session?.getUserId() ?? '';
      final orgaId = session?.getOrgaId() ?? '';

      final resultUser = await _getUser.execute(userId);
      resultUser.fold((l) => null, (r) => {user = r});

      final resultOrgas = await _getOrgasByUser.execute(userId);
      resultOrgas.fold((l) => null, (r) {
        listorgas = r;
      });

      if (user != null && listorgas.isNotEmpty && orgaId.isNotEmpty) {
        emit(state.copyWithNewSession(
            userLoaded: user!,
            orgaSelected:
                listorgas.firstWhere((element) => element.id == orgaId),
            orgaListFromUser: listorgas,
            sessionLoaded: session!));
        return;
      }
      emit(state.copyWithLogoff());
    }
  }

  String get getUserId => state.user?.id ?? "";
  String get getOrgaId => state.orga?.id ?? "";
}

class SessionLiveState extends Equatable {
  final User? user;
  final Orga? orga;
  final List<Orga> orgaList;
  final Session? session;

  @override
  List<Object?> get props => [user, orga, orgaList, session, ];

  const SessionLiveState(
    this.user,
    this.orga,
    this.orgaList,
    this.session,
  );

  SessionLiveState copyWithNewSession(
      {required User userLoaded,
      required Orga orgaSelected,
      required List<Orga> orgaListFromUser,
      required Session sessionLoaded}) {
    final ous = SessionLiveState(
        userLoaded, orgaSelected, orgaListFromUser, sessionLoaded,);
    return ous;
  }

  SessionLiveState copyWithLogoff() {
    const ous = SessionLiveState(null, null, [], null,);
    return ous;
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marsellafrontend/domain/usecases/sidedrawer/do_logoff.dart';
import 'package:marsellafrontend/domain/usecases/sidedrawer/get_side_options.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/session_model.dart';
import '../../../domain/entities/session.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/local/get_has_login.dart';
import '../../../domain/usecases/local/get_session_status.dart';
import '../../../domain/usecases/login/change_orga.dart';
import '../../../domain/entities/orga.dart';
import '../../../domain/usecases/orgas/get_orga.dart';
import '../../../domain/usecases/orgas/get_orgasbyuser.dart';

class SideDrawerBloc extends Bloc<SideDrawerEvent, SideDrawerState> {
  final GetSideOptions _getOptions;
  final DoLogOff _doLogOff;
  final GetSession _getSession;
  final GetOrgasByUser _getOrgasByUser;
  final GetHasLogIn _hasLogIn;
  final ChangeOrga _changeOrga;

  SideDrawerBloc(this._getOptions, this._doLogOff, this._getSession,
      this._getOrgasByUser, this._hasLogIn, this._changeOrga)
      : super(SideDrawerEmpty()) {
    on<OnSideDrawerLoading>(
      (event, emit) async {
        emit(SideDrawerLoading());

        List<Orga> listOrgas = event.orgaList;
        Orga? orga = event.orga;
        User? user = event.user;

        final result = await _getOptions.execute();
        result.fold(
            (l) => {emit(SideDrawerError(l.message))},
            (optList) => {
                  emit(SideDrawerReady(
                      optList, listOrgas, orga, false, false, user))
                });
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnSideDrawerChangeOrga>((event, emit) async {
      emit(SideDrawerLoading());

      final orgaId = event.orgaId;
      List<Orga> listOrgas = [];
      User user = event.user;
      SessionModel? session; //= ( name:'', token:'', usernam:'');

      final resultChange = await _changeOrga.execute(user.username, orgaId);

      resultChange.fold((l) => {emit(SideDrawerError(l.message))}, (r) async {
        session = SessionModel(
          token: r.token,
          username: r.username,
          name: r.name,
        );
      });

      final userId = session?.getUserId();
      final resultOrgas = await _getOrgasByUser.execute(userId!);

      resultOrgas.fold(
          (l) => {emit(SideDrawerError(l.message))}, (r) => {listOrgas = r});

      Orga orga =
          listOrgas.firstWhere((element) => element.id == session?.getOrgaId());

      final result = await _getOptions.execute();

      result.fold(
          (l) => {emit(SideDrawerError(l.message))},
          (optList) => {
                emit(SideDrawerReady(
                    optList, listOrgas, orga, true, false, user))
              });
    });

    on<OnSideDrawerLogOff>((event, emit) async {
      emit(SideDrawerLoading());
      final result = await _doLogOff.execute();

      result.fold((l) => {emit(SideDrawerError(l.message))},
          (r) => {emit(SideDrawerEmpty())});
    });

    on<OnSideDrawerReady>((event, emit) async {
      emit(SideDrawerReady(event.opts, event.orgas, event.orga, event.reload,
          event.changedPage, event.user));
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

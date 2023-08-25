import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'notconnection_event.dart';
import 'notconnection_state.dart';

class NotConnectionBloc extends Bloc<NotConnectionEvent, NotConnectionState> {

  NotConnectionBloc(
  ) : super(NotConnectionStart()) {
    on<OnNotConnectionStarter>((event, emit) => emit(NotConnectionStart()));

    on<OnNotConnectionInternet>(
      (event, emit) async {
        emit(NotConnectionInternet());
        /*emit(NotConnectionLoading());

        final result = await _getNotConnection.execute(event.name);

        result.fold((l) => emit(NotConnectionError(l.message)),
            (role) => {emit(NotConnectionLoaded(role))});*/
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

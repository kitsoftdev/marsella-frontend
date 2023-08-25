import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/searchpost_cubit.dart';
import '../../../core/bloc/visibility_cubit.dart';
import '../../users/bloc/user_bloc.dart';
import '../../users/bloc/user_event.dart';
import 'nav_event.dart';
import 'nav_state.dart';

///BLOC de navegación para las pantallas de la aplicación.
///
///Considera sólo un evento [NavigateTo] que indica a qué página se
///desea navegar, con eso emite un estado con el destino a navegar.

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc()
      : super(const NavState(
            NavItem.pageUsers, <String, dynamic>{"searchText": ""})) {
    on<NavigateTo>(
      (event, emit) async {
        if (event.destination != state.selectedItem || event.force == true) {
          if (event.force == null || event.force == false) {
            event.context.read<SearchPostLiveCubit>().changeSearchText('');
            event.context.read<SearchPostLiveCubit>().cleanSearchText();
            event.context.read<VisibilityLiveCubit>().showVisibility();
            event.context.read<VisibilityLiveCubit>().hideVisibilitySub();
          }

          switch (state.selectedItem) {
            case NavItem.pageUsers:
              {
                event.context.read<UserBloc>().add(OnUserStarter());
              }
              break;
          }
          emit(NavState(event.destination, event.args));
        }
      },
    );
  }
}

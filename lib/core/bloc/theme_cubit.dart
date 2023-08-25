import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/local/get_localvalue.dart';
import '../../domain/usecases/local/set_localvalue.dart';

class ThemeLiveCubit extends Cubit<ThemeLiveState> {
  final GetLocalValue getLocalValue;
  final SetLocalValue setLocalValue;
  ThemeLiveCubit(this.getLocalValue, this.setLocalValue)
      : super(const ThemeLiveState(""));

  void changeSwitchValue(String value) {
    emit(state.copyWithChangeTheme(newThemeMode: value));
    _setThemeMode(value);
  }

  void changeThemeFromCache() {
    getThemeMode().then((value) {
      if (value == "") {
        value = "green";
      }
      emit(state.copyWithChangeTheme(newThemeMode: value));
    });
  }

  Future<String> getThemeMode() async {
    String tm = state.themeMode;
    if (state.themeMode == "") {
      final value = await getLocalValue.execute("themeMode");
      value.fold((l) => null, (r) {
        if (r == "") {
          r = "green";
        }
        tm = r;
      });
    } else {
      return state.themeMode;
    }
    return tm;
  }

  bool _setThemeMode(String value) {
    setLocalValue.execute("themeMode", value);
    return true;
  }
}

class ThemeLiveState extends Equatable {
  final String themeMode;

  @override
  List<Object?> get props => [themeMode];

  const ThemeLiveState(this.themeMode);

  ThemeLiveState copyWithChangeTheme({required String newThemeMode}) {
    final ous = ThemeLiveState(newThemeMode);
    return ous;
  }
}

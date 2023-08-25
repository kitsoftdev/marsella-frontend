import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndicatorLiveCubit extends Cubit<IndicatorLiveState> {
  IndicatorLiveCubit() : super(const IndicatorLiveState(false));

  void changeValue(bool value) {
    emit(state.copyWithChange(changeState: value));
  }

  void resetIndicator() {
    emit(state.copyWithChange(changeState: false));
  }

  bool get showIndicator => state.check;
}

class IndicatorLiveState extends Equatable {
  final bool check;
  @override
  List<Object?> get props => [
        check,
      ];

  const IndicatorLiveState(this.check);

  IndicatorLiveState copyWithChange({
    required bool changeState,
  }) {
    final ous = IndicatorLiveState(changeState);
    return ous;
  }
}

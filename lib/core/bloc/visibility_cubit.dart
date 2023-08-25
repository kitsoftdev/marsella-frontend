import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisibilityLiveCubit extends Cubit<VisibilityLiveState> {
  VisibilityLiveCubit()
      : super(const VisibilityLiveState(true, false,));

  void showVisibility() {
    emit(state.copyWithVisibilityChance(visibility: true));
  }

  void hideVisibility() {
    emit(state.copyWithVisibilityChance(visibility: false));
  }

  void showVisibilitySub() {
    emit(state.copyWithVisibilityChanceSub(visibilitySub: true));
  }

  void hideVisibilitySub() {
    emit(state.copyWithVisibilityChanceSub(visibilitySub: false));
  }
}

class VisibilityLiveState extends Equatable {
  final bool visibility;
  final bool visibilitySub;

  @override
  List<Object?> get props => [
    visibility,
    visibilitySub,];

  const VisibilityLiveState(
    this.visibility,
    this.visibilitySub,
  );

  VisibilityLiveState copyWithVisibilityChance({required bool visibility}) {
    final ous = VisibilityLiveState(visibility, visibilitySub,);
    return ous;
  }

  VisibilityLiveState copyWithVisibilityChanceSub({required bool visibilitySub}) {
    final ous = VisibilityLiveState(visibility, visibilitySub,);
    return ous;
  }

}
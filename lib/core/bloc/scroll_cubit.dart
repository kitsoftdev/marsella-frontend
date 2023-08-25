import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollLiveCubit extends Cubit<ScrollLiveState> {
  ScrollLiveCubit() : super(ScrollLiveState(ScrollController()));

  void newListener(void Function() listener) {
    emit(state.copyWithNewControllerListener(functionListener: listener));
  }

  ScrollController get scrollController => state.scrollController;
}

class ScrollLiveState extends Equatable {
  final ScrollController scrollController;

  @override
  List<Object?> get props => [scrollController];

  const ScrollLiveState(this.scrollController);

  ScrollLiveState copyWithNewControllerListener(
      {required void Function() functionListener}) {
    ScrollController controller = ScrollController();
    controller.addListener(functionListener);

    final ous = ScrollLiveState(controller);
    return ous;
  }
}

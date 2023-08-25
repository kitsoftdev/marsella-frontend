import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityLiveCubit extends Cubit<ConnectivityLiveState> {
  ConnectivityLiveCubit()
      : super(const ConnectivityLiveState(ConnectivityResult.none, "")) {
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void _initConnectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    emit(state.copyWithStatus(status: result));
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    emit(state.copyWithStatus(status: result));
  }

  ConnectivityResult get connectionStatus => state.connectionStatus;
}

class ConnectivityLiveState extends Equatable {
  final ConnectivityResult connectionStatus;
  final String message;
  @override
  List<Object?> get props => [
        connectionStatus,
        message,
      ];

  const ConnectivityLiveState(this.connectionStatus, this.message);

  ConnectivityLiveState copyWithStatus({
    required ConnectivityResult status,
  }) {
    final ous = ConnectivityLiveState(status, "");
    return ous;
  }
}

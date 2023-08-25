import 'package:equatable/equatable.dart';

import '../../../domain/entities/orga.dart';
import '../../../domain/entities/user.dart';

abstract class SideDrawerState extends Equatable {
  const SideDrawerState();

  @override
  List<Object> get props => [];
}

class SideDrawerEmpty extends SideDrawerState {}

class SideDrawerLoading extends SideDrawerState {}

class SideDrawerReady extends SideDrawerState {
  final List<String> opts;
  final List<Orga> orgaList;
  final User? user;
  final Orga? orga;
  final bool reload;
  final bool changedPage;
  const SideDrawerReady(this.opts, this.orgaList, this.orga, this.reload,
      this.changedPage, this.user);
  @override
  List<Object> get props =>
      [opts, orgaList, orga ?? "", reload, changedPage, user ?? ""];
}

class SideDrawerError extends SideDrawerState {
  final String message;
  const SideDrawerError(this.message);
  @override
  List<Object> get props => [message];
}

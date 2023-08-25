import 'package:equatable/equatable.dart';

import '../../../domain/entities/orga.dart';
import '../../../domain/entities/session.dart';
import '../../../domain/entities/user.dart';

abstract class SideDrawerEvent extends Equatable {
  const SideDrawerEvent();

  @override
  List<Object?> get props => [];
}

class OnSideDrawerLoading extends SideDrawerEvent {
  final User? user;
  final Orga? orga;
  final List<Orga> orgaList;
  final Session? session;
  const OnSideDrawerLoading(this.user, this.orga, this.orgaList, this.session);

  @override
  List<Object?> get props => [user, orga, orgaList, session];
}

class OnSideDrawerChangeOrga extends SideDrawerEvent {
  final String orgaId;
  final User user;
  const OnSideDrawerChangeOrga(this.orgaId, this.user);

  @override
  List<Object?> get props => [orgaId, user];
}

class OnSideDrawerReady extends SideDrawerEvent {
  final List<String> opts;
  final List<Orga> orgas;
  final Orga? orga;
  final User? user;
  final bool reload;
  final bool changedPage;
  const OnSideDrawerReady(this.opts, this.orgas, this.orga, this.reload,
      this.changedPage, this.user);
  @override
  List<Object> get props => [opts, orgas, orga!, reload, changedPage, user!];
}

class OnSideDrawerLogOff extends SideDrawerEvent {
  const OnSideDrawerLogOff();
}

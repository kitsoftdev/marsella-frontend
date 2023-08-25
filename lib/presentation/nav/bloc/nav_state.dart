// this is the state the user is expected to see

import 'package:equatable/equatable.dart';

///El estado de navegación considera el item seleccionado para navegar.
///
///El [selectedItem] indica cuál es la página donde deberíamos estar parados.

class NavState extends Equatable {
  const NavState(this.selectedItem, this.args);
  final Map<String, dynamic>? args;
  final NavItem selectedItem;
  @override
  List<Object> get props => [selectedItem, args ?? {}];

  static const listBoxPages = [
  ];

  static bool isBoxPage(NavItem item) => listBoxPages.contains(item);
}

// helpful navigation pages, you can change
// them to support your pages

///Enumeración con todas las páginas disponibles o posibles.
enum NavItem {
  pageUsers,
}

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/presentation/nav/bloc/nav_bloc.dart';
import 'package:marsellafrontend/presentation/nav/bloc/nav_state.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

Future<void> main() async {
  late NavBloc navBloc;
  late MockBuildContext mockContext;
  setUp(() {
    navBloc = NavBloc();

    mockContext = MockBuildContext();
  });

  const NavItem destination = NavItem.pageUsers;
}

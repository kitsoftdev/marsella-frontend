import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/core/constants.dart';

void main() {
  test('clase con lista de roles debe tener la cantidad de 5', () {
    //arrange
    const rolesWaited = 5;

    //act
    final roles = Roles.toList();

    //assert
    expect(roles.length, equals(rolesWaited));
  });
}

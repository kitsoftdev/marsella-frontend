import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/core/fakedata.dart';
import 'package:marsellafrontend/domain/entities/user.dart';
import 'package:marsellafrontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';

void main() {
  const tUser = User(
      id: '1',
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false,
      pictureUrl: null,
      pictureCloudFileId: null,
      pictureThumbnailUrl: null,
      pictureThumbnailCloudFileId: null);

  const tOnSideDrawerLoading = OnSideDrawerLoading(null, null, [], null);
  const t_OnSideDrawerLoading = OnSideDrawerLoading(null, null, [], null);
  const tOnSideDrawerChangeOrga = OnSideDrawerChangeOrga('', tUser);
  const t_OnSideDrawerChangeOrga = OnSideDrawerChangeOrga('', tUser);
  const tOnSideDrawerReady =
      OnSideDrawerReady([], [], null, false, false, null);
  const t_OnSideDrawerReady =
      OnSideDrawerReady([], [], null, false, false, null);
  const tOnSideDrawerLogOff = OnSideDrawerLogOff();
  const t_OnSideDrawerLogOff = OnSideDrawerLogOff();

  group('sidedrawer event', () {
    test('On SideDrawer Loading', () {
      //act
      final result = tOnSideDrawerLoading.props;
      final result2 = t_OnSideDrawerLoading.props;

      //assert
      expect(result, equals(result2));
    });

    test('On SideDrawer Change Orga', () {
      //act
      final result = tOnSideDrawerChangeOrga.props;
      final result2 = t_OnSideDrawerChangeOrga.props;

      //assert
      expect(result, equals(result2));
    });

    test('On SideDrawer Log Off', () {
      //act
      final result = tOnSideDrawerLogOff.props;
      final result2 = t_OnSideDrawerLogOff.props;

      //assert
      expect(result, equals(result2));
    });
  });
}

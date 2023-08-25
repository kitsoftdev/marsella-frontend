import 'package:flutter/material.dart';
import '../themes/marsella_themedata.dart';

class MarsellaSideMenuLargeLogo extends StatelessWidget {
  const MarsellaSideMenuLargeLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final shThemeBrightness = MarsellaTheme.of(context).themeData.brightness;

    String imageLocation = '';

    if (shThemeBrightness == Brightness.light) {
      imageLocation = 'assets/marsella_large_logo_light.png';
    } else {
      imageLocation = 'assets/marsella_large_logo_dark.png';
    }

    return Image.asset(
      imageLocation,
      width: 200,
      height: 48,
    );
  }
}

class MarsellaSideMenuLargeWormLogo extends StatelessWidget {
  const MarsellaSideMenuLargeWormLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final shThemeBrightness = MarsellaTheme.of(context).themeData.brightness;

    String imageLocation = '';

    if (shThemeBrightness == Brightness.light) {
      imageLocation = 'assets/marsella_large_logo_light_worm.png';
    } else {
      imageLocation = 'assets/marsella_large_logo_dark_worm.png';
    }

    return Image.asset(
      imageLocation,
      width: 35,
      height: 48,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_network/image_network.dart';
import 'package:marsellafrontend/core/themes/marsella_text_styles.dart';

import '../themes/marsella_themedata.dart';

class MarsellaPostData {
  final Color titleTextColor;
  final Color textContentColor;
  final Color sourceIconColor;
  final Color sourceTextColor;
  final Color categoryIconColor;
  final Color categoryTextColor;
  final Color backgroundColor;
  final Color secondBackgroundColor;
  final Color borderColor;

  const MarsellaPostData({
    required this.titleTextColor,
    required this.textContentColor,
    required this.sourceIconColor,
    required this.sourceTextColor,
    required this.categoryIconColor,
    required this.categoryTextColor,
    required this.backgroundColor,
    required this.secondBackgroundColor,
    required this.borderColor,
  });
}

class MarsellaPostTitle extends StatelessWidget {
  const MarsellaPostTitle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context).postData;

    return Text(
      text,
      style: MarsellaTextStyles.textPostTitle(shThemeData.titleTextColor),
    );
  }
}

class MarsellaPostStrongTitle extends StatelessWidget {
  const MarsellaPostStrongTitle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    final shThemeData = MarsellaTheme.of(context);

    return Text(
      text,
      style:
          MarsellaTextStyles.textPostTitle(shThemeData.textData.strongTextColor),
    );
  }
}

class MarsellaPostAvatar extends StatelessWidget {
  const MarsellaPostAvatar({
    super.key,
    this.imageURL,
    this.radius,
    this.imageBytes,
  });

  final String? imageURL;
  final double? radius;
  final Uint8List? imageBytes;
  @override
  Widget build(BuildContext context) {
    Widget avatar;
    final shThemeDataAll = MarsellaTheme.of(context);
    final double sizeX = 2 * (radius ?? 18);
    if (imageURL != null) {
      avatar = ClipOval(
        child: ImageNetwork(
          image: imageURL!,
          height: sizeX,
          width: sizeX,
        ),
      );
    } else if (imageBytes != null && imageBytes!.isNotEmpty) {
      avatar = CircleAvatar(
        radius: radius ?? 18,
        backgroundImage: MemoryImage(imageBytes!),
      );
    } else {
      avatar = Center(
        child: Icon(
          Icons.person,
          size: sizeX,
          color: shThemeDataAll.iconMenuColor.withOpacity(0.5),
        ),
      );
    }
    return Container(
      padding:
          const EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),
      alignment: Alignment.topLeft,
      child: avatar,
    );
  }
}

class MarsellaPostAvatarOrga extends StatelessWidget {
  const MarsellaPostAvatarOrga({
    super.key,
    this.imageURL,
    this.radius,
    this.imageBytes,
  });

  final String? imageURL;
  final double? radius;
  final Uint8List? imageBytes;
  @override
  Widget build(BuildContext context) {
    Widget avatar;
    final shThemeDataAll = MarsellaTheme.of(context);
    final double sizeX = 2 * (radius ?? 18);
    avatar = Center(
      child: Icon(
        Icons.business_outlined,
        size: sizeX,
        color: shThemeDataAll.iconMenuColor.withOpacity(0.5),
      ),
    );

    return Container(
      padding:
          const EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),
      alignment: Alignment.topLeft,
      child: avatar,
    );
  }
}

class MarsellaAddContenetAvatar extends StatelessWidget {
  const MarsellaAddContenetAvatar({
    super.key,
    this.imageURL,
  });

  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    final shThemeDataAll = MarsellaTheme.of(context);
    const double sizeX = 18;
    if (imageURL != null && imageURL != '') {
      avatar = ClipOval(
        child: ImageNetwork(
          image: imageURL!,
          height: sizeX,
          width: sizeX,
        ),
      );
    } else {
      avatar = Center(
        child: Icon(
          Icons.person,
          size: sizeX,
          color: shThemeDataAll.iconMenuColor.withOpacity(0.5),
        ),
      );
    }

    return Container(
      padding:
          const EdgeInsets.only(top: 1.0, left: 1.0, right: 16.0, bottom: 13.0),
      alignment: Alignment.topLeft,
      child: avatar,
    );
  }
}

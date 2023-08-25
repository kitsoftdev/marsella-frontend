import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:marsellafrontend/core/themes/marsella_colors.dart';

import '../themes/marsella_themedata.dart';

class MarsellaIconSource extends StatelessWidget {
  const MarsellaIconSource({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Octicons.link_external,
      size: 20,
      color: color,
    );
  }
}

class MarsellaIconVotePositive extends StatelessWidget {
  const MarsellaIconVotePositive({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 0.0, left: 0.0),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.14),
        child: Icon(
          FontAwesome.thumbs_up_alt,
          color: color,
          size: 23.0,
        ),
      ),
    );
  }
}

//const EdgeInsets.only(right: 24.0),
class MarsellaIconVoteNegative extends StatelessWidget {
  const MarsellaIconVoteNegative({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.thumbs_down_alt,
      color: color,
      size: 23.0,
    );
  }
}

class MarsellaIconShare extends StatelessWidget {
  const MarsellaIconShare({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      size: 20,
      Icons.share,
      color: color,
    );
  }
}

class MarsellaIconFavorite extends StatelessWidget {
  const MarsellaIconFavorite({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.star,
      color: color,
      size: 20.0,
    );
  }
}

class MarsellaIconBookmark extends StatelessWidget {
  const MarsellaIconBookmark({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.bookmark,
      color: color,
      size: 20.0,
    );
  }
}

class MarsellaIconComment extends StatelessWidget {
  const MarsellaIconComment({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.comment,
      color: color,
      size: 18.0,
    );
  }
}

class MarsellaIconDownload extends StatelessWidget {
  const MarsellaIconDownload({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.download,
      color: color,
      size: 16.0,
    );
  }
}

class MarsellaIconCategory extends StatelessWidget {
  const MarsellaIconCategory({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Elusive.tag, //FontAwesome.tag,
      size: 18,
      color: color,
    );
  }
}

class MarsellaIconDropdown extends StatelessWidget {
  const MarsellaIconDropdown({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Octicons.triangle_down, //Icons.arrow_drop_down,
      color: MarsellaColors.marsellaBlack,
    );
  }
}

class MarsellaIconSearch extends StatelessWidget {
  const MarsellaIconSearch({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      WebSymbols
          .search, //Entypo.search,//Octicons.search,//WebSymbols.search,//Icons.search,
      color: color,
      size: 22,
    );
  }
}

class MarsellaIconCancelSearch extends StatelessWidget {
  const MarsellaIconCancelSearch({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      WebSymbols
          .cancel_circle, //Entypo.search,//Octicons.search,//WebSymbols.search,//Icons.search,
      color: color,
      size: 22,
    );
  }
}

class MarsellaIconCancel extends StatelessWidget {
  const MarsellaIconCancel({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      WebSymbols
          .cancel_circle, //Entypo.search,//Octicons.search,//WebSymbols.search,//Icons.search,
      color: color,
      size: 22,
    );
  }
}

class MarsellaIconMenu extends StatelessWidget {
  const MarsellaIconMenu({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.menu,
      size: 22,
      weight: 15,
      color: color,
    );
  }
}

class MarsellaIconBack extends StatelessWidget {
  const MarsellaIconBack({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_back_sharp,
      size: 22,
      weight: 15,
      color: color,
    );
  }
}

class MarsellaIconCheck extends StatelessWidget {
  const MarsellaIconCheck({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check,
      size: 20,
      color: color,
    );
  }
}

class MarsellaIconEdit extends StatelessWidget {
  const MarsellaIconEdit({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.edit,
      size: 20,
      color: color,
    );
  }
}

class MarsellaIconClose extends StatelessWidget {
  const MarsellaIconClose({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.close,
      size: 22,
      color: color,
    );
  }
}

class MarsellaIconDelete extends StatelessWidget {
  const MarsellaIconDelete({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.delete,
      size: 22,
      color: color,
    );
  }
}

class MarsellaIconToggleOn extends StatelessWidget {
  const MarsellaIconToggleOn({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.toggle_on_rounded,
      color: color,
      size: 30,
    );
  }
}

class MarsellaIconToggleOff extends StatelessWidget {
  const MarsellaIconToggleOff({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.toggle_off_outlined,
      color: color,
      size: 30,
    );
  }
}

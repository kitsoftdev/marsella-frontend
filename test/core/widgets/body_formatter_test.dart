import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/core/model_container.dart';
import 'package:marsellafrontend/core/widgets/body_formatter.dart';
import 'package:marsellafrontend/core/widgets/scaffold_manager.dart';

void main() {}

class TestBodyFormatterPage extends StatelessWidget {
  const TestBodyFormatterPage(
      {Key? key, required this.widget, required this.screenWidth})
      : super(key: key);
  final Widget widget;
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return ScaffoldManager(
      child: SingleChildScrollView(
          child: Center(
              child: BodyFormatter(
        screenWidth: screenWidth,
        child: widget,
      ))),
    );
  }
}

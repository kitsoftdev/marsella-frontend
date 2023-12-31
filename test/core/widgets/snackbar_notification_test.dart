import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marsellafrontend/core/model_container.dart';
import 'package:marsellafrontend/core/widgets/body_formatter.dart';
import 'package:marsellafrontend/core/widgets/scaffold_manager.dart';
import 'package:marsellafrontend/core/widgets/snackbar_notification.dart';

void main() {}

class TestSnackBarNotifyPage extends StatelessWidget {
  const TestSnackBarNotifyPage({Key? key, required this.widget})
      : super(key: key);
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    // snackBarNotify(context, 'muestra!', Icons.image);

    return ScaffoldManager(
      child: SingleChildScrollView(child: widget),
    );
  }
}

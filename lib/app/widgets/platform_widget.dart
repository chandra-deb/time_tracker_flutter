import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class PlatformWidget extends StatelessWidget {
  const PlatformWidget({Key? key}) : super(key: key);

  Widget buildMaterialWidget(BuildContext context);
  Widget buildCupertinoWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildCupertinoWidget(context);
    }
    return buildMaterialWidget(context);
  }
}

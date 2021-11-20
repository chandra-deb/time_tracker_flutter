import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:time_tracker/app/widgets/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String defaultActionText;
  final String? cancelActionText;

  const PlatformAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.defaultActionText,
    this.cancelActionText,
  }) : super(key: key);

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog(
            context: context,
            builder: (_) => this,
          )
        : await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return this;
            },
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(
        content,
      ),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(
        content,
      ),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];
    if (cancelActionText != null) {
      actions.add(
        PlatformAlertDialogAction(
          child: Text(cancelActionText as String),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      );
    }
    actions.add(
      PlatformAlertDialogAction(
        child: Text(defaultActionText),
        onPressed: () => Navigator.of(context).pop(true),
      ),
    );

    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  final Widget child;
  final VoidCallback onPressed;
  const PlatformAlertDialogAction({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return ElevatedButton(
      child: child,
      onPressed: onPressed,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This is a factory class
// jis ka mtlb
abstract class CustomDialog {
  String getTitle();
  Widget create(BuildContext context);

  Future<void> show(BuildContext context) async {
    final dialog = create(context);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return dialog;
      },
    );
  }
}

class AndroidDialog extends CustomDialog {
  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(getTitle()),
      content: const Text('This is the material-style alert dialog!'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  String getTitle() {
    return "Android Dialog";
  }
}

class IosDialog extends CustomDialog {
  @override
  Widget create(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(getTitle()),
      content: const Text('This is the cupertino-style alert dialog!'),
      actions: <Widget>[
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  String getTitle() {
    return "iOS Dialog";
  }
}

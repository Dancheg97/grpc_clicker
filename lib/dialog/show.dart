import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

enum NotificationType {
  protoSaved,
  protoSaveError,
  protoParseError,
}

void showNotification(context, NotificationType type) {
  if (type == NotificationType.protoSaved) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: const Center(
        child: Text(
          'Proto file saved',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: 'This is Ignored',
      desc: 'This is also Ignored',
      btnOkOnPress: () {},
    ).show();
  }
}

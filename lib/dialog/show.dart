import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

const dialogWidth = 380.0;

enum NotificationType {
  protoSaved,
  protoSaveError,
  protoParseError,
}

void showNotification(context, NotificationType type) {
  if (type == NotificationType.protoSaved) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      title: 'Saved!',
      desc: 'You can explore that proto API definition in protos tab.',
      width: dialogWidth,
      showCloseIcon: true,
    ).show();
  }
  if (type == NotificationType.protoSaveError) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      title: 'Error!',
      desc: 'Unable to save proto, unknown error.',
      width: dialogWidth,
      showCloseIcon: true,
    ).show();
  }
  if (type == NotificationType.protoParseError) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      title: 'Error!',
      desc: 'Unable to parse proto file, check proto file.',
      width: dialogWidth,
      showCloseIcon: true,
    ).show();
  }
}

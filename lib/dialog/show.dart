import 'package:awesome_dialog/awesome_dialog.dart';

const dialogWidth = 380.0;
const showCloseIcon = true;

enum NotificationType {
  protoSaved,
  protoSaveError,
  protoParseError,
  protoPathExists,
}

void showNotification(context, NotificationType type) {
  if (type == NotificationType.protoSaved) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      headerAnimationLoop: false,
      title: 'Saved!',
      desc: 'You can explore that proto API definition in protos tab.',
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }
  if (type == NotificationType.protoSaveError) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      headerAnimationLoop: false,
      title: 'Error!',
      desc: 'Unable to save proto, unknown error.',
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }
  if (type == NotificationType.protoParseError) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      headerAnimationLoop: false,
      title: 'Error!',
      desc: 'Unable to parse proto file, check proto file.',
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }
  if (type == NotificationType.protoPathExists) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      headerAnimationLoop: false,
      title: 'Warning!',
      desc: 'You already added this proto file. You dont have to add it twice.',
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }
}

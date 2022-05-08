import 'package:awesome_dialog/awesome_dialog.dart';

const dialogWidth = 380.0;
const showCloseIcon = true;

enum NotificationType {
  protoSaved,
  protoSaveError,
  protoParseError,
  protoPathExists,
  adressSaved,
  adressExists,
  adressEmpty,
}

void showNotification(context, NotificationType type) {
  if (type == NotificationType.protoSaved) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      headerAnimationLoop: false,
      title: 'Proto path saved!',
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
      title: 'Save error!',
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
      title: 'Proto parsing error!',
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
      title: 'Proto path exists!',
      desc: 'Proto path saved. You dont have to add it twice.',
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }
  if (type == NotificationType.adressSaved) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      headerAnimationLoop: false,
      title: 'Adress saved!',
      desc: 'Later you can load it using load button.',
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }
  if (type == NotificationType.adressExists) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      headerAnimationLoop: false,
      title: 'Adress exists!',
      desc: 'Adress already saved. You dont have to add it again.',
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }
  if (type == NotificationType.protoParseError) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      headerAnimationLoop: false,
      title: 'Empty adress!',
      desc: 'It is impossible to save empty adress.',
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }
}

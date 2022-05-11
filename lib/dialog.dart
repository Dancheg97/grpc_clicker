import 'package:awesome_dialog/awesome_dialog.dart';

const dialogWidth = 380.0;
const showCloseIcon = true;

class Dialogue {
  static void protoSaved(context) {
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

  static void protoRemoved(context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO_REVERSED,
      headerAnimationLoop: false,
      title: 'Proto path removed!',
      desc: 'Proto path have been removed from.',
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }

  static void protoNothingToRemove(context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO_REVERSED,
      headerAnimationLoop: false,
      title: 'Nothing to remove!',
      desc: "Pick some proto to remove it's path.",
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }

  static void protoSaveError(context) {
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

  static void protoParseErr(context) {
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

  static void protoPathExists(context) {
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

  static void adressSaved(context) {
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

  static void adressExists(context) {
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

  static void adressEmpty(context) {
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

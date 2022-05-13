import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:grpc_clicker/data.dart';

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

  static Future addAdress(context) async {
    var controller = TextEditingController();
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      headerAnimationLoop: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Enter new adress'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              cursorColor: Palette.black,
              onEditingComplete: () async {
                Navigator.pop(context);
                var err = await Storage.addAdress(controller.text);
                if (err == 'exists') {
                  adressExists(context);
                  return;
                }
                if (err == 'nothing') {
                  adressEmpty(context);
                  return;
                }
                if (err != '') {
                  adressEmpty(context);
                  return;
                }
                adressSaved(context);
              },
              decoration: InputDecoration(
                hintText: 'rpc adress',
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.black, width: 0.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.black, width: 0.0),
                ),
                suffixIcon: IconButton(
                  color: Palette.black,
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  onPressed: () async {
                    Navigator.pop(context);
                    var err = await Storage.addAdress(controller.text);
                    if (err == 'exists') {
                      adressExists(context);
                      return;
                    }
                    if (err == 'nothing') {
                      adressEmpty(context);
                      return;
                    }
                    if (err != '') {
                      adressEmpty(context);
                      return;
                    }
                    adressSaved(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      width: dialogWidth,
      showCloseIcon: showCloseIcon,
    ).show();
  }
}

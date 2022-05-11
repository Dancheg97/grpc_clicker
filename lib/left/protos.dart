import 'package:grpc_rocket/dialog.dart';
import 'package:flutter/material.dart';
import 'package:grpc_rocket/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:grpc_rocket/data.dart';
import 'package:grpc_rocket/file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProtosTab extends StatefulWidget {
  const ProtosTab({Key? key}) : super(key: key);

  @override
  State<ProtosTab> createState() => _ProtosTabState();
}

class _ProtosTabState extends State<ProtosTab> {
  String? selectedValue;
  List<String> fileNames = [];
  List<String> filePathes = [];

  updateProtos() async {
    fileNames = await Storage.getProtoFiles();
    filePathes = await Storage.getProtoPathes();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    updateProtos();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              var path = await File.pick();
              if (path == '') {
                Dialogue.protoSaveError(context);
                return;
              }
              var rez = await Storage.addProtoPath(path);
              if (rez == 'exists') {
                Dialogue.protoPathExists(context);
                return;
              }
              updateProtos();
              Dialogue.protoSaved(context);
            },
            child: Icon(
              Icons.add_circle_rounded,
              color: Palette.white,
            ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: Palette.black,
              onPrimary: Palette.white,
            ),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                buttonDecoration: BoxDecoration(
                  color: Palette.white,
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                hint: Text(
                  ' Proto file',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: fileNames
                    .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style: const TextStyle(
                              fontSize: 14,
                            ))))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
                },
                buttonHeight: 40,
                buttonWidth: 140,
                itemHeight: 40,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (selectedValue == null) {
                Dialogue.protoNothingToRemove(context);
                return;
              }
              for (var path in filePathes) {
                if (path.endsWith(selectedValue!.substring(1))) {
                  Storage.removeProtoPath(path);
                }
              }
              Dialogue.protoRemoved(context);
              selectedValue = null;
              updateProtos();
            },
            child: Icon(
              Icons.remove_circle_rounded,
              color: Palette.white,
            ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: Palette.black,
              onPrimary: Palette.white,
            ),
          ),
        ],
      ),
    );
  }
}

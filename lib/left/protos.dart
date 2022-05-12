import 'dart:io';

import 'package:grpc_rocket/dialog.dart';
import 'package:flutter/material.dart';
import 'package:grpc_rocket/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:grpc_rocket/data.dart';
import 'package:grpc_rocket/file.dart';
import 'package:grpc_rocket/grpcurl.dart';
import 'package:grpc_rocket/providers.dart';
import 'package:provider/provider.dart';

class ProtosTab extends StatefulWidget {
  const ProtosTab({Key? key}) : super(key: key);

  @override
  State<ProtosTab> createState() => _ProtosTabState();
}

class _ProtosTabState extends State<ProtosTab> {
  String? selectedValue;
  List<String> filePathes = [];

  updateProtos() async {
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
              var rez = await Storage.addProto(path);
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
                items: filePathes.map((item) {
                  var short = ' ' + item.split(Platform.pathSeparator).last;
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      short,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
                value: selectedValue,
                onChanged: (path) async {
                  setState(() {
                    selectedValue = path as String;
                  });
                  if (path == null) {
                    Provider.of<ProtoProvider>(context, listen: false)
                        .change(ProtoStructure('', []));
                    return;
                  }
                  var proto = await Grpcurl.parseProto(context, path as String);
                  Provider.of<ProtoProvider>(context, listen: false)
                      .change(proto);
                  if (proto.error != '') {
                    Dialogue.protoParseErr(context);
                  }
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
              Storage.removeProto(selectedValue!);
              Dialogue.protoRemoved(context);
              selectedValue = null;
              updateProtos();
              Provider.of<ProtoProvider>(context, listen: false)
                  .change(ProtoStructure('', []));
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

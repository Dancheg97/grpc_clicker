import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:grpc_clicker/data.dart';
import 'package:grpc_clicker/dialog.dart';

class AdressesTab extends StatefulWidget {
  const AdressesTab({Key? key}) : super(key: key);

  @override
  State<AdressesTab> createState() => _AdressesTabState();
}

class _AdressesTabState extends State<AdressesTab> {
  String? currentAdress;
  List<String> filePathes = [];

  updateAdresses() async {
    filePathes = await Storage.getAdresses();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    updateAdresses();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              await Dialogue.addAdress(context);
              updateAdresses();
            },
            child: Icon(
              Icons.add_circle_rounded,
              color: Palette.black,
            ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: Palette.white,
              onPrimary: Palette.black,
              shadowColor: Palette.white,
              elevation: 0,
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
                  ' gRPC service adress',
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
                value: currentAdress,
                onChanged: (path) async {
                  setState(() {
                    currentAdress = path as String;
                  });
                  Storage.setCurrentAdress(path as String);
                },
                buttonHeight: 40,
                buttonWidth: 140,
                itemHeight: 40,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (currentAdress == null) {
                Dialogue.adressEmpty(context);
                return;
              }
              await Storage.removeAdress(currentAdress!);
              currentAdress = null;
              updateAdresses();
            },
            child: Icon(
              Icons.remove_circle_rounded,
              color: Palette.black,
            ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: Palette.white,
              onPrimary: Palette.black,
              shadowColor: Palette.white,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}

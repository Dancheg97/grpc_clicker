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

class AdressesTab extends StatefulWidget {
  const AdressesTab({Key? key}) : super(key: key);

  @override
  State<AdressesTab> createState() => _AdressesTabState();
}

class _AdressesTabState extends State<AdressesTab> {
  String? selectedValue;
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
            onPressed: () async {},
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
                value: selectedValue,
                onChanged: (path) async {
                  setState(() {
                    selectedValue = path as String;
                  });
                },
                buttonHeight: 40,
                buttonWidth: 140,
                itemHeight: 40,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {},
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

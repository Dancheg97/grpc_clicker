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
    return Container();
  }
}

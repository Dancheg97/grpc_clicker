import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:grpc_rocket/dialog/show.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkProto(String path) async {
  var callResult = await Process.run(
    'grpcurl',
    ['-import-path', '/', '-proto', path, 'describe'],
  );
  if (callResult.exitCode == 0) {
    return true;
  }
  return false;
}

Future<bool> addNewProto(context) async {
  try {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['proto'],
    );
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('proto_file_pathes')!;
    for (var protoPath in result!.paths) {
      if (kDebugMode) {
        print(protoPath);
      }
      protos.add(protoPath!);
      var checked = await checkProto(protoPath);
      if (!checked) {
        showNotification(context, NotificationType.protoParseError);
        return false;
      }
    }
    var saved = await prefs.setStringList('proto_file_pathes', protos);
    if (!saved) {
      throw Error();
    }
    showNotification(context, NotificationType.protoSaved);
    return true;
  } catch (e) {
    showNotification(context, NotificationType.protoSaveError);
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}

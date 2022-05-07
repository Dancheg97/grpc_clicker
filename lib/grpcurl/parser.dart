import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkProto(String path) async {
  return true;
}

Future<bool> addNewProto() async {
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
        throw Error();
      }
    }
    var saved = await prefs.setStringList('proto_file_pathes', protos);
    if (!saved) {
      throw Error();
    }
    return true;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}

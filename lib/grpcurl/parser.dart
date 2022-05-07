import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> addNewProto() async {
  try {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['proto'],
    );
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('proto_file_pathes')!;
    for (var element in result!.paths) {
      if (kDebugMode) {
        print(element);
      }
      protos.add(element!);
    }
    // TODO show good response
    return true;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    // TODO show bad response
    return false;
  }
}

import 'package:file_picker/file_picker.dart';

class File {
  static Future<String> pick() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['proto'],
    );
    if (result == null) {
      return '';
    }
    if (!result.isSinglePick) {
      return '';
    }
    return result.paths[0]!;
  }
}

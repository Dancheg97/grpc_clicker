import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void addNew() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['proto'],
  );
  var prefs = await SharedPreferences.getInstance();
  var protos = prefs.getStringList('proto_file_pathes');
  for (var element in result!.paths) {
    
  }
}

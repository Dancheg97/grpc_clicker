import 'package:file_picker/file_picker.dart';
import 'package:grpc_rocket/dialog/show.dart';
import 'package:grpc_rocket/grpcurl/check.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> addNewProto(context) async {
  try {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['proto'],
    );
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('proto_file_pathes')!;
    for (var protoPath in result!.paths) {
      if (protos.contains(protoPath!)) {
        showNotification(context, NotificationType.protoPathExists);
        return false;
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
    return false;
  }
}

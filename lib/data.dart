import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<List<String>> getProtoPathes() async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos') ?? [];
    return protos;
  }

  static void removeProtoPath(String path) async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos') ?? [];
    protos.remove(path);
    prefs.setStringList('protos', protos);
  }

  static void addProtoPath(String path) async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos') ?? [];
    protos.add(path);
    prefs.setStringList('protos', protos);
  }
}

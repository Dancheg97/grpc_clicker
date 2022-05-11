import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<List<String>> getProtoPathes() async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos') ?? [];
    return protos;
  }

  static Future<List<String>> getProtoFiles() async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos') ?? [];
    var rez = <String>[];
    for (var proto in protos) {
      rez.add(' ' + proto.split(Platform.pathSeparator).last);
    }
    return rez;
  }

  static void removeProtoPath(String path) async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos') ?? [];
    protos.remove(path);
    prefs.setStringList('protos', protos);
  }

  static Future<String> addProtoPath(String path) async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos') ?? [];
    if (protos.contains(path)) {
      return 'exists';
    }
    protos.add(path);
    prefs.setStringList('protos', protos);
    return '';
  }
}

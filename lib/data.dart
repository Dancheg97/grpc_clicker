import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<List<String>> getProtoPathes() async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos') ?? [];
    return protos;
  }

  static void removeProto(String path) async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos') ?? [];
    protos.remove(path);
    prefs.setStringList('protos', protos);
  }

  static Future<String> addProto(String path) async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('protos') ?? [];
    if (protos.contains(path)) {
      return 'exists';
    }
    protos.add(path);
    prefs.setStringList('protos', protos);
    return '';
  }

  static Future<List<String>> getAdresses() async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('adresses') ?? [];
    return protos;
  }

  static Future removeAdress(String adress) async {
    var prefs = await SharedPreferences.getInstance();
    var protos = prefs.getStringList('adresses') ?? [];
    protos.remove(adress);
    prefs.setStringList('adresses', protos);
  }

  static Future<String> addAdress(String adress) async {
    if (adress == '') {
      return 'nothing';
    }
    var prefs = await SharedPreferences.getInstance();
    var adresses = prefs.getStringList('adresses') ?? [];
    if (adresses.contains(adress)) {
      return 'exists';
    }
    adresses.add(adress);
    prefs.setStringList('adresses', adresses);
    return '';
  }

  static void setCurrentAdress(String adress) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('curAdress', adress);
  }

  static Future<String> getCurrentAdress() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('curAdress') ?? '';
  }

  static void setCurrentRequest(String request) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('curRequest', request);
  }

  static Future<String> getCurrentRequest() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('curRequest') ?? '';
  }

  static void setCurrentPath(String path) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('curPath', path);
  }

  static Future<String> getCurrentPath() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('curPath') ?? '';
  }

  static void setCurrentMethod(String path) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('curMethod', path);
  }

  static Future<String> getCurrentMethod() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('curMethod') ?? '';
  }
}

class RequestParams {
  late String protoPath;
  late String requstJson;
  late String adress;
  late String protoMethod;
  late String serviceView;
  late String methodView;
  RequestParams({
    required this.protoPath,
    required this.requstJson,
    required this.adress,
    required this.protoMethod,
    required this.serviceView,
    required this.methodView,
  });
  RequestParams.fromString(String source) {
    Map<String, dynamic> json = jsonDecode(source);
    protoPath = json['protoPath'];
    requstJson = json['requstJson'];
    adress = json['adress'];
    protoMethod = json['protoMethod'];
    serviceView = json['serviceView'];
    methodView = json['methodView'];
  }
  @override
  String toString() {
    Map<String, dynamic> json = {
      'protoPath': protoPath,
      'requstJson': requstJson,
      'adress': adress,
      'protoMethod': protoMethod,
      'serviceView': serviceView,
      'methodView': methodView,
    };
    return jsonEncode(json);
  }
}

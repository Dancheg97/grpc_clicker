import 'package:flutter/material.dart';
import 'package:grpc_rocket/grpcurl.dart';

class RequestProvider extends ChangeNotifier {
  late String request = '';
  late String description = '';
  void change(String newRequest, String newDescription) {
    request = newRequest;
    description = newDescription;
    notifyListeners();
  }
}

class ResponseProvider extends ChangeNotifier {
  late String resp = '';
  late String error = '';
  void change(String newResponse, String newErr) {
    resp = newResponse;
    error = newErr;
    notifyListeners();
  }
}

class ProtoProvider extends ChangeNotifier {
  late ProtoStructure structure = ProtoStructure('', []);
  void change(ProtoStructure newStructure) {
    structure = newStructure;
    notifyListeners();
  }
}

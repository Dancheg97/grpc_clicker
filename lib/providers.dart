import 'package:flutter/material.dart';
import 'package:grpc_clicker/grpcurl.dart';

class RequestProvider extends ChangeNotifier {
  late ProtoMethod method = ProtoMethod(
    protoName: '',
    inMessage: '',
    outMessage: '',
    protoPath: '',
  );
  late ProtoService service = ProtoService('', '', []);
  late ProtoStructure structure = ProtoStructure('initial', []);
  void change(
    ProtoMethod curMethod,
    ProtoService curService,
    ProtoStructure curStructure,
  ) {
    method = curMethod;
    service = curService;
    structure = curStructure;
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

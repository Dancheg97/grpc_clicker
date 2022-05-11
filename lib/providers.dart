import 'package:flutter/material.dart';

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

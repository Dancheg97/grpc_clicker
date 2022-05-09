import 'package:flutter/material.dart';

class RequestNotifier extends ChangeNotifier {
  late String request = '';
  void change(String newRequest) {
    request = newRequest;
    notifyListeners();
  }
}

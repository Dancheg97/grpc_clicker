import 'package:flutter/material.dart';

class RequestNotifier extends ChangeNotifier {
  late String _request = '';

  String get request => _request;

  void change(String request) {
    _request = request;
    notifyListeners();
  }
}

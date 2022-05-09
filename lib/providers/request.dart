import 'package:flutter/material.dart';

class RequestNotifier extends ChangeNotifier {
  late String request = '';
  late String description = '';
  void change(String newRequest, String newDescription) {
    request = newRequest;
    description = newDescription;
    notifyListeners();
  }
}

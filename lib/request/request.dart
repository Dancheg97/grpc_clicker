import 'package:flutter/material.dart';

class RequestPane extends StatelessWidget {
  final String adress;
  final String service;
  final String message;
  const RequestPane({
    Key? key,
    required this.adress,
    required this.service,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black,
        height: 111,
      ),
    );
  }
}

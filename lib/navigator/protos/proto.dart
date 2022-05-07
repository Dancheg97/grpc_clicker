import 'package:flutter/material.dart';

class InitialProto extends StatelessWidget {
  final String text;
  const InitialProto({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: Colors.black,
    );
  }
}

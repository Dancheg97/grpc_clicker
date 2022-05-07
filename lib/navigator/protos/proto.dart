import 'package:flutter/material.dart';

class ProtoDefinition extends StatelessWidget {
  final String protoPath;
  const ProtoDefinition({
    Key? key,
    required this.protoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: Colors.black,
    );
  }
}

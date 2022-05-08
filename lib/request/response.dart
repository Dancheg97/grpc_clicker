import 'package:flutter/material.dart';

class ResponsePane extends StatelessWidget {
  const ResponsePane({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.red,
        height: 111,
      ),
    );
  }
}

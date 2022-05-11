import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:grpc_rocket/colors.dart';
import 'package:grpc_rocket/left/protos.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Container(
        color: Palette.black,
        child: Column(
          children: [
            WindowTitleBarBox(
              child: MoveWindow(),
            ),
            const ProtosTab(),
            const Expanded(
              child: Center(
                child: Text('navigator'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

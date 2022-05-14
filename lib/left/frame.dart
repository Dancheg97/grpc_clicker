import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:grpc_clicker/left/protos.dart';
import 'package:grpc_clicker/left/structure.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      child: Scaffold(
        backgroundColor: Palette.black,
        body: Column(
          children: [
            WindowTitleBarBox(
              child: MoveWindow(
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 64,
                        endIndent: 64,
                        color: Palette.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const ProtosTab(),
            const Expanded(
              child: StructureTab(),
            ),
          ],
        ),
      ),
    );
  }
}

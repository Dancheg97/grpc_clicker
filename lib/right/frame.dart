import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:grpc_rocket/colors.dart';
import 'package:grpc_rocket/right/adresses.dart';
import 'package:grpc_rocket/right/winbuttons.dart';

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Palette.white,
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(child: MoveWindow()),
                  WindowButtons(),
                ],
              ),
            ),
            const AdressesTab(),
            const Expanded(
              child: Center(
                child: Text('right side'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:grpc_clicker/colors.dart';

class WindowButtons extends StatelessWidget {
  WindowButtons({Key? key}) : super(key: key);

  final buttonColors = WindowButtonColors(
    iconNormal: Palette.black,
    mouseOver: Palette.blueDark,
    mouseDown: Palette.blueDark,
    iconMouseOver: Palette.white,
    iconMouseDown: Palette.white,
  );

  final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFB71C1C),
    mouseDown: Palette.blueDark,
    iconNormal: Palette.black,
    iconMouseOver: Palette.white,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

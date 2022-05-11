import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:grpc_rocket/colors.dart';

class WindowButtons extends StatelessWidget {
  WindowButtons({Key? key}) : super(key: key);

  final buttonColors = WindowButtonColors(
    iconNormal: Palette.white,
    mouseOver: Palette.black,
    mouseDown: Palette.blueDark,
    iconMouseOver: Palette.white,
    iconMouseDown: Palette.white,
  );

  final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: Palette.white,
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

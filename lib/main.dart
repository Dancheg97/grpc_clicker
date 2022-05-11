import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:grpc_rocket/colors.dart';
import 'package:grpc_rocket/navigator/frame.dart';
import 'package:grpc_rocket/sender/frame.dart';
import 'package:grpc_rocket/sender/request.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(900, 650);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WindowBorder(
          color: PaletteBlack,
          width: 1,
          child: Row(
            children: const [
              LeftSide(),
              RightSide(),
            ],
          ),
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Container(
        color: PaletteBlack,
        child: Column(
          children: [
            WindowTitleBarBox(
              child: MoveWindow(),
            ),
            const Expanded(
              child: NavigatorFrame(),
            )
          ],
        ),
      ),
    );
  }
}

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              PaletteBlueLight,
              PaletteBlueDark,
            ],
            stops: [0.0, 1.0],
          ),
        ),
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
            const Expanded(
              child: Center(
                child: Text('requests'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  WindowButtons({Key? key}) : super(key: key);

  final buttonColors = WindowButtonColors(
    iconNormal: PaletteWhite,
    mouseOver: PaletteBlack,
    mouseDown: PaletteBlueDark,
    iconMouseOver: PaletteWhite,
    iconMouseDown: PaletteWhite,
  );

  final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: PaletteWhite,
    iconMouseOver: PaletteWhite,
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

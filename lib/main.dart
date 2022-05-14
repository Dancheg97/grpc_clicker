import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:grpc_clicker/left/frame.dart';
import 'package:grpc_clicker/providers.dart';
import 'package:grpc_clicker/right/frame.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) {
        return RequestProvider();
      }),
      ChangeNotifierProvider(create: (context) {
        return ResponseProvider();
      }),
      ChangeNotifierProvider(create: (context) {
        return ProtoProvider();
      }),
    ],
    child: const MyApp(),
  ));
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1200, 700);
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
          color: Palette.black,
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

import 'package:flutter/material.dart';
import 'package:grpc_rocket/navigator/frame.dart';
import 'package:grpc_rocket/providers/request.dart';
import 'package:grpc_rocket/sender/frame.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RequestNotifier()),
        ChangeNotifierProvider(create: (context) => ResponseNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        dividerTheme: DividerThemeData(
          color: Colors.blueGrey[200],
          thickness: 3,
        ),
      ),
      home: Scaffold(
        body: MultiSplitViewTheme(
          data: MultiSplitViewThemeData(
            dividerPainter: DividerPainters.background(
              color: Colors.blueGrey[200],
              highlightedColor: Colors.blueGrey[500],
            ),
            dividerThickness: 3,
          ),
          child: MultiSplitView(
            initialAreas: [
              Area(weight: 0.26, minimalSize: 272),
              Area(minimalSize: 520),
            ],
            children: const [
              NavigatorFrame(),
              RequstFrame(),
            ],
          ),
        ),
      ),
    );
  }
}

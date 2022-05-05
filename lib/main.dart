import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        body: MultiSplitView(
          dividerBuilder:
              (axis, index, resizable, dragging, highlighted, themeData) {
            return Container(
              color: dragging ? Colors.grey[300] : Colors.grey[100],
              child: Icon(
                Icons.drag_indicator,
                color: highlighted ? Colors.grey[600] : Colors.grey[400],
              ),
            );
          },
          children: [
            Container(
              color: Colors.black,
            ),
            Container(
              color: Colors.blueGrey,
            )
          ],
          initialAreas: [
            Area(
              weight: 0.20,
              minimalSize: 272,
            ),
            Area(
              minimalSize: 920,
            ),
          ],
        ),
      ),
    );
  }
}

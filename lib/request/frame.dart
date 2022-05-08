import 'package:flutter/material.dart';
import 'package:grpc_rocket/navigator/frame.dart';
import 'package:grpc_rocket/request/request.dart';
import 'package:grpc_rocket/request/response.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:grpc_rocket/request/adress.dart';

class RequstFrame extends StatelessWidget {
  const RequstFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Flexible(
              child: AdressPanel(),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send_rounded),
            ),
          ],
        ),
        MultiSplitViewTheme(
          data: MultiSplitViewThemeData(
            dividerPainter: DividerPainters.background(
              color: Colors.blueGrey[200],
              highlightedColor: Colors.blueGrey[500],
            ),
            dividerThickness: 3,
          ),
          child: MultiSplitView(
            initialAreas: [
              Area(weight: 0.5, minimalSize: 150),
              Area(minimalSize: 150),
            ],
            children: const [
              RequestPane(),
              ResponsePane(),
            ],
          ),
        ),
      ],
    );
  }
}

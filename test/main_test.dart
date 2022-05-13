import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grpc_clicker/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('gRPC Clicker'), findsOneWidget);
    expect(find.text('ahalai mahalai'), findsNothing);

    // await tester.tap(find.byIcon(Icons.add_rounded));
    // await tester.pump();
  });
}

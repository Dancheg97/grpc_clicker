import 'package:flutter/material.dart';
import 'package:json_editor/json_editor.dart';

class RequestPane extends StatelessWidget {
  const RequestPane({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey[500]!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: JsonEditor.string(
              jsonString: 'nan',
              onValueChanged: (value) {
                print(value);
              },
            ),
          ),
        ),
      ),
    );
    // return Consumer<RequestNotifier>(
    //   builder: (context, model, child) {

    //   },
    // );
  }
}

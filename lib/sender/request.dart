import 'package:flutter/material.dart';
import 'package:grpc_rocket/providers/request.dart';
import 'package:json_editor/json_editor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestPane extends StatelessWidget {
  const RequestPane({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 22),
        Center(
          child: Text(
            'gRPC-request',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey[500]!,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<RequestNotifier>(
                  builder: (context, model, child) {
                    return JsonEditor.string(
                      jsonString: model.request,
                      onValueChanged: (value) async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString('req', value.toString());
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            'grpcurl description',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey[500]!,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<RequestNotifier>(
                  builder: (context, model, child) {
                    return JsonEditor.string(
                      jsonString: model.description,
                      onValueChanged: (value) {},
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:grpc_rocket/providers/response.dart';
import 'package:provider/provider.dart';

class ResponsePane extends StatelessWidget {
  const ResponsePane({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 22),
        Center(
          child: Text(
            'gRPC-response',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Consumer<ResponseNotifier>(
              builder: (context, model, child) {
                return ResponseTextField(
                  key: UniqueKey(),
                  response: model.resp,
                  error: model.error,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ResponseTextField extends StatefulWidget {
  final String response;
  final String error;
  const ResponseTextField({
    Key? key,
    required this.response,
    required this.error,
  }) : super(key: key);

  @override
  State<ResponseTextField> createState() => _ResponseTextFieldState();
}

class _ResponseTextFieldState extends State<ResponseTextField> {
  var controller = TextEditingController();

  @override
  void initState() {
    controller.text = '''
Response:
${widget.response}
Error:
${widget.error}
    ''';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      expands: true,
      readOnly: true,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: 'no response',
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}

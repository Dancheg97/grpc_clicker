import 'package:flutter/material.dart';
import 'package:grpc_rocket/providers/request.dart';
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
            padding: const EdgeInsets.all(24.0),
            child: Consumer<RequestNotifier>(
              builder: (context, model, child) {
                return RequestTextField(
                  key: UniqueKey(),
                  startText: model.request,
                  saveName: model.description,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class RequestTextField extends StatefulWidget {
  final String startText;
  final String saveName;
  const RequestTextField({
    Key? key,
    required this.startText,
    required this.saveName,
  }) : super(key: key);

  @override
  State<RequestTextField> createState() => _RequestTextFieldState();
}

class _RequestTextFieldState extends State<RequestTextField> {
  var controller = TextEditingController();

  loadCachedReq() async {
    var prefs = await SharedPreferences.getInstance();
    var cached = prefs.getString(widget.saveName);
    if (cached != null) {
      controller.text = cached;
    }
    prefs.setString('req', controller.text);
  }

  @override
  void initState() {
    controller.text = widget.startText;
    super.initState();
    loadCachedReq();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      expands: true,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: 'grpcurl input',
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onChanged: (text) async {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('req', text);
        prefs.setString(widget.saveName, text);
      },
    );
  }
}

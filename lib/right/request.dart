import 'package:flutter/material.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:grpc_clicker/grpcurl.dart';
import 'package:grpc_clicker/providers.dart';
import 'package:provider/provider.dart';

class RequestTab extends StatelessWidget {
  const RequestTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestProvider>(
      builder: (context, proto, child) {
        if (proto.structure.path == '') {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 377),
            child: Expanded(
              key: UniqueKey(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.album_outlined,
                    color: Palette.blackQ,
                    size: 72,
                  ),
                  const Text(
                    'select message',
                  ),
                ],
              ),
            ),
          );
        }
        var controller = TextEditingController();
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 377),
          child: Expanded(
            key: UniqueKey(),
            child: Column(
              children: [
                Divider(
                  color: Palette.black,
                  indent: 32,
                  endIndent: 32,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.language_rounded,
                          size: 16,
                          color: Palette.black,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          proto.method.inMessage.split('.').last,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                MessageFieldsTab(
                  protoPath: proto.structure.path,
                  msgName: proto.method.inMessage,
                  controller: controller,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.top,
                      cursorColor: Palette.black,
                      decoration: InputDecoration(
                        hintText: 'gRPC request',
                        contentPadding: const EdgeInsets.all(15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Palette.black, width: 0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Palette.black, width: 0.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MessageFieldsTab extends StatefulWidget {
  final String protoPath;
  final String msgName;
  final TextEditingController controller;
  const MessageFieldsTab({
    Key? key,
    required this.protoPath,
    required this.msgName,
    required this.controller,
  }) : super(key: key);

  @override
  State<MessageFieldsTab> createState() => _MessageFieldsTabState();
}

class _MessageFieldsTabState extends State<MessageFieldsTab> {
  List<Widget> descriptionFields = [];

  updateFields() async {
    if (widget.protoPath == '') {
      descriptionFields = [];
      return;
    }
    var protoFields = await Grpcurl.message(widget.protoPath, widget.msgName);
    for (var field in protoFields.fields) {
      var add = '';
      if (field.optional) {
        add = ' (optional)';
      }
      descriptionFields.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Icon(
              Icons.circle,
              color: Palette.black,
              size: 11,
            ),
            const SizedBox(width: 6),
            Text(field.type.split('.').last + ' - ' + field.name + add)
          ],
        ),
      ));
    }
    widget.controller.text = Grpcurl.json(protoFields);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    updateFields();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: descriptionFields,
      ),
    );
  }
}

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
            child: Column(
              key: UniqueKey(),
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
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 377),
          child: Column(
            key: UniqueKey(),
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
              ),
            ],
          ),
        );
      },
    );
  }
}

class MessageFieldsTab extends StatefulWidget {
  final String protoPath;
  final String msgName;
  const MessageFieldsTab({
    Key? key,
    required this.protoPath,
    required this.msgName,
  }) : super(key: key);

  @override
  State<MessageFieldsTab> createState() => _MessageFieldsTabState();
}

class _MessageFieldsTabState extends State<MessageFieldsTab> {
  List<Widget> fields = [];

  updateFields() async {
    if (widget.protoPath == '') {
      fields = [];
      return;
    }
    var rez = await Grpcurl.message(widget.protoPath, widget.msgName);
  }

  @override
  void initState() {
    super.initState();
    updateFields();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields,
    );
  }
}

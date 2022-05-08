import 'package:flutter/material.dart';
import 'package:grpc_rocket/grpcurl/parse.dart';

class ProtoDefinition extends StatefulWidget {
  final String protoPath;
  const ProtoDefinition({
    Key? key,
    required this.protoPath,
  }) : super(key: key);

  @override
  State<ProtoDefinition> createState() => _ProtoDefinitionState();
}

class _ProtoDefinitionState extends State<ProtoDefinition> {
  @override
  void initState() {
    super.initState();
    parseProto(context, widget.protoPath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.black,
    );
  }
}

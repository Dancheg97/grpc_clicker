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
  Widget current = Container();

  loadProto() async {
    List<Widget> elems = [];
    var services = await parseProto(context, widget.protoPath);
    for (var service in services) {
      elems.add(ProtoTile(
        name: service.name,
        icon: Icons.account_tree_rounded,
        indent: 0,
      ));
      for (var method in service.methods) {
        elems.add(ProtoTile(
          name: method.name,
          icon: Icons.send_rounded,
          indent: 8,
        ));
        elems.add(ProtoTile(
          name: method.inMessage,
          icon: Icons.label_important_outline_rounded,
          indent: 16,
        ));
        elems.add(ProtoTile(
          name: method.outMessage,
          icon: Icons.label_important_outline_rounded,
          indent: 16,
        ));
      }
    }
    setState(() {
      current = Column(
        children: elems,
        mainAxisSize: MainAxisSize.min,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    loadProto();
  }

  @override
  Widget build(BuildContext context) {
    return current;
  }
}

class ProtoTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final double indent;
  const ProtoTile({
    Key? key,
    required this.name,
    required this.icon,
    required this.indent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: indent),
        Icon(icon),
        Text(name),
      ],
    );
  }
}

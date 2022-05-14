import 'package:flutter/material.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:grpc_clicker/data.dart';
import 'package:grpc_clicker/grpcurl.dart';
import 'package:grpc_clicker/providers.dart';
import 'package:provider/provider.dart';

class MethodTab extends StatelessWidget {
  final ProtoMethod method;
  final ProtoService service;
  final ProtoStructure structure;
  const MethodTab({
    Key? key,
    required this.method,
    required this.service,
    required this.structure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
        onPressed: () async {
          Provider.of<RequestProvider>(context, listen: false)
              .change(method, service, structure);
          Storage.setCurrentMethod(method.protoName);
          Storage.setCurrentPath(structure.path);
        },
        child: SizedBox(
          width: 225,
          child: Row(
            children: [
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Palette.white,
                size: 12,
              ),
              const SizedBox(width: 6),
              Text(
                method.protoName,
                style: TextStyle(color: Palette.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

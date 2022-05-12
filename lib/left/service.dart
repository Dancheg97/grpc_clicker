import 'package:flutter/material.dart';
import 'package:grpc_rocket/grpcurl.dart';
import 'package:grpc_rocket/left/method.dart';

class ServiceTab extends StatelessWidget {
  final ProtoService service;
  const ServiceTab({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const VerticalDivider(),
        Column(
          children: service.methods.map((e) {
            return MethodTab(method: e);
          }).toList(),
        ),
      ],
    );
  }
}

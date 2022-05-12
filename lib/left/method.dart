import 'package:flutter/material.dart';
import 'package:grpc_rocket/grpcurl.dart';

class MethodTab extends StatelessWidget {
  final ProtoMethod method;
  const MethodTab({
    Key? key,
    required this.method,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(method.protoName);
  }
}

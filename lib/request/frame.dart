import 'package:flutter/material.dart';
import 'package:grpc_rocket/request/adress.dart';

class RequstFrame extends StatelessWidget {
  const RequstFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AdressPanel(),
      ],
    );
  }
}

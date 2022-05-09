import 'package:flutter/material.dart';
import 'package:grpc_rocket/grpcurl/request.dart';
import 'package:grpc_rocket/sender/request.dart';
import 'package:grpc_rocket/sender/response.dart';
import 'package:grpc_rocket/sender/adress.dart';

class RequstFrame extends StatelessWidget {
  const RequstFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Flexible(
              child: AdressPanel(),
            ),
            IconButton(
              onPressed: () async {
                sendRequst();
              },
              icon: const Icon(Icons.send_rounded),
            ),
          ],
        ),
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              children: const [
                Expanded(
                  child: RequestPane(),
                ),
                VerticalDivider(
                  indent: 15,
                  endIndent: 15,
                ),
                Expanded(
                  child: ResponsePane(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

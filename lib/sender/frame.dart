import 'package:flutter/material.dart';
import 'package:grpc_rocket/grpcurl/send.dart';
import 'package:grpc_rocket/providers/response.dart';
import 'package:grpc_rocket/sender/request.dart';
import 'package:grpc_rocket/sender/response.dart';
import 'package:grpc_rocket/sender/adress.dart';
import 'package:provider/provider.dart';

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
                var rez = await sendRequst();
                Provider.of<ResponseNotifier>(context, listen: false).change(
                  rez.result,
                  rez.error,
                );
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

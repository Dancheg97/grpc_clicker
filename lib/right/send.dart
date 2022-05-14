import 'package:flutter/material.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:grpc_clicker/data.dart';
import 'package:grpc_clicker/grpcurl.dart';
import 'package:grpc_clicker/providers.dart';
import 'package:provider/provider.dart';

class SendButton extends StatelessWidget {
  const SendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.black,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: TextButton(
            child: SizedBox(
              width: 32,
              height: double.infinity,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Palette.white,
                size: 32,
              ),
            ),
            onPressed: () async {
              var response = await Grpcurl.sendRequest(
                path: await Storage.getCurrentPath(),
                req: await Storage.getCurrentRequest(),
                adress: await Storage.getCurrentAdress(),
                method: await Storage.getCurrentMethod(),
              );
              Provider.of<ResponseProvider>(context, listen: false)
                  .change(response);
            },
          ),
        ),
      ),
    );
  }
}

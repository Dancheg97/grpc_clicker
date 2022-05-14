import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:grpc_clicker/right/adresses.dart';
import 'package:grpc_clicker/right/request.dart';
import 'package:grpc_clicker/right/response.dart';
import 'package:grpc_clicker/right/send.dart';
import 'package:grpc_clicker/right/winbuttons.dart';

class RightSide extends StatelessWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Palette.white,
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(
                    child: MoveWindow(
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              indent: 36,
                              endIndent: 36,
                              color: Palette.black,
                            ),
                          ),
                          const Text('gRPC Clicker'),
                          Expanded(
                            child: Divider(
                              indent: 36,
                              endIndent: 36,
                              color: Palette.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  WindowButtons(),
                ],
              ),
            ),
            const AdressesTab(),
            Divider(
              color: Palette.black,
              indent: 32,
              endIndent: 32,
            ),
            Expanded(
              child: IntrinsicHeight(
                child: Row(
                  children: const [
                    Expanded(
                      child: RequestTab(),
                    ),
                    SendButton(),
                    Expanded(
                      child: ResponseTab(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

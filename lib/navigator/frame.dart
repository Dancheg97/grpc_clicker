import 'package:flutter/material.dart';
import 'package:grpc_rocket/navigator/head.dart';

class NavigatorFrame extends StatelessWidget {
  const NavigatorFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadSwitch(
          goToApis: () {
            print('');
          },
          goToHistory: () {},
          goToTests: () {},
        ),
        const Divider(),
        const Spacer(),
      ],
    );
  }
}

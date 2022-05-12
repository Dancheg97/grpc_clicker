import 'package:flutter/material.dart';
import 'package:grpc_rocket/colors.dart';
import 'package:grpc_rocket/providers.dart';
import 'package:provider/provider.dart';

class Structure extends StatelessWidget {
  const Structure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProtoProvider>(
        key: UniqueKey(),
        builder: (context, proto, child) {
          if (proto.path == '') {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_upward_rounded,
                  size: 32,
                  color: Palette.whiteQ,
                ),
                const SizedBox(height: 12),
                Text(
                  'choose proto file above',
                  style: TextStyle(
                    color: Palette.whiteQ,
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

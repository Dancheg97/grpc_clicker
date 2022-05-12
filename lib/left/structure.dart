import 'package:flutter/material.dart';
import 'package:grpc_rocket/colors.dart';
import 'package:grpc_rocket/providers.dart';
import 'package:provider/provider.dart';

class StructureTab extends StatefulWidget {
  const StructureTab({Key? key}) : super(key: key);

  @override
  State<StructureTab> createState() => _StructureTabState();
}

class _StructureTabState extends State<StructureTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProtoProvider>(
      builder: (context, proto, child) {
        if (proto.path == '') {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 377),
            switchInCurve: Curves.easeIn,
            child: Column(
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
            ),
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 377),
          switchInCurve: Curves.easeIn,
          child: Container(
            key: UniqueKey(),
            color: Colors.white,
            width: 100,
            height: 100,
          ),
        );
      },
    );
  }
}

// class ServiceTab extends StatelessWidget {
//   const ServiceTab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class MethodTab extends StatelessWidget {
//   const MethodTab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

import 'package:flutter/material.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:grpc_clicker/left/service.dart';
import 'package:grpc_clicker/providers.dart';
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
        if (proto.structure.error != '') {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 377),
            switchInCurve: Curves.easeIn,
            child: Column(
              key: UniqueKey(),
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 32,
                  color: Palette.whiteQ,
                ),
                const SizedBox(height: 12),
                Text(
                  'unable to parse proto',
                  style: TextStyle(
                    color: Palette.whiteQ,
                  ),
                ),
              ],
            ),
          );
        }
        if (proto.structure.services.isEmpty) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 377),
            switchInCurve: Curves.easeIn,
            child: Column(
              key: UniqueKey(),
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
          child: SingleChildScrollView(
            key: UniqueKey(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: proto.structure.services.map((service) {
                return ServiceTab(
                  service: service,
                  structure: proto.structure,
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

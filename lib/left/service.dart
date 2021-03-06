import 'package:flutter/material.dart';
import 'package:grpc_clicker/colors.dart';
import 'package:grpc_clicker/grpcurl.dart';
import 'package:grpc_clicker/left/method.dart';

class ServiceTab extends StatelessWidget {
  final ProtoService service;
  final ProtoStructure structure;
  const ServiceTab({
    Key? key,
    required this.service,
    required this.structure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Palette.white,
                    indent: 16,
                    endIndent: 16,
                  ),
                ),
                Icon(
                  Icons.account_tree_rounded,
                  color: Palette.white,
                  size: 16,
                ),
                const SizedBox(width: 12),
                Text(
                  service.showName,
                  style: TextStyle(
                    color: Palette.white,
                    fontSize: 15,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Palette.white,
                    indent: 16,
                    endIndent: 16,
                  ),
                ),
              ],
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(color: Palette.white),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: service.methods.map((method) {
                        return MethodTab(
                          method: method,
                          service: service,
                          structure: structure,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

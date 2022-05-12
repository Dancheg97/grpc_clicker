import 'package:flutter/material.dart';
import 'package:grpc_rocket/colors.dart';
import 'package:grpc_rocket/grpcurl.dart';
import 'package:grpc_rocket/left/method.dart';

class ServiceTab extends StatelessWidget {
  final ProtoService service;
  const ServiceTab({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: Palette.white,
              indent: 16,
              endIndent: 16,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.account_tree_rounded,
                      color: Palette.white,
                      size: 16,
                    ),
                  ),
                  Text(
                    service.showName,
                    style: TextStyle(
                      color: Palette.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(color: Palette.white),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: service.methods.map((e) {
                        return MethodTab(method: e);
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
